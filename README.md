# Zenith Education App

An educational mobile application for Ethiopian high school students (Grades 9-12) to help them prepare for national exams.

## About

This app serves as a personal study companion, providing:
- Structured & curriculum-aligned content
- Active & interactive learning through quizzes and flashcards
- Personalized guidance with progress tracking
- Offline accessibility for studying anywhere

## Tech Stack

- **Frontend**: Flutter
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Architecture**: Clean Architecture (Presentation, Domain, Data layers)
- **Backend**: Firebase (Authentication, Firestore, Storage)
- **Local Database**: Hive (offline-first)
- **CI/CD**: GitHub Actions

## Project Structure

```
lib/
├── data/               # Data layer: Repositories, models
│   ├── models/         # Data models
│   └── repositories/   # Implementation of repository interfaces
├── domain/             # Business logic layer: Entities, repository interfaces
│   ├── entities/       # Domain entities (User, Subject, Topic, etc.)
│   └── repositories/   # Repository interfaces
└── presentation/       # UI layer: Screens, widgets, providers, routing
    ├── pages/          # UI screens
    ├── providers/      # Riverpod state management
    └── router/         # Application routing
```

## Development Progress

### Phase 1: Foundation & Scaffolding
- Established project structure following Clean Architecture principles
- Set up routing system with GoRouter for all planned screens
- Created placeholder screens for all application features
- Integrated Firebase for future backend services
- Configured Riverpod for state management
- Set up Hive for local data persistence

### Phase 2: Authentication UI
- Implemented Sign Up screen with comprehensive form validation
  - Email format validation
  - Password strength requirements (minimum 8 characters)
  - Password confirmation matching
  - Real-time validation feedback
- Implemented Login screen with form validation
  - Email and password required fields
  - Real-time validation feedback
- Created Riverpod providers for state management of both forms
- Added loading indicators during form submission
- Implemented proper navigation between authentication screens
- All functionality works in demo mode with SnackBar feedback

### Phase 3: Personalization & Data Persistence
- Integrated Hive local database for data persistence
- Created UserModel for storing user information
- Implemented Grade & Stream Selection screen
  - Grade selection for Grades 9-12
  - Conditional stream selection (Natural Science/Social Science) for Grades 11-12
- Connected Sign Up flow to Grade Selection screen
- Implemented data persistence for user preferences
- Verified data survives app restarts
- Created seamless flow from Sign Up → Grade Selection → Permissions

## Key Features Implemented

### Authentication System
- Sign Up with email validation and password requirements
- Login with credential validation
- Form validation with real-time feedback
- Loading states during submission
- Navigation between authentication screens

### User Personalization
- Grade selection (Grades 9-12)
- Stream selection for upper grades (Natural Science/Social Science)
- Persistent user preferences using Hive local database

### Application Architecture
- Clean Architecture with clear separation of concerns
- Riverpod for state management
- GoRouter for navigation
- Domain-driven design with entities and repository patterns
- Local data persistence with Hive

## Current Application Flow

1. **Login Screen** (Initial Route)
   - User can login with credentials
   - Link to Sign Up screen for new users

2. **Sign Up Screen**
   - Form with email, password, and confirm password fields
   - Real-time validation for all fields
   - On successful submission, user data is saved to Hive
   - Navigation to Grade Selection screen

3. **Grade & Stream Selection Screen**
   - User selects their current grade
   - For Grades 11-12, additional stream selection is shown
   - User preferences saved to Hive
   - Navigation to Permissions screen

4. **Other Screens**
   - Placeholder screens for all planned features
   - Full navigation between all screens

## Data Models

### UserModel
- Email (String)
- Grade (String)
- Stream (String, optional)

### Domain Entities
- User
- Subject
- Topic
- QuizQuestion
- Flashcard
- PastExam
- UserProgress

## State Management

The application uses Riverpod for state management with the following providers:
- SignUpProvider (StateNotifierProvider for Sign Up form)
- LoginProvider (StateNotifierProvider for Login form)
- GradeSelectionProvider (StateNotifierProvider for Grade Selection)

## Local Data Persistence

Hive is used for local data storage:
- UserModel stored in 'userBox'
- Data persists through app restarts
- Offline-first approach for user data

## Development Milestones

1. **Foundation & Scaffolding** (1-2 Weeks) - COMPLETED
2. **Entry & Onboarding Flow** (2-3 Weeks) - IN PROGRESS
3. **Core Learning Experience** (5-6 Weeks)
4. **Personalization & Engagement Layer** (2-3 Weeks)
5. **Business Integration & Launch** (3-4 Weeks)

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Set up Firebase project and add configuration files
4. Run `flutter run`

## Contributing

This project is under active development. Please check back later for contribution guidelines.