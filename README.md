# 📰 Barca News Application

<div align="center">

A modern Flutter news application that delivers real-time Barcelona FC news and sports updates with a beautiful, intuitive interface.

![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7+-00B4AB?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-blue)

</div>

## 🎯 Overview

Barca News is a feature-rich Flutter application that provides comprehensive news coverage about FC Barcelona. Built with modern architecture patterns and state management solutions, it offers seamless user experience across multiple platforms.

### Key Highlights
- ✅ Real-time news fetching from NewsAPI
- ✅ Firebase Authentication (Email & Google Sign-In)
- ✅ Dark mode & Light mode theming
- ✅ Multi-language support (English & Arabic)
- ✅ Responsive UI with smooth animations
- ✅ Cross-platform support (iOS, Android, Web, Windows, macOS, Linux)
- ✅ Efficient state management with BLoC & GetX

---

## 🚀 Features

### Authentication
- Email/Password registration and login
- Google Sign-In integration
- Secure authentication with Firebase Auth

### News Management
- Browse news articles by category
- Search and filter capabilities
- Beautiful article previews with images
- Direct links to full articles

### User Experience
- **Dark/Light Theme** - Toggle between themes
- **Localization** - Support for English and Arabic
- **Smooth Animations** - Beautiful transitions and animations
- **Loading Shimmer** - Professional skeleton loading states
- **Responsive Design** - Optimized for all screen sizes

### Technical Features
- Clean Architecture implementation
- BLoC pattern for state management
- GetX for navigation and dependencies
- Cached network images for better performance
- Device preview for multi-device testing

---

## 🏗️ Project Structure

```
lib/
├── app/                    # App configuration and routing
│   ├── routes/            # Route definitions
│   └── app.dart
├── bloc/                  # Business Logic Component
│   ├── auth_bloc/         # Authentication logic
│   ├── news_services_bloc/ # News fetching logic
│   ├── theme_cubit.dart   # Theme management
│   └── locale_cubit.dart  # Localization management
├── controllers/           # GetX controllers
├── core/                  # Core utilities
│   ├── config/           # API configuration
│   └── constants/        # App constants and strings
├── data/                 # Data layer
│   ├── models/           # Data models
│   ├── repositories/     # Repository pattern
│   └── services/         # API services
├── models/               # Domain models
├── presentation/         # UI Layer
│   ├── bindings/         # GetX bindings
│   ├── coordinators/     # Route coordinators
│   ├── viewmodels/       # ViewModels
│   ├── views/            # Screens
│   └── widgets/          # Reusable widgets
├── services/             # Business services
└── main.dart             # App entry point
```

---

## 📋 Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Flutter** | Mobile framework |
| **Dart** | Programming language |
| **Dio** | HTTP client for API calls |
| **Firebase Auth** | Authentication service |
| **Flutter BLoC** | State management |
| **GetX** | Navigation & dependency injection |
| **NewsAPI** | News data source |
| **Cached Network Image** | Image caching |
| **Google Fonts** | Typography |
| **Flutter Animate** | Animation library |
| **Shimmer** | Loading indicators |

---

## 📦 Dependencies

### Core Dependencies
```yaml
dio: ^5.9.0                      # HTTP client
firebase_core: ^4.3.0            # Firebase integration
firebase_auth: ^6.1.3            # Authentication
flutter_bloc: ^9.1.1             # State management
get: ^4.7.3                      # Navigation & DI
```

### UI & UX
```yaml
google_fonts: ^7.0.0             # Google fonts
flutter_animate: ^4.5.2          # Animations
shimmer: ^3.0.0                  # Loading shimmer
cached_network_image: ^3.4.1     # Image caching
font_awesome_flutter: ^10.9.0    # Icons
```

### Localization & Storage
```yaml
flutter_localizations:           # Multi-language support
shared_preferences: ^2.5.4       # Local storage
```

---

## 🛠️ Installation & Setup

### Prerequisites
- Flutter 3.7 or higher
- Dart 3.7 or higher
- Android Studio / Xcode (for mobile development)
- NewsAPI key (get from [newsapi.org](https://newsapi.org))
- Firebase project setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/barca-news.git
cd barca-news
```

### Step 2: Install Dependencies
```bash
flutter pub get
flutter pub upgrade
```

### Step 3: Configure Firebase
1. Create a Firebase project on [Firebase Console](https://console.firebase.google.com)
2. Add iOS and Android apps to your project
3. Download `google-services.json` for Android and `GoogleService-Info.plist` for iOS
4. Place these files in the respective directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### Step 4: Configure NewsAPI
1. Get your API key from [newsapi.org](https://newsapi.org)
2. Add it to `lib/core/config/api_config.dart`

### Step 5: Run the App
```bash
# Run on connected device/emulator
flutter run

# Run with specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

---

## 🔧 Configuration

### API Configuration
Update `lib/core/config/api_config.dart` with your NewsAPI key:
```dart
const String newsApiKey = 'YOUR_API_KEY_HERE';
const String newsApiBaseUrl = 'https://newsapi.org/v2';
```

### Firebase Configuration
Firebase is automatically configured through `firebase_options.dart` which is generated during setup.

---

## 📱 Supported Platforms

| Platform | Status |
|----------|--------|
| Android | ✅ Supported |
| iOS | ✅ Supported |
| Web | ✅ Supported |
| Windows | ✅ Supported |
| macOS | ✅ Supported |
| Linux | ✅ Supported |

---

## 🎨 Features in Detail

### Authentication Flow
- User can sign up with email/password or Google account
- Secure password storage with Firebase
- Persistent login state with local storage
- Error handling and validation

### News Categories
- Browse news by multiple Barcelona FC related categories
- Search functionality across articles
- Filter options for better discovery
- Share articles functionality

### Theme Management
- Light and Dark mode support
- Persistent theme preference
- Smooth transitions between themes
- Material Design 3 compliance

### Localization
- Full support for English and Arabic
- Dynamic language switching
- Persistent language preference
- RTL support for Arabic

---

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or for universal APK
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

---

## 🐛 Troubleshooting

### Issue: Firebase initialization fails
**Solution:** Ensure all Firebase configuration files are properly placed and Firebase credentials are valid.

### Issue: NewsAPI errors
**Solution:** Verify your API key is correct and you have sufficient API quota.

### Issue: Build fails on iOS
**Solution:** Run `flutter clean` and ensure CocoaPods is updated:
```bash
cd ios
pod repo update
cd ..
flutter run
```

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [NewsAPI Documentation](https://newsapi.org/docs)
- [BLoC Pattern](https://bloclibrary.dev)
- [GetX Documentation](https://pub.dev/packages/get)

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Guidelines
- Follow Dart style conventions
- Write meaningful commit messages
- Add comments for complex logic
- Test your changes thoroughly

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name** - [GitHub Profile](https://github.com/yourusername)

---

## 🙏 Acknowledgments

- [NewsAPI](https://newsapi.org) for providing news data
- [Flutter Team](https://flutter.dev) for the amazing framework
- [Firebase](https://firebase.google.com) for authentication and services
- All contributors and community members

---

## 📞 Support

For support, email your-email@example.com or open an issue on GitHub.

---

<div align="center">

**⭐ If you find this project helpful, please consider giving it a star!**

Made with ❤️ by [Your Name]

</div>
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
