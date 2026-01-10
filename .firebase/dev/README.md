# Firebase Configuration - Dev Environment

Place your Firebase configuration files here:

- **Android**: `google-services.json` (download from Firebase Console)
- **iOS/macOS**: `GoogleService-Info.plist` (download from Firebase Console)

## How to get these files

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (or create a new one for dev environment)
3. For Android:
   - Go to Project Settings > Your apps > Android app
   - Download `google-services.json`
   - Place it in this directory
4. For iOS/macOS:
   - Go to Project Settings > Your apps > iOS app
   - Download `GoogleService-Info.plist`
   - Place it in this directory

**Note**: Make sure to add these files to `.gitignore` if they contain sensitive information.
