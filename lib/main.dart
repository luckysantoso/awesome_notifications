import 'package:study_firebase_v2/screens/login.dart';
import 'package:study_firebase_v2/screens/register.dart';
import 'package:study_firebase_v2/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:study_firebase_v2/services/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Notification Demo',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      initialRoute: 'login',
      routes: {
        'home': (context) => const HomeScreen(),
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
      },
    );
  }
}
