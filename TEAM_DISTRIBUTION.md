# 🇳🇵 Connect Well Nepal - Team Work Distribution

**Project Type:** Telehealth Application (Similar to Timely Care)  
**Team Size:** 4 Members  
**Timeline:** Semester Project  
**Tech Stack:** Flutter, Firebase (future), Material Design 3

---

## 📱 Current Base Application Features

✅ **Implemented (Base Version):**
- Splash Screen with branding
- Home Screen with nearby clinics
- Quick action buttons (Consult Now, Book Appointment)
- Bottom navigation (4 tabs)
- Profile management screen
- Appointments screen (skeleton)
- Consultation types screen (Video/Voice/Chat)
- Health Resources screen (skeleton)
- Clean architecture with proper folder structure

---

## 👥 Team Member Assignments

### 🔵 **TEAM MEMBER 1: Appointments & Booking System**
**Focus Area:** `lib/screens/appointments_screen.dart`

**Primary Tasks:**
1. **Appointment Booking Flow** (Week 1-2)
   - Create `booking_screen.dart` with date/time picker
   - Add doctor selection interface
   - Implement appointment reason/symptoms form
   - Add confirmation screen

2. **Appointment Management** (Week 3-4)
   - Display upcoming appointments list
   - Display past appointments with details
   - Add cancel/reschedule functionality
   - Implement appointment notifications (local notifications)

3. **Doctor Profile Screen** (Week 5)
   - Create `doctor_profile_screen.dart`
   - Show doctor details (specialization, experience, rating)
   - Show available time slots
   - Add reviews/ratings display

**Files to Create:**
- `lib/screens/booking_screen.dart`
- `lib/screens/doctor_profile_screen.dart`
- `lib/models/appointment_model.dart`
- `lib/models/doctor_model.dart`
- `lib/widgets/appointment_card.dart`
- `lib/widgets/time_slot_selector.dart`

**Packages to Add:**
```yaml
table_calendar: ^3.0.9  # For calendar view
flutter_local_notifications: ^17.0.0  # For appointment reminders
```

**Integration Points:**
- Connect with Team Member 4 for Firebase database
- Work with Team Member 2 for consultation flow

---

### 🔴 **TEAM MEMBER 2: Video/Voice Consultation**
**Focus Area:** `lib/screens/consultation_screen.dart`

**Primary Tasks:**
1. **Video Call Integration** (Week 1-3)
   - Research and integrate video SDK (Agora/Jitsi/100ms)
   - Create `video_call_screen.dart`
   - Implement video controls (mute, video on/off, flip camera)
   - Add in-call UI (timer, participant info)

2. **Voice Call Integration** (Week 3-4)
   - Create `voice_call_screen.dart`
   - Add audio-only controls
   - Implement call quality indicators

3. **Chat Consultation** (Week 4-5)
   - Create `chat_screen.dart`
   - Implement real-time messaging UI
   - Add message types (text, image, file)
   - Add typing indicators

4. **Call History & Recordings** (Week 6)
   - Add consultation history
   - Store call metadata
   - Add prescription sharing post-call

**Files to Create:**
- `lib/screens/video_call_screen.dart`
- `lib/screens/voice_call_screen.dart`
- `lib/screens/chat_screen.dart`
- `lib/models/message_model.dart`
- `lib/services/video_call_service.dart`
- `lib/widgets/message_bubble.dart`

**Packages to Add:**
```yaml
agora_rtc_engine: ^6.3.0  # Video/Voice calling
# OR
jitsi_meet_flutter_sdk: ^9.0.0  # Alternative
image_picker: ^1.0.7  # For sending images in chat
file_picker: ^8.0.0  # For sending files
```

**Integration Points:**
- Connect with Team Member 1 for appointment-to-call flow
- Work with Team Member 4 for Firebase Realtime Database (chat)

---

### 🟢 **TEAM MEMBER 3: Health Resources & Content**
**Focus Area:** `lib/screens/resources_screen.dart`

**Primary Tasks:**
1. **Content Management** (Week 1-2)
   - Design article detail page `article_detail_screen.dart`
   - Create category pages for each health topic
   - Add search functionality
   - Implement bookmarking/favorites

