import 'package:flutter/material.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class PaymentSuccess extends StatelessWidget {
  final String? title, subBtnTitle, btnTitle, subTitle;
  final VoidCallback? callback;
  const PaymentSuccess(
      {Key? key,
      this.title,
      this.subTitle,
      this.subBtnTitle = "",
      this.btnTitle,
      this.callback})
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
                const SizedBox(height: 20),
                const Text(
                  "SUCCESS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subTitle!,
                  style: const TextStyle(
                      color: Colors.white54,
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
                      const SizedBox(
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
                    onTap: callback,
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
                ),
                const SizedBox(height: 20),
                subBtnTitle!.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(page: 1))),
                          child: Center(
                            child: Text(
                              subBtnTitle!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
