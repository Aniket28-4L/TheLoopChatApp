import 'package:flutter/material.dart';
import 'phone_input_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/loop_logo.png',  // Add the image path for your logo
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LOOP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/onboarding_image.png',  // Replace with your image path
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Let's talk with your friends and family wherever and whenever",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Updated ElevatedButton with reduced horizontal padding
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => PhoneInputScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  // Black background color for the button
                foregroundColor: Colors.white,  // White text color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Reduced padding
              ),
              child: Text(
                'Continue with phone',
                style: TextStyle(fontSize: 16),  // Adjust font size if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
