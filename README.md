# Jamil Project - Flutter App Architecture

This project follows a **Feature-First Clean Architecture** using **Riverpod** for state management and **GoRouter** for navigation.

## 🚀 Getting Started

1.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

2.  **Generate Code (Riverpod/Freezed):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

3.  **Run the App:**
    ```bash
    flutter run
    ```

## 📂 Folder Structure

- `lib/src/`: Core source code.
  - `features/`: Divided by business features (auth, dashboard, links, etc.).
    - `presentation/`: UI and Controllers (Riverpod providers).
    - `domain/`: Business logic models (Freezed).
    - `data/`: Repositories and Data Sources.
  - `routing/`: Centralized GoRouter configuration.
  - `utils/`: Local storage, helpers.
  - `constants/`: Theme, sizes, strings.

## ⚙️ Key Technologies

- **State Management:** Riverpod 2 (Generator based)
- **Navigation:** GoRouter
- **Local Storage:** SharedPreferences
- **Fonts:** Google Fonts (Poppins)
- **Code Generation:** Build Runner, Riverpod Generator, Freezed

## 🧠 Architecture Highlights

- **Scalable Navigation:** Redirect logic is handled inside the router based on auth state.
- **Persistent Auth:** User session state persists across restarts using SharedPreferences.
- **Loading/Error Handling:** All auth actions use `AsyncValue` to handle UI states gracefully.
- **Separation of Concerns:** UI doesn't know about data sources; it only interacts with Controllers.
