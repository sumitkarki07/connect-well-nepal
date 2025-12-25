# 🎨 Logo Integration Guide

## Step 1: Save Your Logo

Save the Connect Well Nepal logo you provided in these formats:

1. **Full Logo** (with text):
   - Save as: `assets/logos/logo.png`
   - Recommended size: 512x512 pixels
   - Use: Splash screen, headers

2. **Icon Only** (circular icon):
   - Save as: `assets/logos/logo_icon.png`
   - Recommended size: 192x192 pixels
   - Use: App bar, small icons

## Step 2: Update Splash Screen

Open `lib/screens/splash_screen.dart` and replace:

```dart
// TODO: Replace with actual logo image
// Image.asset('assets/logos/logo.png', width: 200),

// Placeholder Logo Circle
Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    color: AppColors.primaryNavyBlue.withValues(alpha: 0.1),
    shape: BoxShape.circle,
  ),
  child: const Icon(
    Icons.health_and_safety,
    size: 100,
    color: AppColors.primaryNavyBlue,
  ),
),
```

**With:**

```dart
Image.asset(
  'assets/logos/logo.png',
  width: 200,
  height: 200,
),
```

## Step 3: Update Main Screen Header

Open `lib/screens/main_screen.dart` and replace:

```dart
// TODO: Replace with actual logo
// Image.asset('assets/logos/logo_icon.png', height: 32),
Container(
  width: 32,
  height: 32,
  decoration: const BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
  ),
  child: const Icon(
    Icons.health_and_safety,
    color: AppColors.secondaryCrimsonRed,
    size: 20,
  ),
),
```

**With:**

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(
    'assets/logos/logo_icon.png',
    height: 32,
    width: 32,
    fit: BoxFit.cover,
  ),
),
```

## Step 4: Update App Icon (Optional)

### For Android:
Replace files in:
- `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`

### For iOS:
Replace files in:
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Easy Way:
Use this package to generate all sizes automatically:

```bash
flutter pub add flutter_launcher_icons --dev
```

Create `flutter_launcher_icons.yaml`:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/logos/logo_icon.png"
  
flutter pub get
flutter pub run flutter_launcher_icons
```

## Step 5: Test

```bash
flutter run
```

You should now see:
- ✅ Logo on splash screen
- ✅ Logo icon in app bar
- ✅ Custom app icon (if you updated it)

---

## 🎨 Your Logo Design

Your logo beautifully incorporates:
- 🏔️ **Mountains**: Representing Nepal's landscape
- ❤️ **Heartbeat Line**: Healthcare/medical focus
- 💬 **Chat Bubble**: Communication/telemedicine
- 📶 **WiFi Signal**: Digital connectivity
- 🔵 **Navy Blue**: Professional/trustworthy
- 🔴 **Crimson Red**: Nepal's national color

Perfect for a telehealth application!

---

## Quick Command

After saving your logo images, run:

```bash
# Verify assets are properly configured
flutter clean
flutter pub get
flutter run
```

Done! 🎉

