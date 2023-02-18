import 'package:flutter/material.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class RegSuccessful extends StatelessWidget {
  const RegSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: deepKoamaru,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Positioned(
                        top: 80,
                        child: Image.asset(
                          "assets/images/polygon3.png",
                          color: Colors.white,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 70,
                        right: 0,
                        child: Image.asset(
                          "assets/images/box.png",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "CONGRATULATIONS!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your account was created successfully. Please take a",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat"),
                ),
                const Text(
                  "moment to verify your email address. We sent an email",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat"),
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "with a verification link to ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat")),
                  TextSpan(
                      text: SessionManager().userEmailVal,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat")),
                  const TextSpan(
                      text:
                          " if you did not receive this in your inbox, please",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat")),
                ])),
                const Text(
                  " check your spam folder.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(
                  width: 250,
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Positioned(
                        // top: 70,
                        left: 20,
                        child: Image.asset(
                          "assets/images/box.png",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 100,
                        width: 100,
                        // color: Colors.black,
                      ),
                      Positioned(
                        top: 30,
                        right: 100,
                        child: Image.asset(
                          "assets/images/polygon3.png",
                          color: Colors.white,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRouter.login),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: const Center(
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: deepKoamaru,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