2. **Mental Health & Self-Care** (Week 3-4)
   - Create mental wellness section
   - Add mood tracker widget
   - Implement self-assessment tools
   - Add meditation/breathing exercises

3. **COVID-19 & Emergency Info** (Week 4-5)
   - Create COVID info dashboard
   - Add symptom checker
   - Emergency contacts quick dial
   - Vaccination tracking

4. **Video Content** (Week 5-6)
   - Add health education videos
   - Create video player screen
   - Add video categories
   - Implement video progress tracking

**Files to Create:**
- `lib/screens/article_detail_screen.dart`
- `lib/screens/category_screen.dart`
- `lib/screens/mood_tracker_screen.dart`
- `lib/screens/video_player_screen.dart`
- `lib/models/article_model.dart`
- `lib/models/video_model.dart`
- `lib/widgets/article_card.dart`
- `lib/widgets/mood_selector.dart`

**Packages to Add:**
```yaml
youtube_player_flutter: ^9.0.0  # For video playback
webview_flutter: ^4.7.0  # For web content
share_plus: ^7.2.2  # For sharing articles
url_launcher: ^6.2.5  # For opening external links
```

**Integration Points:**
- Work with Team Member 4 for Firebase Storage (videos/images)
- Coordinate with all members for consistent UI/UX

---

### 🟡 **TEAM MEMBER 4: Backend, Authentication & Profile**
**Focus Area:** `lib/services/` and `lib/screens/profile_screen.dart`

**Primary Tasks:**
1. **Firebase Setup** (Week 1)
   - Initialize Firebase in the project
   - Set up Authentication (Email, Google, Phone)
   - Configure Firestore database
   - Set up Firebase Storage

2. **Authentication Flow** (Week 2-3)
   - Create `login_screen.dart`
   - Create `signup_screen.dart`
   - Create `forgot_password_screen.dart`
   - Add phone OTP verification
   - Implement persistent login

3. **User Profile Management** (Week 3-4)
   - Enhance existing `profile_screen.dart`
   - Add profile image upload
   - Create `edit_profile_screen.dart`
   - Add medical records upload
   - Implement data persistence to Firestore

4. **Backend Services** (Week 4-6)
   - Create `auth_service.dart`
   - Create `database_service.dart`
   - Create `storage_service.dart`
   - Create `notification_service.dart`
   - Add error handling and loading states

5. **Admin Panel (Bonus)** (Week 6)
   - Create simple web dashboard
   - Manage users and appointments
   - Content management for resources

**Files to Create:**
- `lib/screens/login_screen.dart`
- `lib/screens/signup_screen.dart`
- `lib/screens/forgot_password_screen.dart`
- `lib/screens/edit_profile_screen.dart`
- `lib/services/auth_service.dart`
- `lib/services/database_service.dart`
- `lib/services/storage_service.dart`
- `lib/services/notification_service.dart`
- `lib/models/user_model.dart`
- `lib/utils/validators.dart`

**Packages to Add:**
```yaml
firebase_core: ^2.27.0
firebase_auth: ^4.17.8
cloud_firestore: ^4.15.8
firebase_storage: ^11.6.9
google_sign_in: ^6.2.1
firebase_messaging: ^14.7.19  # Push notifications
```

**Integration Points:**
- Support ALL team members with backend integration
- Provide services for data persistence
- Manage user authentication state across app

---

## 📋 Shared Responsibilities

### **All Team Members:**
- Follow existing code style and comments
- Test your features thoroughly
- Use Git branches for development
- Regular code reviews
- Update documentation

### **Weekly Meetings:**
- **Monday:** Sprint planning & task review
- **Wednesday:** Progress check-in
- **Friday:** Code review & integration

---

## 🗂️ Folder Structure (Final)

