<<<<<<< HEAD
# News App (Flutter)

A small Flutter news app that fetches articles about Barcelona using NewsAPI and displays them in a sliver-based UI.

## What it is
This is a learning/demo Flutter project that:
- Fetches news from NewsAPI using `dio`.
- Maps JSON articles to a simple `ArticleModel`.
- Displays articles in a sliver list UI with small tiles.

## Key features
- HTTP client built with `dio`.
- Simple article model in `lib/models/articlemodel.dart`.
- Network service in `lib/services/news_services.dart`.
- Views and widgets under `lib/views/` and `lib/widget/`.
- Platform support scaffolded for Android, iOS, Windows, macOS, Linux, and web.

## Tech stack
- Flutter (Dart)
- dio (HTTP client)
- NewsAPI (backend)

## Repo layout (important files)
- `lib/main.dart` — app entry point
- `lib/models/articlemodel.dart` — article data model
- `lib/services/news_services.dart` — fetch and parse news JSON
- `lib/views/homeview.dart` — main screen
- `lib/widget/newslistview.dart` — sliver list of articles
- `lib/widget/newstile.dart` — article tile UI
- `assets/` — images used by the app

## Quick start (Windows / PowerShell)
1. Install Flutter and ensure `flutter` is on PATH.
2. From project root:
```powershell
flutter pub get
flutter pub upgrade
# Run on an attached device or emulator. Omit -d for the default device.
flutter run
```

## Notes and known issues
- API key is currently hard-coded in `lib/services/news_services.dart`. Do not commit a private/production key. Move it to a local config or environment variable before publishing.
- `ArticleModel` uses `titel` and `suptitel` (typos). Consider renaming to `title` and `subtitle` for clarity. If you change the model, update all usages (e.g., `newstile.dart`, `newslistview.dart`).
- `lib/widget/newslistview.dart` returns a `SliverList`. Ensure it is used inside a `CustomScrollView` (otherwise Flutter throws a layout error). Alternatively change it to a standard `ListView` if you don't use slivers.
- `news_services.dart` currently returns an empty list on network or parsing errors and supplies a fallback title for missing `title`. This prevents crashes but hides errors; you may want to log or surface errors to the UI.
- Nullability: API fields like `urlToImage` and `description` can be null; code handles that but the UI should guard against null images and long descriptions.

## Recommendations / next steps
- Remove the API key from source and load it from a `.env` or CI secret.
- Replace string URL construction with `Uri` or use `dio.getUri` to avoid encoding issues.
- Improve UI states: add explicit loading and error states in `lib/widget/newslistview.dart`.
- Change `ArticleModel` field names (and run a repo-wide replace).
- Add basic tests for `NewsServices` (mock `Dio`) and a simple widget test for the list view.

## Contributing
PRs are welcome. Please:
- Run `flutter format` before committing.
- Avoid committing API keys or secrets.
- Open an issue for larger changes (model rename, architecture refactor).

## License
Add a license file if you plan to publish this repo.
=======
# Barca_news_application
>>>>>>> 1b9319d (Initial commit)
