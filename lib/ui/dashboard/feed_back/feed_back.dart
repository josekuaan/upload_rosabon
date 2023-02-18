import 'package:flutter/material.dart';
import 'package:rosabon/ui/dashboard/feed_back/close_ticket.dart';
import 'package:rosabon/ui/dashboard/feed_back/feed.dart';
import 'package:rosabon/ui/dashboard/feed_back/open_ticket.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Feed())),
              child: Text(
                "Create Tickets",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: mineShaft,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          const Divider(height: 1, color: alto),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OpenTicketScreen())),
              child: Text(
                "My Open Tickets",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: mineShaft,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          const Divider(height: 1, color: alto),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClosedTicket())),
              child: Text(
                "My Closed Tickets",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: mineShaft,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          const Divider(height: 1, color: alto),
        ],
      ),
    );
  }
}
