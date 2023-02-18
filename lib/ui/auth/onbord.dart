import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5),
        () => Navigator.pushNamed(context, AppRouter.onboarding1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: deepKoamaru,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 40,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset("assets/images/logo_text.png")),
                      ),
                      Positioned(
                          top: 120,
                          right: 0,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset("assets/images/star1.png",
                                scale: 0.9),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.asset("assets/images/vector1.png"),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      const SizedBox(
                        width: 200,
                        child: Text("Reach your Financial goal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat")),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
