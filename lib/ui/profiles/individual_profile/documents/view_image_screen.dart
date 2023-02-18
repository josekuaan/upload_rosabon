import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class ViewImageScreen extends StatefulWidget {
  ViewImageScreen({Key? key}) : super(key: key);

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  final List<String> images = [
    "assets/images/utilitybill.png",
    "assets/images/votercardbackcover.png",
    "assets/images/votercard_front.png"
  ];

  int? indexImage;
  @override
  Widget build(BuildContext context) {
    // var map = ModalRoute.of(context)!.settings.arguments as List<File>;
    var map = ModalRoute.of(context)!.settings.arguments as File;

    //  List<dynamic> indexImage= map;
    int? indexImage;

    return Scaffold(
      backgroundColor: coldGray,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: coldGray,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                // color: Colors.black,
              )),
          leadingWidth: 48.0,
          centerTitle: false,
          titleSpacing: 0,
          // title: const Text("My Bank Details",
          //     textAlign: TextAlign.start,
          //     style: TextStyle(
          //         fontSize: 16,
          //         fontFamily: "Montserrat",
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: coldGray,
              padding: const EdgeInsets.only(bottom: 15, left: 15),
              child: Text(
                  // Text(map[indexImage!].path.split("/").last,
                  indexImage == null
                      ? map.path.split("/").last
                      : map.path.split("/").last,
                  style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: minShaft,
                  image: DecorationImage(
                    image: FileImage(
                      File(map.path),
                      // File(map[indexImage!].path),
                    ),
                  ),
                ),
                // child: Image.asset(indexImage == null
                //     ? map[0].path
                //     : map[indexImage!].path)
              ),
            ),
            // Container(
            //   height: 150,
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: map.length,
            //       itemBuilder: ((context, index) {
            //         return Container(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 30, horizontal: 10),
            //             margin: const EdgeInsets.only(left: 2, right: 2),
            //             color: minShaft,
            //             child: InkWell(
            //               onTap: () {
            //                 setState(() {
            //                   indexImage = index;
            //                 });
            //               },
            //               child: SizedBox(
            //                   height: 200,
            //                   child: Image(
            //                     image: FileImage(
            //                       File(map[index].path),
            //                     ),
            //                   )),
            //             ));
            //       })),
            // ),
          ],
        ),
      ),
    );
  }
}
