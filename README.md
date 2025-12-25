# 🇳🇵 Connect Well Nepal

<div align="center">
  
  ### Your Telehealth Partner in Nepal
  
  A comprehensive telehealth application connecting patients with healthcare providers across Nepal.
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.27+-blue.svg)
  ![Firebase](https://img.shields.io/badge/Firebase-Ready-orange.svg)
  ![License](https://img.shields.io/badge/License-MIT-green.svg)
</div>

---

## 📱 About

**Connect Well Nepal** is a student-developed telehealth platform designed to:
- Connect patients with doctors via video/voice/chat consultations
- Provide easy appointment booking and management
- Offer health education resources and self-care tools
- Enable remote healthcare access across Nepal

**Inspired by:** Timely Care and similar telehealth platforms

---

## ✨ Features

### Current Base Version:
✅ **Splash Screen** - Beautiful branded launch screen  
✅ **Home Dashboard** - Quick actions & nearby clinics  
✅ **Appointments** - Booking and management system (skeleton)  
✅ **Consultations** - Video/Voice/Chat options (skeleton)  
✅ **Health Resources** - Educational content & articles  
✅ **User Profile** - Profile management with medical history  
✅ **Material Design 3** - Modern, accessible UI  

### Planned Features:
🔄 Video consultation integration  
🔄 Firebase authentication  
🔄 Real-time appointment booking  
🔄 Medical records management  
🔄 Push notifications  
🔄 Prescription sharing  
🔄 Multi-language support (Nepali/English)  

---

## 🏗️ Architecture

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── clinic_model.dart
│   └── [More models...]
├── screens/                     # Full-page screens
│   ├── splash_screen.dart
│   ├── main_screen.dart
│   ├── appointments_screen.dart
│   ├── consultation_screen.dart
│   ├── resources_screen.dart
│   └── profile_screen.dart
├── widgets/                     # Reusable components
│   └── clinic_card.dart
├── services/                    # Backend services (Firebase, API)
│   └── [To be implemented]
└── utils/                       # Constants, themes, helpers
    └── colors.dart
```

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.27 or higher
- Dart 3.10.4 or higher
- Android Studio / VS Code
- iOS Simulator (Mac) or Android Emulator

### Installation

```bash
# Clone the repository
git clone [your-repo-url]
cd connect-well-nepal

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### First Time Setup

1. **Add the Logo:**
   - Save your logo to `assets/logos/logo.png`
   - Save icon to `assets/logos/logo_icon.png`
   - See `LOGO_INTEGRATION_GUIDE.md` for details

2. **Firebase Setup** (Coming Soon):
   - Create Firebase project
   - Add configuration files
   - Enable services (Auth, Firestore, Storage)

---

## 👥 Team

This project is developed by a team of 4 students:

| Member | Focus Area | Status |
|--------|-----------|--------|
| **Member 1** | Appointments & Booking | 🔄 In Progress |
| **Member 2** | Video/Voice Calls | 🔄 In Progress |
| **Member 3** | Health Resources | 🔄 In Progress |
| **Member 4** | Backend & Auth | 🔄 In Progress |

**See `TEAM_DISTRIBUTION.md` for detailed task assignments.**

---

## 📚 Documentation

- **[TEAM_DISTRIBUTION.md](TEAM_DISTRIBUTION.md)** - Complete work distribution for 4 members
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Architecture and code organization
- **[LOGO_INTEGRATION_GUIDE.md](LOGO_INTEGRATION_GUIDE.md)** - How to add your logo
- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Development workflow guide

---

## 🎨 Design System

### Colors
- **Primary (Navy Blue):** `#1A2F5A` - Trust, professionalism
- **Secondary (Crimson Red):** `#DC143C` - Nepal's national color
- **Background:** `#FFFFFF` / `#F8F9FA` - Clean, accessible

### Typography
- Material Design 3 default fonts
- Clear hierarchy and readability

### Components
- Cards with 12px border radius
- Elevated buttons with rounded corners
- Consistent spacing (8px grid system)

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform mobile framework |
| **Dart** | Programming language |
| **Material Design 3** | UI/UX design system |
| **Firebase** (Planned) | Backend, Auth, Database |
| **Agora/Jitsi** (Planned) | Video calling |

---

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

---

## 🤝 Contributing

This is a student project. Contributions from team members:

1. Create feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -am 'Add feature'`
3. Push branch: `git push origin feature/your-feature`
4. Create Pull Request
5. Wait for review & approval

### Code Standards
- ✅ Follow existing code style
- ✅ Add comments for complex logic
- ✅ No linter errors
- ✅ Test your changes
- ✅ Update documentation

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- Inspired by **Timely Care** and modern telehealth platforms
- Built with ❤️ for improving healthcare access in Nepal
- Thanks to our instructors and mentors

---

## 📞 Contact

**Project Repository:** [GitHub Link]  
**Team Lead:** Sachin Shrestha  
**Email:** [Your Email]

---

## 🗺️ Roadmap

### Phase 1 (Current) - Base Application ✅
- [x] Project structure
- [x] Basic UI screens
- [x] Navigation system
- [x] Design system

### Phase 2 - Core Features 🔄
- [ ] Firebase integration
- [ ] User authentication
- [ ] Appointment booking
- [ ] Video consultations

### Phase 3 - Advanced Features
- [ ] Payment integration
- [ ] Prescription management
- [ ] Analytics dashboard
- [ ] Multi-language support

### Phase 4 - Launch
- [ ] Beta testing
- [ ] Bug fixes & optimization
- [ ] App store deployment
- [ ] Marketing materials

---

<div align="center">
  <p><strong>Made with ❤️ in Nepal 🇳🇵</strong></p>
  <p>Connect Well Nepal - Bridging Healthcare Gaps Through Technology</p>
</div>
