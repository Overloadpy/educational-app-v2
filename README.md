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
├── core/               # Reusable utilities, constants, themes
├── data/               # Data layer: Repositories, data sources, models
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/             # Business logic layer: Use cases, entities, repository interfaces
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/       # UI layer: Screens, widgets, providers, routing
    ├── pages/
    ├── providers/
    └── router/
```

## Development Milestones

1. **Foundation & Scaffolding** (1-2 Weeks)
2. **Entry & Onboarding Flow** (2-3 Weeks)
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