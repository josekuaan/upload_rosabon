import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> appPopUp(BuildContext context, String popupText,
    Function? positive, Function? negative) {
  return showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Icon(
                Icons.info,
                color: deepKoamaru,
                size: 50,
              ),
              content: SizedBox(
                height: 200,
                child: Column(
                  children: [
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
                            height: 50,
                            width: 50,
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
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text(
                          popupText,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: SizedBox(
                              width: 130,
                              height: 40,
                              child: Appbutton(
                                  onTap: () {
                                    if (negative != null) {
                                      negative();
                                    }
                                  },
                                  title: "Cancel",
                                  outlineColor: deepKoamaru),
                            )),
                        SizedBox(
                          width: 130,
                          height: 40,
                          child: Appbutton(
                            onTap: () {
                              Navigator.pop(context);
                              if (positive != null) {
                                positive();
                              }
                            },
                            title: "Proceed",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      });
}

Future<dynamic> simplePopup(BuildContext context, String popupText) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Icon(
            Icons.info,
            color: deepKoamaru,
            size: 50,
          ),
          content: SizedBox(
            height: 150,
            child: Column(children: [
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
                    Container(
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
              Text(
                popupText,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat"),
              ),
            ]),
          ));
    },
  );
}

popMessage(BuildContext context, VoidCallback? positive, VoidCallback negative,
    String cancel, String ok, String title, String bodyText) {
  showDialog(
      context: context,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(10), topRight: Radius.circular(20))),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
              insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                  child: Column(
                    children: [
                      Text(
                        bodyText,
                        style: const TextStyle(
                            color: doveGray,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: "SourceSanPro"),
                      ),
                      SizedBox(height: 4.h),
                      Wrap(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: positive,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 1.5.h),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: doveGray),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(cancel,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: doveGray,
                                        fontFamily: "SourceSanPro",
                                        fontSize: 12.sp)),
                              ),
                            ),
                            InkWell(
                              onTap: negative,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 1.5.h),
                                decoration: BoxDecoration(
                                    color: burntSienna,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(ok,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: "SourceSanPro",
                                        fontSize: 12.sp)),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              )),
        );
      });
}
