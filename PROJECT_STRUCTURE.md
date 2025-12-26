# Connect Well Nepal - Project Structure

## 📁 Folder Structure

```
lib/
├── main.dart                      # App entry point
├── models/                        # Data models
│   └── clinic_model.dart
├── screens/                       # Full-page screens
│   ├── main_screen.dart          # Bottom navigation shell
│   └── profile_screen.dart       # User profile page
├── widgets/                       # Reusable UI components
│   └── clinic_card.dart          # Clinic display card
├── utils/                         # Constants & theme
│   └── colors.dart               # App color palette
└── services/                      # Firebase logic (empty for now)
    └── .gitkeep
```

## 🎨 Color Scheme

**Primary Color:** Navy Blue `#1A2F5A` (Connect Well Blue)
**Secondary Color:** Crimson Red `#DC143C` (Nepal Red)
**Background:** White/Off-white

## 📱 Features Implemented

### 1. **Main Screen** (`lib/screens/main_screen.dart`)
   - Bottom navigation with 3 tabs
   - Home: Lists 3 sample clinics
   - Resources: Placeholder for educational content
   - Profile: User profile management

### 2. **Profile Screen** (`lib/screens/profile_screen.dart`)
   - Large circular avatar
   - Full Name text field
   - Medical History multi-line input
   - Save Profile button with success feedback

### 3. **Clinic Card Widget** (`lib/widgets/clinic_card.dart`)
   - Displays clinic name, address, phone, distance
   - Material Design 3 card styling
   - Location and phone icons

### 4. **Clinic Model** (`lib/models/clinic_model.dart`)
   - Data class with: name, address, phoneNumber, distance
   - Ready for JSON serialization (commented out)

### 5. **Theme System** (`lib/utils/colors.dart` + `lib/main.dart`)
   - Material Design 3 enabled
   - Consistent color palette
   - Global theming for cards, buttons, inputs

## 🚀 How to Run

```bash
# Get dependencies
flutter pub get

# Run on your connected device/emulator
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze
```

## ✅ Quality Checks

- ✅ All code is properly commented
- ✅ Zero linter errors
- ✅ All tests passing
- ✅ Material Design 3 theming applied
- ✅ Clean architecture with separation of concerns

## 🔜 Next Steps for Your Team

1. **Firebase Integration**: Add Firebase to `lib/services/`
   - Authentication service
   - Firestore database service
   - Storage service

2. **Advanced Features**:
   - Real clinic data from Firebase
   - User authentication
   - Appointment booking
   - Video consultation
   - Educational resources content

3. **State Management**:
   - Consider adding Provider, Riverpod, or Bloc
   - Move hardcoded data to state managers

4. **API Integration**:
   - Add HTTP package for REST APIs
   - Create API service classes in `services/`

## 👥 Team Collaboration Tips

- Each team member can work on different screens/features
- Use Git branches for new features
- Follow the existing code structure and comments
- Test your changes before committing
- Keep models in `models/`, reusable widgets in `widgets/`

## 📝 Notes

- The `services/` folder is empty - ready for Firebase logic
- Sample clinic data is hardcoded in `main_screen.dart`
- Profile save doesn't persist yet (needs Firebase)
- All deprecated APIs have been updated to latest Flutter standards

---

**Created:** Dec 25, 2025
**Team Size:** 4 students
**Framework:** Flutter 3.27+
**Design:** Material Design 3

