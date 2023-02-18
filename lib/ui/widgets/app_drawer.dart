import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosabon/bloc/auth/login/login_bloc.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/auth/login_screen.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/dashboard/statement/statement.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class AppDrawer extends StatelessWidget {
  final dynamic map;
  AppDrawer({Key? key, this.map}) : super(key: key);
  final SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: deepKoamaru,
      width: 290,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 20, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Dashboard(page: 1),
                //         settings: RouteSettings(arguments: map)));
              },
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.arrow_back_ios, color: Colors.white)),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: alto,
              radius: 35,
              child: Image.asset("assets/images/user.png"),
            ),
            title: Text(
              _sessionManager.userFullNameVal,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
            subtitle: const Text(
              "view profile",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              if (map == 'INDIVIDUAL_USER') {
                Navigator.pushNamed(context, AppRouter.profile, arguments: map);
              } else {
                Navigator.pushNamed(context, AppRouter.corprateprofile,
                    arguments: map);
              }
            },
          ),
          const SizedBox(height: 20),
          // const Divider(
          //   height: 1,
          //   color: alto,
          // ),
          const SizedBox(height: 15),
          ListTile(
            leading: SvgPicture.asset(
              "assets/images/home.svg",
              color: Colors.white,
            ),
            title: const Text("Home",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard(page: 0)));
            },
          ),
          ListTile(
              leading: SvgPicture.asset(
                "assets/images/wallet.svg",
                color: Colors.white,
              ),
              title: const Text("Wallet",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500)),
              minLeadingWidth: 10,
              minVerticalPadding: 2,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(page: 3)));
              }),
          ListTile(
            leading: SvgPicture.asset(
              "assets/images/plan.svg",
              color: Colors.white,
            ),
            title: const Text("Statement",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Statement(),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              "assets/images/message.svg",
              color: Colors.white,
            ),
            title: const Text("Invite Friends",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRouter.referralLink);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.thumb_up_alt_outlined,
              color: Colors.white,
            ),
            title: const Text("Feedback",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRouter.feedback);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              "assets/images/help.svg",
              color: Colors.white,
            ),
            title: const Text("Help",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRouter.help);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              "assets/images/archive.svg",
              color: Colors.white,
            ),
            title: const Text("Archives",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.archive),
          ),
          const SizedBox(height: 70),
          ListTile(
            leading: SvgPicture.asset("assets/images/logout.svg",
                color: Colors.white),
            title: const Text("Sign out",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () async {
              var res = await _sessionManager.logout();
              if (res) {
                _sessionManager.loggedInVal = false;
                _sessionManager.authTokenVal = "";
                _sessionManager.activePlanVal = 0;
                _sessionManager.totalWorthVal = 0;
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouter.login, (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
