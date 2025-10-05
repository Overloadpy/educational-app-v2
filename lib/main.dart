import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Only initialize Firebase for mobile platforms
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    try {
      // Firebase initialization would go here in a full implementation
      // For now, we'll skip it to allow web testing
      if (kDebugMode) {
        print('Firebase initialization skipped for web testing');
      }
    } catch (e) {
      // Firebase initialization failed, continue without it for development
      if (kDebugMode) {
        print('Firebase initialization failed: $e');
      }
    }
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Zenith Education App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

