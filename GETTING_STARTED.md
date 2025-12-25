# 🚀 Getting Started - Connect Well Nepal

## For All Team Members

Welcome to the Connect Well Nepal project! This guide will help you get started.

---

## ✅ Setup Checklist

### 1️⃣ Development Environment

Make sure you have:
- [ ] Flutter SDK 3.27+ installed
- [ ] Android Studio or VS Code installed
- [ ] Flutter extension/plugin installed
- [ ] Android Emulator or iOS Simulator set up
- [ ] Git installed and configured

### 2️⃣ Verify Installation

```bash
# Check Flutter installation
flutter doctor

# Should see all green checkmarks (✓)
```

### 3️⃣ Clone & Setup

```bash
# Clone the repository (if not already done)
git clone [repository-url]
cd connect-well-nepal

# Get dependencies
flutter pub get

# Run the app
flutter run
```

---

## 👨‍💻 For Each Team Member

### **Step 1: Understand Your Assignment**

Read `TEAM_DISTRIBUTION.md` to find your specific tasks:
- **Member 1:** Appointments & Booking
- **Member 2:** Video/Voice Consultations  
- **Member 3:** Health Resources & Content
- **Member 4:** Backend & Authentication

### **Step 2: Create Your Branch**

```bash
# Create a branch for your work
git checkout -b feature/[your-name]-[feature]

# Examples:
# git checkout -b feature/john-appointments
# git checkout -b feature/sarah-video-calls
# git checkout -b feature/ram-resources
# git checkout -b feature/sita-firebase
```

### **Step 3: Explore the Codebase**

Key files to review:
1. `lib/main.dart` - App entry point
2. `lib/screens/main_screen.dart` - Main navigation
3. Your assigned screen file
4. `lib/utils/colors.dart` - Color palette

### **Step 4: Run the App**

```bash
# Start the app in debug mode
flutter run

# Or use VS Code/Android Studio run button
```

You should see:
- Splash screen with Connect Well Nepal branding
- Home screen with nearby clinics
- Bottom navigation with 4 tabs
- All basic screens accessible

---

## 📝 Daily Development Workflow

### Morning Routine

```bash
# 1. Update your local code
git checkout main
git pull origin main

# 2. Switch to your feature branch
git checkout feature/your-branch

# 3. Merge latest changes
git merge main

# 4. Start coding!
```

### During Development

```bash
# Test frequently
flutter run

# Check for errors
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test
```

### End of Day

```bash
# 1. Add your changes
git add .

# 2. Commit with clear message
git commit -m "feat: Add appointment booking screen"

# 3. Push to your branch
git push origin feature/your-branch
```

### Commit Message Format

```
feat: Add new feature
fix: Fix bug in profile screen
docs: Update documentation
style: Format code
refactor: Refactor appointment logic
test: Add tests for booking
```

---

## 🔧 Common Commands

### Flutter Commands

```bash
# Clean build files
flutter clean

# Get dependencies
flutter pub get

# Run app (debug mode)
flutter run

# Run app (release mode)
flutter run --release

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/

# Check outdated packages
flutter pub outdated
```

### Git Commands

```bash
# Check status
git status

# See all branches
git branch -a

# Switch branch
git checkout branch-name

# Pull latest changes
git pull

# Push your changes
git push

# View commit history
git log --oneline
```

---

## 🐛 Troubleshooting

### Problem: "Flutter not found"

```bash
# Add Flutter to PATH
# On Mac/Linux (add to ~/.bashrc or ~/.zshrc):
export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/bin"

# On Windows:
# Add Flutter bin folder to System Environment Variables
```

### Problem: "Gradle error" (Android)

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Problem: "Pod install failed" (iOS)

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

### Problem: "Package version conflict"

```bash
flutter pub upgrade
flutter clean
flutter pub get
```

### Problem: "Hot reload not working"

```bash
# Press 'R' in terminal for full restart
# Or stop and re-run: flutter run
```

---

## 📚 Learning Resources

### Essential Flutter Docs
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io)

### Video Tutorials
- [Flutter Official YouTube](https://www.youtube.com/c/flutterdev)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)

### Community
- [Flutter Community Slack](https://fluttercommunity.dev)
- [r/FlutterDev Reddit](https://www.reddit.com/r/FlutterDev/)
- [Stack Overflow Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)

---

## 🎯 First Week Goals

### All Members:
- [ ] Set up development environment
- [ ] Run the app successfully
- [ ] Understand project structure
- [ ] Read TEAM_DISTRIBUTION.md
- [ ] Explore your assigned screen
- [ ] Attend first team meeting

### By Member:

**Member 1 (Appointments):**
- [ ] Create `appointment_model.dart`
- [ ] Design booking screen UI
- [ ] Research date/time picker

**Member 2 (Video Calls):**
- [ ] Research video SDK options (Agora vs Jitsi)
- [ ] Test simple video call example
- [ ] Plan video UI

**Member 3 (Resources):**
- [ ] Collect sample health articles
- [ ] Design article detail screen
- [ ] Plan content categories

**Member 4 (Firebase):**
- [ ] Create Firebase project
- [ ] Set up Firebase in Flutter
- [ ] Design user model
- [ ] Plan auth flow

---

## 💬 Communication

### Team Meetings
- **Monday 10 AM:** Weekly planning
- **Wednesday 2 PM:** Progress check
- **Friday 4 PM:** Code review

### Quick Questions
- Use team chat for quick questions
- Tag relevant team member
- Share screenshots/code snippets

### Blocker Issues
- Create GitHub Issue
- Tag as "blocker"
- Mention in team chat

---

## ✅ Definition of Ready

Before starting a task, ensure:
- [ ] Task is clearly defined
- [ ] You understand the requirements
- [ ] You know which files to modify
- [ ] You have necessary resources
- [ ] Your dev environment works

---

## ✅ Definition of Done

A task is complete when:
- [ ] Feature works as expected
- [ ] Code is well-commented
- [ ] No linter errors (`flutter analyze`)
- [ ] Tested on device/emulator
- [ ] Committed to Git
- [ ] Pull request created
- [ ] Code reviewed by team member

---

## 🎓 Code Review Checklist

When reviewing teammate's code:
- [ ] Code follows existing style
- [ ] Logic is clear and commented
- [ ] No hardcoded values (use constants)
- [ ] Proper error handling
- [ ] UI matches design
- [ ] No performance issues
- [ ] Works on both Android/iOS (if applicable)

---

## 🆘 Need Help?

1. **Check Documentation:** README, TEAM_DISTRIBUTION, PROJECT_STRUCTURE
2. **Search Code:** Use VS Code search (Cmd/Ctrl + Shift + F)
3. **Ask Team:** Team chat or meeting
4. **Google It:** Most issues have solutions online
5. **Official Docs:** Flutter/Firebase documentation

---

## 🎉 You're Ready!

You now have everything you need to start contributing to Connect Well Nepal!

**Next Steps:**
1. ✅ Run `flutter run` and see the app
2. ✅ Read your specific section in TEAM_DISTRIBUTION.md
3. ✅ Create your feature branch
4. ✅ Start coding your first task
5. ✅ Have fun! 🚀

---

**Remember:** We're a team. Help each other, share knowledge, and build something amazing together!

<div align="center">
  <p><strong>Happy Coding! 🇳🇵</strong></p>
</div>

