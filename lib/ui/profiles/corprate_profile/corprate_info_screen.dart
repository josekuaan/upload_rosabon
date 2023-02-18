import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:shimmer/shimmer.dart';

class CorprateInformationScreen extends StatefulWidget {
  const CorprateInformationScreen({Key? key}) : super(key: key);

  @override
  State<CorprateInformationScreen> createState() =>
      _CorprateInformationScreenState();
}

class _CorprateInformationScreenState extends State<CorprateInformationScreen> {
  final SessionManager _sessionManager = SessionManager();
  UserBloc userBloc = UserBloc();
  UserResponse? userResponse;

  @override
  void initState() {
    userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: deepKoamaru,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, AppRouter.corprateprofile,
                    arguments: map),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            leadingWidth: 48.0,
            centerTitle: false,
            titleSpacing: 0,
            title: const Text("Company Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
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
                            height: 48.0,
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
          if (state is FetchUserSuccess) {
            return ListView(children: [
              const SizedBox(height: 15),
              ListTile(
                  leading: Image.asset("assets/images/user.png"),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 15, color: Colors.black),
                  title: const Text("Company Details",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500)),
                  minLeadingWidth: 10,
                  minVerticalPadding: 2,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.corprateinfodetail,
                        arguments: userResponse);
                  }),
              ListTile(
                leading: Image.asset("assets/images/contact_person.png"),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 15, color: Colors.black),
                title: const Text("Contact Person Details",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500)),
                minLeadingWidth: 10,
                minVerticalPadding: 2,
                onTap: () => Navigator.pushNamed(
                    context, AppRouter.corpratecontactdetail,
                    arguments: userResponse),
              ),
              const Divider(height: 1.0),
              const SizedBox(height: 15),
            ]);
          } else if (state is UserError) {
            return Center(child: Text(state.error));
          }
          return const Text("");
        },
      ),
    );
  }
}