```
lib/
├── main.dart
├── models/
│   ├── clinic_model.dart ✅
│   ├── appointment_model.dart [Member 1]
│   ├── doctor_model.dart [Member 1]
│   ├── message_model.dart [Member 2]
│   ├── article_model.dart [Member 3]
│   ├── video_model.dart [Member 3]
│   └── user_model.dart [Member 4]
├── screens/
│   ├── splash_screen.dart ✅
│   ├── main_screen.dart ✅
│   ├── profile_screen.dart ✅
│   ├── appointments_screen.dart ✅
│   ├── consultation_screen.dart ✅
│   ├── resources_screen.dart ✅
│   ├── booking_screen.dart [Member 1]
│   ├── doctor_profile_screen.dart [Member 1]
│   ├── video_call_screen.dart [Member 2]
│   ├── voice_call_screen.dart [Member 2]
│   ├── chat_screen.dart [Member 2]
│   ├── article_detail_screen.dart [Member 3]
│   ├── mood_tracker_screen.dart [Member 3]
│   ├── login_screen.dart [Member 4]
│   ├── signup_screen.dart [Member 4]
│   └── edit_profile_screen.dart [Member 4]
├── widgets/
│   ├── clinic_card.dart ✅
│   └── [Add more reusable widgets]
├── services/
│   ├── auth_service.dart [Member 4]
│   ├── database_service.dart [Member 4]
│   ├── storage_service.dart [Member 4]
│   ├── video_call_service.dart [Member 2]
│   └── notification_service.dart [Member 4]
└── utils/
    ├── colors.dart ✅
    ├── validators.dart [Member 4]
    └── constants.dart [All]
```

---

## 🎯 Milestones & Timeline

### **Week 1-2: Foundation**
- Member 1: Booking UI skeleton
- Member 2: Research video SDK, basic integration
- Member 3: Content structure & article pages
- Member 4: Firebase setup & authentication

### **Week 3-4: Core Features**
- Member 1: Full appointment booking flow
- Member 2: Video call working prototype
- Member 3: Resource categories & mood tracker
- Member 4: User profiles with Firebase

### **Week 5-6: Integration & Polish**
- All: Integrate features together
- All: Bug fixes and testing
- All: UI/UX improvements
- All: Documentation

### **Week 7: Final Delivery**
- Code review and cleanup
- Final testing
- Presentation preparation
- Demo video

---

## 🚀 Getting Started (For Each Member)

### **Step 1: Setup**
```bash
# Pull latest code
git pull origin main

# Create your feature branch
git checkout -b feature/[your-name]-[feature]

# Example:
# git checkout -b feature/sachin-appointments
```

### **Step 2: Add Your Packages**
Edit `pubspec.yaml` and add your required packages

```bash
flutter pub get
```

### **Step 3: Development**
- Create your screens/services
- Test frequently with `flutter run`
- Commit regularly

### **Step 4: Testing**
```bash
# Run tests
flutter test

# Check for errors
flutter analyze
```

### **Step 5: Merge**
- Create Pull Request
- Get code review from team
- Merge after approval

---

## 📞 Communication

**Group Chat:** [Your preferred platform]  
**Code Repository:** GitHub  
**Documentation:** This file + code comments  
**Issues:** Use GitHub Issues for bug tracking

---

## 💡 Tips for Success

1. **Start Simple:** Get basic version working first
2. **Commit Often:** Small, meaningful commits
3. **Ask for Help:** Don't get stuck for hours
4. **Code Reviews:** Learn from each other's code
5. **Testing:** Test on real devices, not just emulator
6. **Documentation:** Comment your code well
7. **UI Consistency:** Use AppColors and shared widgets

---

## 📝 Additional Resources

### **Learning Materials:**
- Flutter Docs: https://flutter.dev/docs
- Firebase Flutter: https://firebase.flutter.dev
- Material Design 3: https://m3.material.io

### **Video Tutorials:**
- Flutter Firebase Auth: [YouTube]
- Agora Video Call: [Agora Docs]
- Flutter State Management: [Flutter Docs]

---

## ✅ Definition of Done

A feature is complete when:
- ✅ Code is written and working
- ✅ No linter errors
- ✅ Tested on Android/iOS
- ✅ Properly commented
- ✅ Integrated with backend (if applicable)
- ✅ Reviewed by at least 1 team member
- ✅ Merged to main branch

---

**Created:** December 25, 2025  
**Last Updated:** December 25, 2025  
**Version:** 1.0

**Good luck, team! Let's build something amazing! 🚀🇳🇵**

