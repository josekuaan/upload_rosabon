import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rosabon/bloc/auth/notification/notification_bloc.dart';
import 'package:rosabon/model/response_models/notification_response.dart';
import 'package:rosabon/repository/auth_repository.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class AppNotification extends StatefulWidget {
  const AppNotification({Key? key}) : super(key: key);

  @override
  State<AppNotification> createState() => _AppNotificationState();
}

class _AppNotificationState extends State<AppNotification> {
  late NotificationBloc notificationBloc;
  List<Note> note = [];
  List<Note> read = [];
  List<Note> unRead = [];
  @override
  initState() {
    notificationBloc = NotificationBloc();
    notificationBloc.add(const FetchNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: "Notifications"),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          bloc: notificationBloc,
          listener: (context, state) {
            if (state is NotificationSuccess) {
              note = state.notificationResponse.note!;

              for (var el in note) {
                if (el.readStatus == "READ") {
                  read.add(el);
                } else {
                  print(el.toJson());
                  unRead.add(el);
                }
              }
            }
          },
          builder: ((context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NotificationSuccess) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 20),
                    child: unRead.isEmpty
                        ? Container()
                        : const Text("New",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Column(
                                  children: [
                                    Text(
                                      unRead[index].title == "UNREAD"
                                          ? 'Unread'
                                          : 'Read',
                                      style: TextStyle(
                                        color: unRead[index].title == "UNREAD"
                                            ? deepKoamaru
                                            : Colors.black,
                                      ),
                                    ),
                                    const CircleAvatar(
                                        radius: 20, backgroundColor: alto),
                                  ],
                                ),
                                subtitle: Text(
                                  unRead[index].message ?? "",
                                  style: TextStyle(
                                    color: unRead[index].title == "UNREAD"
                                        ? deepKoamaru
                                        : Colors.black,
                                  ),
                                ),
                                trailing: Column(
                                  children: [
                                    Text(
                                      DateFormat("dd-MM-yyyy")
                                          .format(unRead[index].dateSent!)
                                          .toString(),
                                      style: TextStyle(
                                        color: unRead[index].title == "UNREAD"
                                            ? deepKoamaru
                                            : Colors.black,
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    unRead[index].title == "UNREAD"
                                        // unRead[index].readStatus == "UNREAD"
                                        ? const CircleAvatar(
                                            radius: 4,
                                            backgroundColor: deepKoamaru,
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                                enableFeedback: true,
                                onTap: () {
                                  AuthRepository()
                                      .markAsRead(unRead[index].id!);
                                  Navigator.pushNamed(
                                      context, AppRouter.notificationdetail,
                                      arguments: unRead[index]);
                                  setState(() {
                                    unRead[index].title = "READ";
                                  });
                                });
                          },
                          separatorBuilder: (context, index) {
                            return Column(
                              children: const [
                                SizedBox(height: 10),
                                Divider(height: 4, color: alto),
                                SizedBox(height: 10)
                              ],
                            );
                          },
                          itemCount: unRead.length)),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 20, top: 20),
                    child: read.isEmpty
                        ? Container()
                        : const Text("Earlier",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: const CircleAvatar(
                                    radius: 20, backgroundColor: alto),
                                subtitle: Text(
                                  read[index].message ?? "",
                                  style: TextStyle(
                                    color: unRead[index].title == "UNREAD"
                                        ? deepKoamaru
                                        : Colors.black,
                                  ),
                                ),
                                trailing: Column(
                                  children: [
                                    Text(
                                        DateFormat("dd-MM-yyyy")
                                            .format(read[index].dateSent!)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 10),
                                    read[index].readStatus == "READ"
                                        ? const CircleAvatar(
                                            radius: 4,
                                            backgroundColor: deepKoamaru,
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                                enableFeedback: true,
                                onTap: () {
                                  // AuthRepository().markAsRead();
                                  Navigator.pushNamed(
                                      context, AppRouter.notificationdetail,
                                      arguments: read[index]);
                                });
                          },
                          separatorBuilder: (context, index) {
                            return Column(
                              children: const [
                                SizedBox(height: 10),
                                Divider(height: 4, color: alto),
                                SizedBox(height: 10)
                              ],
                            );
                          },
                          itemCount: read.length)),
                ],
              );
            } else {
              if (state is NotificationLoading) {
                return const Center(child: Text("Error"));
              }
              return const Center(child: Text(""));
            }
          }),
        ));
  }
}
