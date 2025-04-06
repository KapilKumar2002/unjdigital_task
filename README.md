# UnJ Digital Flutter Assignment

## 📱 Project Overview

This Flutter project is a user management app built using **Clean Architecture**. It interacts with a **mock Postman API** to perform CRUD operations, display a **paginated user list**, implement **infinite scroll**, and persist user data locally using **Hive**. The app provides a smooth, responsive, and offline-friendly user experience while maintaining clean separation of concerns.

---

## 📁 Folder Structure

```
lib/
├── blocs/               # BLoC files for managing state
│   ├── user_bloc/       # User list pagination BLoC
│   └── user_details/    # Individual user BLoC
│
├── core/                # Core services and utilities
│   ├── services/        # API services using Dio
│   └── utils/           # Helpers (theme, validators etc.)
│
├── data/                # Data layer
│   ├── models/          # User model (JSON Serializable)
│   └── repositories/    # API + Hive CRUD logic
│
├── di/                  # Dependency Injection using get_it
│   └── locator.dart
│
├── presentation/        # UI layer
│   ├── screens/         # Home, Detail, Edit, Add screens
│   └── widgets/         # Shared custom widgets
│
├── routes/              # App navigation using go_router
└── main.dart            # App entry point
```

---

## ⚙ Packages Used

- **flutter_bloc**: BLoC state management
- **dio**: HTTP client for API requests
- **hive / hive_flutter**: Local caching and persistence
- **json_serializable / build_runner**: Code generation for models
- **get_it**: Dependency injection
- **go_router**: Declarative routing
- **shimmer**: Loading UI placeholders
- **equatable**: Simplify BLoC state comparisons
- **uuid**: For local user ID generation
- **lottie**: Beautiful animations (error, loading)

---

## ✅ Features Implemented

### 1. Home Screen

- Fetches users from the mock API (`/users?page=1/2/3`).
- Implements **infinite scrolling** and **pagination** (10 per page).
- Displays user name and email.
- **Floating Action Button** to navigate to Add New User Screen.
- On scroll, loads more users and caches them.

### 2. User Details Screen

- Displays:
  - Name, email, phone, address
  - Company, website, geo-location (optional)
- Pulls data from local cache (Hive).
- Has an **Edit button** to update details.

### 3. Edit User Screen

- Pre-filled form for name, email, and phone.
- On update:
  - Updates Hive cache.
  - Reflects changes instantly in the app.
  - Persists changes after restart.

### 4. Add New User Screen

- Form to add name, email, phone, and address.
- On submit:
  - Adds user to local Hive cache.
  - Shows newly added user on top of the Home Screen.

---

## 🔧 API Integration

- **Base URL**: `https://c43d9c37-22a2-4d9b-9f13-923d980cd6ec.mock.pstmn.io`
- **Endpoints**:
  - `GET /users?page={page}`
  - `GET /users/{id}`
  - `POST /users` (mocked)
  - `PUT /users/{id}` (mocked)

All additions and updates are simulated using local caching as the API is read-only.

---

## 🧠 Architecture & Flow

- Clean architecture ensures separation of UI, business logic, and data layers.
- API calls are made in **UserRepository**.
- Caching and local manipulation is done using Hive.
- Data is sent to BLoC, then to UI via state changes.
- App continues to work even without internet (cached users).

---

## 🔁 Error Handling & Retry

- If an API call fails:
  - ErrorScreen is shown with message and retry button.
  - Retry re-attempts the failed action.
- Custom error UI using Lottie and Custom Widgets.

---

## 💾 Caching & Performance

- User list is cached page-wise using Hive.
- All data persists after app restart.
- Shimmer loading is used for better UX.

---

## 🔍 Bonus Features

- **Search** users by name or email.
- Responsive and polished UI with empty/error states.

---

## 🚀 Getting Started

### Setup Instructions:

```bash
git clone <your-repo-link>
cd your_project
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 📌 Evaluation Criteria Mapping

| Criteria                | Status  |
| ----------------------- | ------- |
| BLoC & State Management | ✅ Done |
| CRUD Functionality      | ✅ Done |
| Pagination              | ✅ Done |
| UI & Navigation         | ✅ Done |
| Error Handling          | ✅ Done |
| Best Practices          | ✅ Done |
| Caching (Hive)          | ✅ Done |
| Bonus (Search)          | ✅ Done |

---

## 🧾 Summary

This project demonstrates a comprehensive implementation of a user directory system with the following covered:

- **Clean Architecture** for modular, testable, and scalable code.
- **BLoC pattern** for state management.
- **Pagination with infinite scroll**, including shimmer loading effects.
- **Local caching using Hive**, with persistence after restart.
- **CRUD operations** on user data simulated locally.
- **Robust error handling** with retry mechanisms.
- **Search feature** to filter users by name or email.

All critical and bonus points of the assignment have been carefully implemented to reflect best practices in Flutter development.

> Built with ❤️ using Flutter + BLoC + Hive
