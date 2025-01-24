# ToDo Mobile App

This is a simple ToDo mobile application built using **Flutter** and **Firebase**. The app allows users to manage their tasks with features including user authentication, adding, editing, deleting, and viewing todos, as well as receiving notifications. The app integrates **Firebase Firestore** for storing todos, **Firebase Auth** for user authentication, **Firebase Messaging** for push notifications, and uses **Flutter BLoC** for state management.

## Features

- **Sign Up:** Users can sign up using their email, password, and name.
- **Login:** Users can log in using their email and password.
- **Add Todo:** Users can create and add todos to Firebase Firestore.
- **Edit and Delete Todo:** Users can edit or delete their existing todos.
- **View Todos:** Users can retrieve and view their list of todos.
- **Notification Feature:** Users will receive push notifications related to tasks.
- **Progress Bar:** The home page displays a progress bar indicating task completion.

## Tech Stack

- **Flutter**: Cross-platform mobile framework for building the app.
- **Firebase Firestore**: Cloud database to store and retrieve todos.
- **Firebase Auth**: Authentication service for user sign-up and login.
- **Firebase Messaging**: Service for sending and receiving push notifications.
- **Flutter BLoC**: State management solution for managing the app’s data and UI updates.

## Getting Started

Follow these steps to get the app running locally:

### Prerequisites

- **Flutter SDK**: You need to have Flutter installed. Follow the official installation guide for your operating system: [Flutter Installation](https://flutter.dev/docs/get-started/install).
- **Firebase Project**: Create a Firebase project and configure Firestore, Firebase Auth, and Firebase Messaging for your app.
  
### Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/flutterStart311/MyTask.git
   cd todo-mobile-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set up Firebase for your app:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add the Android/iOS app to your Firebase project.
   - Follow the instructions on the Firebase Console to download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
   - Place the configuration file in the respective platform directory (`android/app` for Android or `ios/Runner` for iOS).

4. Run the app on your emulator or physical device:
   ```bash
   flutter run
   ```

### Firebase Configuration

- Ensure that you have enabled Firebase Firestore, Firebase Authentication (Email/Password), and Firebase Messaging for your project in the Firebase Console.
- Make sure your Firestore rules allow for reading and writing data as needed. Example:
  ```bash
  service cloud.firestore {
    match /databases/{database}/documents {
      match /{document=**} {
        allow read, write: if true;  // Allow for testing, modify for production
      }
    }
  }
  ```

## Features Explained

### 1. **User Authentication**

The app uses **Firebase Auth** to manage user authentication. Users can sign up with their email, password, and name. After signing up, they can log in using their credentials.

### 2. **Managing Todos**

Users can:
- Add new todos to Firestore.
- Retrieve todos from Firestore.
- Edit the content of existing todos.
- Delete todos from Firestore.

Todos are stored in a Firestore collection, and the app interacts with Firestore using Flutter's `cloud_firestore` package.

### 3. **Notification Feature**

Push notifications are implemented using **Firebase Messaging**. Notifications are triggered when new todos are added or when there are important updates. Notifications are received even when the app is in the background or terminated.

### 4. **Todo Progress Bar**

On the home page, a progress bar is displayed that updates as users mark todos as completed. The progress bar reflects the percentage of tasks completed.

### 5. **State Management with Flutter BLoC**

This app uses **Flutter BLoC** for state management. The app’s UI listens to changes in the app's state (such as todo updates or login status) and updates accordingly. The BLoC pattern ensures that business logic is separated from UI code, promoting a cleaner and more maintainable codebase.

---

## Dependencies

The app uses the following dependencies:

- `firebase_core`: To initialize Firebase services.
- `firebase_auth`: For Firebase authentication.
- `cloud_firestore`: For interacting with Firebase Firestore.
- `firebase_messaging`: For push notifications.
- `flutter_local_notifications`: For local notifications when the app is in the foreground.
- `flutter_bloc`: For state management using the BLoC pattern.

Add these dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  lottie: ^3.3.1
  firebase_core: ^3.10.0
  firebase_auth: ^5.4.0
  cloud_firestore: ^5.6.1
  flutter_bloc: ^9.0.0
  uuid: ^4.5.1
  intl: ^0.20.1
  firebase_messaging: ^15.2.1
  flutter_local_notifications: ^18.0.1
  permission_handler: ^11.3.1
```


### Bug Reports & Feature Requests

If you encounter any bugs or have any feature requests, feel free to create an issue on GitHub.

Thank You!
