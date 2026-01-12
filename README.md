# Barca News Application

A Flutter news app that fetches articles about Barcelona FC using NewsAPI and displays them in a modern, responsive UI.

## What it is
This is a Flutter project that:
- Fetches news from NewsAPI using `dio`
- Maps JSON articles to `ArticleModel`
- Displays articles in a sliver-based UI with modern design
- Supports authentication via Firebase Auth
- Includes theme switching (light/dark mode) and localization (English/Arabic)

## Key features
- HTTP client built with `dio`
- Article model in `lib/models/articlemodel.dart`
- Network services in `lib/services/` and `lib/data/services/`
- Views and widgets under `lib/views/` and `lib/widget/`
- BLoC and GetX state management patterns
- Firebase Authentication integration
- Platform support for Android, iOS, Windows, macOS, Linux, and web

## Tech stack
- Flutter (Dart)
- dio (HTTP client)
- Firebase Auth (authentication)
- flutter_bloc (state management)
- GetX (state management)
- NewsAPI (backend)

## Repo layout (important files)
- `lib/main.dart` — app entry point
- `lib/models/articlemodel.dart` — article data model
- `lib/services/news_services.dart` — fetch and parse news JSON
- `lib/core/config/api_config.dart` — centralized API configuration
- `lib/views/homeview.dart` — main screen
- `lib/widget/newslistview.dart` — sliver list of articles
- `lib/widget/newstile.dart` — article tile UI
- `assets/` — images and icons used by the app

## Quick start (Windows / PowerShell)
1. Install Flutter and ensure `flutter` is on PATH.
2. From project root:
```powershell
flutter pub get
flutter pub upgrade
# Run on an attached device or emulator. Omit -d for the default device.
flutter run
```

## Recent improvements
- ✅ API keys moved to centralized config (`lib/core/config/api_config.dart`)
- ✅ Improved error handling with proper exception throwing
- ✅ URL construction uses `Uri` for safer encoding
- ✅ Email validation added to login/signup forms
- ✅ Better error messages displayed to users
- ✅ Category constants created for maintainability
- ✅ Security improvements (removed exposed API keys from files)

## Notes
- API keys are centralized in `lib/core/config/api_config.dart`. For production, these should be loaded from environment variables or a secure configuration service.
- `ArticleModel` uses `title` and `subtitle` (correctly named).
- `lib/widget/newslistview.dart` returns a `SliverList` and is used inside `CustomScrollView` as required.
- Error handling: Services now throw exceptions instead of returning empty lists, allowing proper error display in the UI.
- Nullability: API fields like `urlToImage` and `description` are properly handled as nullable, and the UI guards against null images.

## Recommendations / next steps
- Load API keys from environment variables in production
- Add basic tests for `NewsServices` (mock `Dio`) and widget tests
- Implement search functionality (currently placeholder)
- Add more comprehensive error logging

## Contributing
PRs are welcome. Please:
- Run `flutter format` before committing
- Avoid committing API keys or secrets
- Open an issue for larger changes (model rename, architecture refactor)

## License
Add a license file if you plan to publish this repo.
