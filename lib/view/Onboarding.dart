import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsflash/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          SharedPreferences prefs = snapshot.data as SharedPreferences;

          // Check if the user has already seen onboarding
          bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

          if (hasSeenOnboarding) {
            // User has seen onboarding, check login status
            return Home();
          } else {
            // User hasn't seen onboarding, show onboarding screens
            return OnboardingScreen(prefs: prefs);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const OnboardingScreen({required this.prefs});

  void _markOnboardingAsSeen() {
    prefs.setBool('hasSeenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.purple])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation/animation_onboard.json',
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
              ),

              Text(
                ' Let’s Start, \n Your Digital NewsPaper',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              // Add your onboarding content here
              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  _markOnboardingAsSeen();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(' Start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10), // Circular top corners
                      bottom: Radius.circular(10), // Circular bottom corners
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
