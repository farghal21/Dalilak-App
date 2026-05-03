# Dalilak

Dalilak is an Arabic AI chatbot app built to help users choose the most suitable car. It guides the user through a smart conversation, suggests matching cars, compares options, and keeps a history of previous chats.

## About the App

The app acts as an AI-powered car selection assistant. It asks the right questions, understands the user's needs and preferences, and then helps narrow down the best car choices. It also includes authentication, password recovery, settings, and chat history screens.

## Features

- Login and account registration.
- Password recovery via email and OTP.
- Onboarding flow to understand the user's needs before starting.
- Smart chat with ready-made suggestions such as:
  - recommending the right car,
  - estimating costs,
  - comparing cars.
- AI chat assistant that helps users pick the right car based on their needs.
- Car details screen.
- Car comparison screen.
- Favorites and chat history.
- Account, notifications, privacy, and delete account settings.
- Arabic and English UI support.

## Tech Stack

- Flutter
- Dart 3.6.1
- BLoC / flutter_bloc
- GetX
- GetIt
- Dio
- SharedPreferences
- flutter_localizations and intl
- flutter_screenutil

## Requirements

- Flutter SDK compatible with Dart `^3.6.1`
- Android Studio or VS Code
- An Android or iOS emulator, or a browser for web builds

## Run Locally

1. Fetch the dependencies:

```bash
flutter pub get
```

2. Run the app:

```bash
flutter run
```

## Localization

The project uses translation files inside `lib/l10n/` and generates the required localization output automatically.
If you update the translation files, regenerate the localization files using the project workflow.

## API

The app connects to a backend through `Dio`. Backend configuration and endpoint details are intentionally omitted from this README.

## Project Structure

```text
lib/
  core/         # networking, caching, shared helpers, themes
  features/     # main screens and feature modules
  generated/    # generated localization files
  l10n/         # ARB translation files
```

## Notes

- The main UI font is `Cairo`.
- The app defaults to Arabic on startup.
- The app entry point is `lib/main.dart`.
