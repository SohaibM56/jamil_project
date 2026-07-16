# Firestore Schema (planned)

Two top-level collections, split by visibility: `users` is private (owner-only),
`cards` is public (readable by anyone, writable only by the owner). This split
is what lets the public card page read Firestore directly with no login and no
Cloud Function in between.

## `users/{uid}`

Private account data. `uid` is the Firebase Auth UID.

| Field       | Type      | Notes                                              |
|-------------|-----------|-----------------------------------------------------|
| `email`     | string    | Mirrors Firebase Auth; convenient for queries.       |
| `phone`     | string    | Collected at signup.                                 |
| `name`      | string    | Collected at signup; initial value for the card.     |
| `cardId`    | string    | Points at this user's `cards/{cardId}` doc.          |
| `settings`  | map       | `{ darkMode: bool }` — cross-device app preferences. |
| `createdAt` | timestamp | Server timestamp, set on signup.                     |

**Rule:** `allow read, write: if request.auth != null && request.auth.uid == uid;`

## `cards/{cardId}`

The public digital business card. `cardId` is a random ID generated once at
signup (e.g. via `uuid` or Firestore's auto-ID) — deliberately *not* the same
as `uid`, so the public URL never exposes the Auth UID and the ID can be
rotated later without touching the account.

| Field             | Type      | Notes                                                          |
|-------------------|-----------|-----------------------------------------------------------------|
| `ownerUid`         | string    | Firebase Auth UID of the owner. Used by the write rule.         |
| `name`             | string    | Shown on the card.                                               |
| `title`            | string    | e.g. "Engineer".                                                 |
| `phone`            | string    | Shown on the card.                                               |
| `email`            | string    | Shown on the card. Can differ from the Auth login email.         |
| `profileImageUrl`  | string    | Firebase Storage download URL (avatar upload is not built yet).  |
| `links`            | map       | Keyed by platform, see below.                                    |
| `updatedAt`        | timestamp | Server timestamp, bumped on every edit.                          |

### `links` map shape

One entry per social platform the user has touched, keyed by a fixed platform
id (`whatsapp`, `instagram`, `tiktok`, `facebook`, `linkedin`, `snapchat`,
`telegram`, `x`, `youtube`):

```json
"links": {
  "instagram": {
    "url": "https://instagram.com/example",
    "visibleOnCard": true,
    "addedAt": "<timestamp>"
  }
}
```

This replaces the app's current `profileLinks` (show-on-card toggle) and
`socialLinks`/`socialLinkUrls` (configured-URL state) — today those are three
separate maps on `DashboardController` that aren't linked to each other, which
lets a platform show as "on" on the card with no URL behind it. One map per
platform removes that gap: a link only appears as toggleable once it has a
`url`, and `visibleOnCard` is the single source of truth for what the public
page renders.

**Rule:**
```
allow read: if true;
allow write: if request.auth != null && request.auth.uid == resource.data.ownerUid;
```

## Public card page read path

The React app on Firebase Hosting reads exactly one document per page view:
`cards/{cardId}` where `cardId` comes from the URL
(`https://<domain>/#/{cardId}`). It renders `name`/`title`/`phone`/`email`/
`profileImageUrl`, then iterates `links` and shows only entries where
`visibleOnCard == true`, linking out to `url`. No Cloud Function, no auth
token — the security rule above is what makes this safe to read publicly
while keeping writes locked to the owner.

## Efficiency & access pattern notes

Firestore bills per document read/write (not per field, not per byte up to the
1MiB doc limit) and has no joins — so the schema above is shaped around one
question per screen: *can this render from a single document read?*

- **Why `links` is a map, not a subcollection:** the platform list is small and
  fixed (9 known platforms), so it comfortably fits in one document. Reading
  the public card page is exactly one `get()`. A subcollection would turn that
  into 1 + N reads for no benefit — subcollections only pay off for unbounded,
  independently-paginated lists, which this isn't.
- **Why `cards` is a top-level collection, not `users/{uid}/card/{cardId}`:**
  no cost difference either way, but a top-level collection keeps the public
  URL to one opaque segment (no uid in the path) and leaves room for a future
  query across all cards without reaching into every user's subcollection.
- **Security rules cost nothing extra here:** the `cards` write rule checks
  `resource.data.ownerUid` (the document being written itself), not an
  external `get()` on another doc. Rules that call `get()` on a different
  document to check permissions add a billed read to every request — avoid
  that pattern unless there's no alternative.
- **Write with dot-paths, not whole-document overwrites.** Toggling one
  platform's visibility should be
  `cardRef.update({'links.instagram.visibleOnCard': true})`, not
  `cardRef.set(entireLinksMapFromLocalState)`. Same write cost, but it can't
  clobber a concurrent edit to a different platform.
- **`get()` for visitors, `onSnapshot()` only for the owner.** The public page
  doesn't need live updates mid-visit — a one-shot read per view is the right
  default (and the SDK caches repeat visits automatically). The owner's own
  Account tab is the one place a live listener is worth it, so edits reflect
  instantly if they have the app open on two devices.
- **`cardId` as an auto-generated ID, not a vanity slug.** A vanity slug needs
  a uniqueness check (a read, often inside a transaction) before every
  signup. Firestore's auto-ID collision probability is low enough to skip that
  check — one less read and no transaction on the signup path. Vanity URLs
  can always be layered on top later as an optional alias, not a requirement.

## Not modeled yet (flag if/when needed)

- View/click analytics per card (would need a write path open to unauthenticated
  visitors, or funnel through a Cloud Function to avoid write-abuse).
- Account deletion cleanup (delete `users/{uid}` + `cards/{cardId}` + the Auth
  user together — needs a Cloud Function or a client-side batch, since Firestore
  doesn't cascade-delete).
- Card ID rotation (issuing a new `cardId` and retiring the old one).
