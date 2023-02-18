import 'package:flutter/material.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(),
                    settings:
                        RouteSettings(arguments: _sessionManager.userRoleVal))),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
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
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              _sessionManager.userRoleVal,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {},
          ),
          const Divider(height: 1, color: alto),
          const SizedBox(height: 15),
          ListTile(
            leading: Image.asset("assets/images/user.png"),
            title: const Text("Personal Information",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.personalinfo),
          ),
          ListTile(
            leading: Image.asset("assets/images/docs.png"),
            title: const Text("My Documents",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.mydocument),
          ),
          ListTile(
            leading: Image.asset("assets/images/card.png"),
            title: const Text("My Bank Details",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.mybankDetail),
          ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: alto),
          const SizedBox(height: 15),
          ListTile(
            leading: Image.asset("assets/images/user.png"),
            title: const Text("Change Password",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.changepassword),
          ),
          ListTile(
            leading: Image.asset("assets/images/link.png"),
            title: const Text("My Referral Link",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
            minLeadingWidth: 10,
            minVerticalPadding: 2,
            onTap: () => Navigator.pushNamed(context, AppRouter.referralLink),
          ),
        ],
      ),
    );
  }
}
