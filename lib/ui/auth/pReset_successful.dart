import 'package:flutter/material.dart';
import 'package:rosabon/ui/auth/login_screen.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class PasswordResetSuccessful extends StatefulWidget {
  const PasswordResetSuccessful({Key? key}) : super(key: key);

  @override
  State<PasswordResetSuccessful> createState() =>
      _PasswordResetSuccessfulState();
}

class _PasswordResetSuccessfulState extends State<PasswordResetSuccessful> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: deepKoamaru,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
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
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 60,
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
                  "SUCCESS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password Reset Successfully",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat"),
                ),
                // const Text(
                //   "successfully",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       fontFamily: "Montserrat"),
                // ),
                const SizedBox(height: 40),
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
                        top: 25,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: const Center(
                      child: Text(
                        "Go back to sign in",
                        style: TextStyle(
                            color: deepKoamaru,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
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
