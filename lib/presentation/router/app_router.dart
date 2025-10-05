import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/placeholder_page.dart';
import '../pages/onboarding/splash_screen.dart';
import '../pages/onboarding/onboarding_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      // Flow 1: First-Time User Experience (Onboarding)
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const PlaceholderPage(title: 'Sign Up Screen'),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const PlaceholderPage(title: 'Login Screen'),
      ),
      GoRoute(
        path: '/grade-stream',
        builder: (context, state) => const PlaceholderPage(title: 'Grade & Stream Selection'),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PlaceholderPage(title: 'Permissions Request'),
      ),
      
      // Flow 2: The Core Learning Journey
      GoRoute(
        path: '/home',
        builder: (context, state) => const PlaceholderPage(title: 'Home / Subject Dashboard'),
      ),
      GoRoute(
        path: '/subject/:id',
        builder: (context, state) => const PlaceholderPage(title: 'Subject Detail Screen'),
      ),
      GoRoute(
        path: '/quiz/start/:topicId',
        builder: (context, state) => const PlaceholderPage(title: 'Quiz Start Screen'),
      ),
      GoRoute(
        path: '/quiz/question/:quizId',
        builder: (context, state) => const PlaceholderPage(title: 'Quiz Question Screen'),
      ),
      GoRoute(
        path: '/quiz/results/:quizId',
        builder: (context, state) => const PlaceholderPage(title: 'Quiz Results Screen'),
      ),
      GoRoute(
        path: '/past-exams/:subjectId',
        builder: (context, state) => const PlaceholderPage(title: 'Past Exam List Screen'),
      ),
      GoRoute(
        path: '/exam/:examId',
        builder: (context, state) => const PlaceholderPage(title: 'Exam Reader / Practice Screen'),
      ),
      GoRoute(
        path: '/flashcards/:topicId',
        builder: (context, state) => const PlaceholderPage(title: 'Flashcard Deck Screen'),
      ),
      GoRoute(
        path: '/flashcards/results/:deckId',
        builder: (context, state) => const PlaceholderPage(title: 'Flashcard Deck Summary'),
      ),
      
      // Flow 3: Progress & Personalization
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const PlaceholderPage(title: 'Progress Analytics Dashboard'),
      ),
      GoRoute(
        path: '/report/:subjectId',
        builder: (context, state) => const PlaceholderPage(title: 'Detailed Subject Report Screen'),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const PlaceholderPage(title: 'Profile Screen'),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const PlaceholderPage(title: 'Settings Screen'),
      ),
      GoRoute(
        path: '/storage',
        builder: (context, state) => const PlaceholderPage(title: 'Storage Management Screen'),
      ),
      
      // Flow 4: Business & Support
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const PlaceholderPage(title: 'Subscription / Pricing Screen'),
      ),
    ],
  );
}