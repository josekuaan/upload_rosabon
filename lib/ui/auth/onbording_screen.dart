import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: deepKoamaru,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Expanded(
                  child: SizedBox(
                    width: 220,
                    child: Text(
                      "Please select the category that best describes you",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRouter.signup),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: const Center(
                            child: Text(
                              "Register as an Individual",
                              style: TextStyle(
                                  color: deepKoamaru,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRouter.cSignup),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white.withOpacity(0.02)),
                          child: const Center(
                            child: Text(
                              "Register as a Corporate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 80,
                ),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Montserrat"),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.login,
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
