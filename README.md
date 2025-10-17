# 🎤 VoiceCal - AI Voice-Powered Calorie Tracker

> **⚠️ Development Phase**: This application is currently in active development. Features and functionality are being iteratively built and refined.

## 📖 Overview

VoiceCal is an innovative Flutter mobile application that revolutionizes nutrition tracking through voice interactions. By combining AI-powered speech recognition with intelligent food parsing, VoiceCal eliminates the tedium of manual calorie logging—simply speak your meals and let the app handle the rest.

The app provides personalized nutrition planning based on scientific BMR (Basal Metabolic Rate) and TDEE (Total Daily Energy Expenditure) calculations, delivering custom calorie and macronutrient targets tailored to each user's goals, activity level, and preferences.

## ✨ Core Features

- 🎙️ **Voice-First Meal Logging** - Speech-to-text with AI-powered food recognition
- 🎯 **Personalized Nutrition Plans** - BMR/TDEE-based calorie and macro recommendations
- 📊 **Smart Analytics** - Progress tracking with charts and insights
- 📱 **Premium iOS Design** - Beautiful, responsive interface

## 🏗️ Technical Stack

**Framework**
- Flutter SDK ^3.9.0 with Dart
- BLoC Pattern for state management
- Clean Architecture (feature-based)

**Backend**
- Firebase - Authentication & cloud storage
- Supabase - PostgreSQL database
- n8n - AI workflow automation

**UI/UX**
- iOS-style design language
- ScreenUtil - Responsive layouts
- Lottie animations

**Multi-Flavor**
- Development: `com.example.voicecal.dev`
- Production: `com.example.voicecal`

## 🚀 Getting Started

### Installation

```bash
# Clone and setup
git clone https://github.com/zyaddmostafa/VoiceCal.git
cd voicecal
flutter pub get

# Generate code
flutter packages pub run build_runner build

# Run
flutter run --flavor development --target lib/main_development.dart
```

### Build Commands

```bash
# Code generation
flutter packages pub run build_runner build

# Development build
flutter run --flavor development --target lib/main_development.dart

# Production release
flutter build apk --release --flavor production --target lib/main_production.dart
```

## 👨‍💻 Developer

**Zyad Mostafa**
- GitHub: [@zyaddmostafa](https://github.com/zyaddmostafa)

---

**⚠️ Development Status**: This app is under active development. Features are being added and refined iteratively. Not yet available on App Store or Google Play Store.

*VoiceCal - Revolutionizing nutrition tracking through the power of voice! 🎤🥗*
