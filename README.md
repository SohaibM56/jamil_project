# Jamil Project - Digital Business Card Solutions

A modern, high-performance Flutter application designed for seamless professional networking. Jamil Project allows users to create, manage, and share digital business cards using cutting-edge technologies like QR codes and NFC.

## ✨ Core Features

- **📇 Personalized Digital Profiles**: Create a professional identity with custom names, titles, and profile photos.
- **🔗 Unified Link Hub**: Centralize all your professional presence including social media (LinkedIn, Twitter, etc.), websites, and contact details.
- **📱 Instant Sharing via QR**: Generate high-quality, customizable QR codes that point directly to your digital card.
- **📡 NFC Touch-and-Go**: Write your profile URL to NFC tags/cards for the ultimate "tap-to-connect" experience.
- **☁️ Real-time Cloud Sync**: Powered by Firebase, ensuring your profile updates are instantly visible across all platforms.
- **🔐 Secure & Private**: Built-in Firebase Authentication with secure account management and data deletion protocols.
- **🎨 Premium UI/UX**: Optimized with custom typography (Satoshi & Clash Display) and a responsive design that adapts to any screen size.

---

## 🚀 Getting Started

1.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

2.  **Run the App:**
    ```bash
    flutter run
    ```

---

## 📂 Project Architecture

This project follows a strict **MVVM (Model-View-ViewModel)** architecture using **GetX** for state management, navigation, and dependency injection.

- `lib/src/mvvm/`: Core logic and UI.
  - `viewModels/`: `GetxController`s handling business logic and state.
  - `views/`: `GetView` widgets for the UI layer.
- `lib/src/repos/`: Repository layer abstraction (Auth, Card, Storage) mediating between controllers and Firebase.
- `lib/src/models/`: Type-safe data models mirroring Firestore documents.
- `lib/src/config/`: Centralized routing, theme, assets, and DI bindings.
- `lib/src/utils/`: Utility helpers, including the custom **NFC Writer** implementation.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Backend**: [Firebase](https://firebase.google.com) (Auth, Firestore, Storage)
- **NFC Support**: `nfc_manager` & `nfc_manager_ndef`
- **QR Generation**: `pretty_qr_code`
- **Responsive Layout**: `flutter_screenutil`
- **Visuals**: `flutter_svg`, `google_fonts`, `image_cropper`

---

## 🧠 Technical Workflows

### 📡 NFC Implementation
The app includes a robust `NfcWriter` utility that handles:
1. Device availability checks.
2. NDEF URI record formatting (optimized for HTTPS).
3. Error handling for non-writable or low-capacity tags.
4. iOS-specific session management for a smooth native feel.

### 🛡️ Security & Integrity
- **Re-authentication**: Critical actions (like account deletion) require a fresh password verification.
- **Atomic Operations**: Uses Firestore `WriteBatch` to ensure consistent data deletion across multiple collections.
- **Safe Layouts**: Implements keyboard-aware scrolling to prevent UI overflows on smaller devices.

---

## ⚙️ Development & CI/CD

- **Security Rules**: `firestore.rules` and `storage.rules` are located in the root for easy deployment via Firebase CLI:
  ```bash
  firebase deploy --only firestore:rules,storage:rules
  ```
