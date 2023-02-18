import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosabon/model/response_models/notification_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: ""),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              Text(
                DateFormat("dd-MM-yyyy").format(map.dateSent!).toString(),
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: alto, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  map.message ?? "",
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ));
  }
}
