import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login.dart';
import 'package:flutter_application/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('seen_onboarding', false);
  final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seenOnboarding
          ? const Login()
          : const Onboarding(),
    );
  }
}

