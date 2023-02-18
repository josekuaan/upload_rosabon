import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class Success extends StatelessWidget {
  String? title, subTitle, btnTitle;
  Success({Key? key, this.title, this.subTitle, this.btnTitle})
      : super(key: key);

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
                Text(
                  title == null ? "" : title!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  subTitle!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(
                  width: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 20,
                        child: Image.asset(
                          "assets/images/box.png",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        // color: Colors.black,
                      ),
                      Positioned(
                        top: 70,
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        btnTitle!,
                        style: const TextStyle(
                            color: deepKoamaru,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
