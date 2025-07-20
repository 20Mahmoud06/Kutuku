import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/main.dart'; // To access the global sharedPreferences
import 'package:final_project/core/routes/route_names.dart';
import 'package:final_project/core/widgets/custom_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _decideNextScreen();
  }

  Future<void> _decideNextScreen() async {
    // Wait for a few seconds on the splash screen.
    await Future.delayed(const Duration(seconds: 3));

    // Ensure the widget is still in the tree before navigating.
    if (!mounted) return;

    // Check if the user has seen the onboarding screens before.
    final bool hasSeenOnboarding =
        sharedPreferences.getBool('hasSeenOnboarding') ?? false;

    // Check if there is a currently signed-in user.
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (hasSeenOnboarding) {
      // If onboarding has been seen, check auth status.
      if (currentUser != null) {
        // If user is logged in, go to the home page.
        Navigator.pushReplacementNamed(context, RouteNames.home);
      } else {
        // If user is not logged in, go to the login page.
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    } else {
      // If onboarding has not been seen, go to the onboarding screen.
      Navigator.pushReplacementNamed(context, RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF514eb7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'Kutuku',
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            const CustomText(
              text: 'Any shopping just from here',
              fontSize: 18,
              color: Colors.white,
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
