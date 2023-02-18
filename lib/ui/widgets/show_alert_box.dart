import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/success.dart';

Future<dynamic> showAlertBox(BuildContext context, String? name) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 12),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.close, color: deepKoamaru, size: 30))),
            titlePadding: EdgeInsets.zero,
            content: SizedBox(
              height: 270,
              child: Column(
                children: [
                  const Icon(Icons.info, color: deepKoamaru, size: 50),
                  SizedBox(
                    width: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          // top: 70,
                          right: 20,
                          child: Image.asset(
                            "assets/images/box.png",
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const SizedBox(
                          height: 70,
                          width: 70,
                          // color: Colors.black,
                        ),
                        Positioned(
                          top: 25,
                          left: 20,
                          child: Image.asset(
                            "assets/images/polygon3.png",
                            color: Colors.blue,
                            alignment: Alignment.bottomRight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Your name on our system will be updated",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat"),
                  ),
                  Row(children: [
                    const Text("with ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat")),
                    Text(name ?? "",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat")),
                    const Text(" to reflect exactly as",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat")),
                  ]),
                  const Text(" it appears on your BVN",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat")),
                  const SizedBox(
                    height: 30,
                  ),
                  Appbutton(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Success(
                            title: "SUCCESS",
                            subTitle: "BVN validation successful",
                            btnTitle: "Continue",
                          ),
                        ),
                      );
                    },
                    title: "Ok",
                    textColor: Colors.white,
                    backgroundColor: deepKoamaru,
                  )
                ],
              ),
            ));
      });
}
