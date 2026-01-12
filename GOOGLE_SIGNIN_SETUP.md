# Google Sign-In Setup Guide

## 🔧 Fixed Issues

The following changes have been made to fix Google Sign-In:

1. **Added GoogleSignInRequested Event** - New event in AuthBloc to handle Google Sign-In
2. **Updated AuthBloc** - Added Google Sign-In handler with proper error handling
3. **Android Configuration** - Added multiDex support for Firebase and Google Play Services
4. **Gradle Configuration** - Added proper Google Services plugin configuration

---

## 📋 Prerequisites

### 1. Firebase Project Setup

You must have a Firebase project created:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project or select an existing one
3. Add an Android app to your Firebase project:
   - Package name: `com.example.news_app` (or your custom package name)
   - SHA-1 certificate fingerprint (see below)

### 2. Get SHA-1 Certificate Fingerprint

#### On Windows (with Android Studio):

```bash
# Using keytool (Java)
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Or simply:
```bash
# Android Studio automatically shows this in Gradle messages during first build
flutter run
# Look for the SHA-1 fingerprint in the console output
```

#### On macOS/Linux:

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### 3. Configure Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Enable **Google+ API**
3. Create an OAuth 2.0 Client ID:
   - Type: Android
   - Package name: `com.example.news_app`
   - SHA-1: (your certificate fingerprint from step 2)

---

## 📱 Android Configuration

### Step 1: Update Package Name (if needed)

Edit `android/app/build.gradle.kts`:
```kotlin
applicationId = "com.your.package.name"  // Change this if needed
```

Also update in `android/app/src/main/AndroidManifest.xml`.

### Step 2: Add Google Services File

1. Download `google-services.json` from Firebase Console
2. Place it in: `android/app/google-services.json`

### Step 3: Verify Gradle Configuration

Ensure your `android/build.gradle.kts` has:
```kotlin
plugins {
    id("com.google.gms.google-services") version "4.4.0" apply false
}
```

And `android/app/build.gradle.kts` has:
```kotlin
plugins {
    id("com.google.gms.google-services")
}

android {
    defaultConfig {
        multiDexEnabled = true
    }
}
```

### Step 4: Add Required Permissions

Ensure `android/app/src/main/AndroidManifest.xml` has:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

---

## 🍎 iOS Configuration

### Step 1: Add Google Services File

1. Download `GoogleService-Info.plist` from Firebase Console
2. Open Xcode: `open ios/Runner.xcworkspace` (NOT .xcodeproj)
3. Drag and drop `GoogleService-Info.plist` into the Runner folder
4. Make sure it's added to the "Runner" target

### Step 2: Update Info.plist

Add the following to `ios/Runner/Info.plist`:

```xml
<key>GIDClientID</key>
<string>YOUR_CLIENT_ID.apps.googleusercontent.com</string>

<key>GIDServerClientID</key>
<string>YOUR_SERVER_CLIENT_ID.apps.googleusercontent.com</string>

<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
    </array>
  </dict>
</array>
```

### Step 3: Update URL Schemes

In `ios/Runner.xcworkspace`:
1. Select Runner target
2. Go to Info tab
3. Find "URL Types"
4. Add a new URL type with scheme: `com.googleusercontent.apps.YOUR_CLIENT_ID`

---

## 🧪 Testing Google Sign-In

### Step 1: Clean and Rebuild

```bash
flutter clean
flutter pub get
flutter run
```

### Step 2: Test on Device/Emulator

1. Navigate to Login screen
2. Click "Continue with Google" button
3. A Google sign-in dialog should appear
4. Select your Google account
5. You should be logged in

### Step 3: Troubleshooting

#### Error: "Sign-in with Google is not supported"

**Solution:** Ensure Google Play Services is installed on your Android device/emulator:
- On emulator: Use a device image with Google Play Services (e.g., "Google APIs")
- On device: Ensure Google Play Services is installed and updated

#### Error: "Configuration provided to Google Sign-In is invalid"

**Solution:** Verify your `google-services.json` is in the correct location:
```
android/app/google-services.json
```

#### Error: "com.google.android.gms.common.api.ApiException"

**Solution:** Check your SHA-1 fingerprint matches in Firebase Console

---

## 📊 Code Changes Made

### 1. AuthBloc (`lib/bloc/auth/auth_bloc.dart`)

Added Google Sign-In support:
- Import GoogleSignIn
- Add `_googleSignIn` instance variable
- Handle `AuthGoogleSignInRequested` event
- Properly manage sign-out for both services

### 2. AuthEvent (`lib/bloc/auth/auth_event.dart`)

Added new event:
```dart
class AuthGoogleSignInRequested extends AuthEvent {}
```

### 3. AuthController (`lib/controllers/auth_controller.dart`)

Already has `signInWithGoogle()` method - working as expected.

---

## 🔒 Security Considerations

1. **Never commit** `google-services.json` to public repositories
2. Add to `.gitignore`:
   ```
   # Firebase
   android/app/google-services.json
   ios/GoogleService-Info.plist
   lib/firebase_options.dart
   ```

3. Use **separate Firebase projects** for development and production

4. Enable **2-Step Verification** on test Google accounts

---

## 🚀 Production Deployment

Before deploying to production:

1. **Update Package Name:**
   ```
   com.example.news_app → com.yourcompany.newsapp
   ```

2. **Create Production Firebase Project**

3. **Generate Release Keystore:**
   ```bash
   keytool -genkey -v -keystore ~/my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
   ```

4. **Configure Signing:**
   - Update `android/app/build.gradle.kts` with your release keystore

5. **Test on Release Build:**
   ```bash
   flutter build apk --release
   ```

---

## 📚 Useful Resources

- [Firebase Authentication Documentation](https://firebase.google.com/docs/auth)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)
- [Firebase Console](https://console.firebase.google.com)
- [Google Cloud Console](https://console.cloud.google.com)

---

## ❓ Common Questions

**Q: Why does Google Sign-In fail on iOS simulator?**
A: Google Sign-In requires real device or valid provisioning for iOS. Test on a physical device.

**Q: Can I use Google Sign-In without Firebase?**
A: Yes, but this app is configured to use both together for enhanced security.

**Q: How do I debug Google Sign-In issues?**
A: Enable verbose logging:
```dart
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
```

---

## ✅ Verification Checklist

- [ ] Firebase project created
- [ ] Android app added to Firebase
- [ ] `google-services.json` downloaded and placed in `android/app/`
- [ ] SHA-1 fingerprint added to Firebase Console
- [ ] Google Cloud project has Google+ API enabled
- [ ] OAuth 2.0 credentials created
- [ ] `multiDexEnabled = true` in Gradle
- [ ] `com.google.gms.google-services` plugin added
- [ ] Tested on Android device/emulator
- [ ] Tested on iOS device (if applicable)

---

If you're still experiencing issues after following this guide, please check:
1. Console logs: `flutter logs`
2. Android Studio Logcat
3. Firebase Console for any errors
4. Verify all configuration files are in place
