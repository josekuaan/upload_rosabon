import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/documents_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/saved_document.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:shimmer/shimmer.dart';

class CorprateProfileScreen extends StatefulWidget {
  const CorprateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CorprateProfileScreen> createState() => _CorprateProfileScreenState();
}

class _CorprateProfileScreenState extends State<CorprateProfileScreen> {
  final SessionManager _sessionManager = SessionManager();

  UserBloc userBloc = UserBloc();

  UserResponse? userResponse;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
      } else {
        PopMessage().displayPopup(
            context: context,
            text: "Please check your internet",
            type: PopupType.failure);
      }
    });

    super.initState();
  }

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
                    settings: RouteSettings(arguments: _sessionManager))),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: userBloc,
        listener: (context, state) {
          if (state is FetchUserSuccess) {
            userResponse = state.userResponse;
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Shimmer.fromColors(
                  highlightColor: gray.withOpacity(0.2),
                  baseColor: gray.withOpacity(0.2),
                  enabled: true,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 48.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount: 4,
                  )),
            );
          }
          return ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: alto,
                  radius: 35,
                  child: Image.asset("assets/images/user.png"),
                ),
                title: Text(
                  _sessionManager.userFullNameVal.toString(),
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
              ),
              const Divider(height: 1),
              const SizedBox(height: 15),
              ListTile(
                leading: Image.asset("assets/images/user.png"),
                title: const Text("Company Information",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500)),
                minLeadingWidth: 10,
                minVerticalPadding: 2,
                onTap: () =>
                    Navigator.pushNamed(context, AppRouter.corprateinfo),
              ),
              ListTile(
                leading: Image.asset("assets/images/docs.png"),
                title: const Text("More Details",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500)),
                minLeadingWidth: 10,
                minVerticalPadding: 2,
                onTap: () => Navigator.pushNamed(context, AppRouter.director),
              ),
              ListTile(
                leading: Image.asset("assets/images/card.png"),
                title: const Text("Company Documents",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500)),
                minLeadingWidth: 10,
                minVerticalPadding: 2,
                onTap: () {
                  if (SessionManager().companyNameVal
                          // userResponse!.company!.companyType
                          ==
                          'PARTNERSHIP' ||
                      SessionManager().companyNameVal ==
                          'SOLE PROPREITORSHIP' ||
                      SessionManager().companyNameVal == "CORPORATE LIMITED") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CompanyDocumentScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SavedCompanyDocument()));
                  }
                },
              ),
              const SizedBox(height: 15),
              const Divider(height: 1),
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
                onTap: () =>
                    Navigator.pushNamed(context, AppRouter.changepassword),
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
                onTap: () => Navigator.pushNamed(
                    context, AppRouter.corpratereferralLink),
              ),
            ],
          );
        },
      ),
    );
  }
}
