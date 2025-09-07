# VoiceCal - AI Copilot Instructions

## Code instructions
- the file max is 100 lines
- make reusable components
- follow best practices
- write clean code
- follow the architecture and patterns described below
- write comments where necessary
- use meaningful names
- consider performance 

## Project Overview
VoiceCal is a voice-powered calorie tracking Flutter application designed for intuitive nutrition management. Users can track their meals, set nutrition goals, and manage their dietary intake primarily through voice interactions.

## Core Technology Stack
- **Flutter**: Cross-platform mobile development with multi-flavor support
- **Firebase**: firebase distribution,
- **Supabase**: the main Alternative backend for additional data services
- **BLoC Pattern**: State management with flutter_bloc
- **Dio + Retrofit**: Type-safe HTTP networking with automatic code generation
- **Hive**: Local storage and caching
- **ScreenUtil**: Responsive design system
- **Voice Integration**: Primary input method for meal tracking

## Architecture
### Clean Architecture with Feature-Based Organization
```
lib/
├── core/                    # Shared infrastructure
│   ├── di/                 # Dependency injection
│   ├── helpers/            # Utility functions
│   ├── networking/         # API clients & networking setup
│   ├── routing/            # Navigation configuration
│   ├── theme/              # App colors, typography, themes
│   └── widgets/            # Reusable UI components
└── features/               # Feature modules
    └── onboarding/         # User onboarding flow
        ├── data/           # Repositories, data sources
        └── presentation/   # Screens, widgets, BLoC
```

### Multi-Flavor Configuration
- **Development**: `com.example.voicecal.dev` - Firebase project: `voice-cal-a63f4`
- **Production**: `com.example.voicecal` - Firebase project: `voice-cal-a63f4`

Entry points:
- `lib/main_development.dart` - Development flavor
- `lib/main_production.dart` - Production flavor

## Key Dependencies & Patterns

### State Management
- **flutter_bloc**: Primary state management
- Pattern: BLoC with Events, States, and Repositories
- Local state: Use StatefulWidget for simple UI state

### Networking
- **dio**: HTTP client with interceptors
- **retrofit**: Type-safe API client generation
- **pretty_dio_logger**: Development logging
- Pattern: Repository pattern with data sources

### Storage
- **hive**: Local object storage and caching
- **flutter_secure_storage**: Sensitive data storage
- **shared_preferences**: Simple key-value storage
- **firebase_core**: Cloud data persistence

### Authentication
- **firebase_core**: Primary auth provider
- **google_sign_in**: Google OAuth integration
- **flutter_facebook_auth**: Facebook login
- Pattern: Unified auth repository with multiple providers

### UI/UX
- **flutter_screenutil**: Responsive design (375x812 base)
- **lottie**: Animations and micro-interactions
- **skeletonizer**: Loading states
- **iOS Design Language**: Premium iOS-style components

## Development Workflow

### Build & Run Commands
```bash
# Development flavor
flutter run --flavor development --target lib/main_development.dart

# Production flavor  
flutter run --flavor production --target lib/main_production.dart

# Build APK
flutter build apk --flavor development --target lib/main_development.dart
```

### Code Generation
```bash
# Generate code for all builders
flutter packages pub run build_runner build

# Watch for changes
flutter packages pub run build_runner watch

# Clean generated files
flutter packages pub run build_runner clean
```

### Firebase Configuration
- Development: `android/app/src/development/google-services.json`
- Production: `android/app/src/main/google-services.json`
- Each flavor requires separate Firebase app configuration

## Voice Calorie Tracking Features

### Core Functionality
1. **Voice Input**: Primary interaction method for logging meals
2. **Nutrition Database**: Food recognition and calorie calculation
3. **Goal Setting**: Daily calorie and macro targets
4. **Progress Tracking**: Historical data and analytics
5. **Social Features**: Sharing and community aspects

### user Journey
User Journey

1. Welcome Screen – Premium iOS-style introduction.

2. Onboarding (step-by-step, clean screens):

Gender → Age → Height & Weight → Activity → Goal Weight → Goal Speed → Calorie Rollover → Results.

3. Home Dashboard – Daily calorie target, progress bar, and quick “Log Meal” button.

4. Meal Logging – User taps 🎤, says their meal, app transcribes + parses into food items.

5. Tracking & Analysis – Line/bar charts (using fl_chart) show calories/macros vs. goals.

6. Insights Screen – Weekly reports, tips, and adjustments.

### Current Implementation Status
- ✅ Multi-flavor build system
- ✅ Firebase integration
- ✅ Welcome screen with premium iOS design
- 🚧 Voice recognition (planned)
- 🚧 Nutrition tracking (planned)
- 🚧 User authentication (planned)

## Coding Standards

### File Organization
- Feature-based modules in `lib/features/`
- Shared code in `lib/core/`
- Follow clean architecture principles
- Group related files by feature, not by type

### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/functions: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Private members: prefix with `_`

### Widget Design
- Use **ScreenUtil** for responsive sizing
- Follow iOS design language for premium feel
- Implement proper loading states with **Skeletonizer**
- Add haptic feedback for user interactions
- Support both light and dark themes

### State Management Pattern
```dart
// BLoC Event
class LoadUserProfile extends ProfileEvent {}

// BLoC State  
class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);
}

// Repository Pattern
class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;
  
  Future<User> getProfile() async {
    try {
      final user = await _remoteDataSource.getProfile();
      await _localDataSource.cacheProfile(user);
      return user;
    } catch (e) {
      return _localDataSource.getCachedProfile();
    }
  }
}
```

### Error Handling
- Use `Either<Failure, Success>` pattern for repositories
- Implement proper error states in BLoC
- Provide user-friendly error messages
- Log errors appropriately for debugging

## Testing Strategy
- Unit tests for business logic and repositories
- Widget tests for UI components
- Integration tests for critical user flows
- Mock external dependencies (Firebase, APIs)

## Common Tasks

### Adding a New Feature
1. Create feature directory in `lib/features/`
2. Implement data layer (repositories, data sources)
3. Create BLoC for state management
4. Build presentation layer (screens, widgets)
5. Add navigation routes
6. Write tests

### Firebase Integration
1. Add service to Firebase console for each flavor
2. Download `google-services.json` to appropriate directories
3. Configure `firebase_options.dart`
4. Initialize in main entry points
5. Implement service-specific repositories

### API Integration
1. Define models with **json_annotation**
2. Create Retrofit API client
3. Implement repository with error handling
4. Add to dependency injection
5. Generate code with **build_runner**

## Voice Integration Considerations
- **Speech-to-Text**: For meal input and commands
- **Natural Language Processing**: Parse food descriptions
- **Offline Capability**: Cache voice recognition for poor connectivity
- **Privacy**: Local processing when possible
- **Accessibility**: Support for users with different speech patterns

## Performance Guidelines
- Use **Hive** for frequently accessed data
- Implement proper image caching for food photos
- Optimize voice processing for real-time feedback
- Use **Skeletonizer** for smooth loading experiences
- Implement pagination for large data sets

## Security Best Practices
- Store sensitive data in **flutter_secure_storage**
- Validate all voice input before processing
- Implement proper Firebase security rules
- Use HTTPS for all network requests
- Sanitize user-generated content

## Deployment
- Fastlane configuration for automated builds
- Separate Firebase projects for development/production
- Environment-specific configuration management
- Automated testing in CI/CD pipeline

This guide should enable AI coding agents to immediately understand the VoiceCal architecture, contribute effectively to voice-powered nutrition tracking features, and maintain code quality standards.
