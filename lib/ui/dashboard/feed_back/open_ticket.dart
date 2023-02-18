import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/feedBack/feed_back_bloc.dart';
import 'package:rosabon/ui/dashboard/feed_back/messaging.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class OpenTicketScreen extends StatefulWidget {
  const OpenTicketScreen({Key? key}) : super(key: key);

  @override
  State<OpenTicketScreen> createState() => _OpenTicketScreenState();
}

class _OpenTicketScreenState extends State<OpenTicketScreen> {
  late FeedBackBloc feedBackBloc;
  @override
  void initState() {
    feedBackBloc = FeedBackBloc();
    feedBackBloc.add(const OpenTicket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "My Open Tickets"),
      body: BlocConsumer<FeedBackBloc, FeedBackState>(
          bloc: feedBackBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OpenTicketSuccess) {
              if (state.ticketResponse.ticket!.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.ticketResponse.ticket!.length,
                  itemBuilder: ((context, index) {
                    // String name = state
                    //             .ticketResponse.ticket![index].individualUser !=
                    //         null
                    //     ? "${state.ticketResponse.ticket![index].individualUser!.firstName} ${state.ticketResponse.ticket![index].individualUser!.lastName}"
                    //     : "${state.ticketResponse.ticket![index].company!.contactFirstName} ${state.ticketResponse.ticket![index].company!.contactLastName}";
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2.h),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Messaging(
                                        title: state.ticketResponse
                                            .ticket![index].title!,
                                        id: state.ticketResponse.ticket![index]
                                            .id))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.ticketResponse.ticket![index]
                                              .title!
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: mineShaft,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text(
                                            //     // "${state.ticketResponse.ticket![index].individualUser != null ? state.ticketResponse.ticket![index].individualUser!.firstName : state.ticketResponse.ticket![index].company!.contactFirstName} ${state.ticketResponse.ticket![index].individualUser != null ? state.ticketResponse.ticket![index].individualUser!.lastName : state.ticketResponse.ticket![index].company!.contactLastName}",
                                            //     style: TextStyle(
                                            //         fontSize: 10.sp,
                                            //         color: mineShaft,
                                            //         fontFamily: "Montserrat",
                                            //         fontWeight:
                                            //             FontWeight.w400)),
                                            const CircleAvatar(
                                                radius: 2,
                                                backgroundColor: deepKoamaru),
                                            Text(
                                                "${state.ticketResponse.ticket![index].createdAt}",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: mineShaft,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "#${state.ticketResponse.ticket![index].id}",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: alto,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w400)),
                                          const CircleAvatar(
                                              radius: 2,
                                              backgroundColor: deepKoamaru),
                                          const Icon(
                                              Icons.support_agent_outlined,
                                              size: 15),
                                          // Text(name,
                                          //     style: TextStyle(
                                          //         fontSize: 10.sp,
                                          //         fontFamily: "Montserrat",
                                          //         fontWeight: FontWeight.w400)),
                                          const CircleAvatar(
                                              radius: 2,
                                              backgroundColor: deepKoamaru),
                                          Text(
                                              state.ticketResponse
                                                  .ticket![index].status!
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: alto,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        const Divider(height: 1, color: alto)
                      ],
                    );
                  }),
                );
              } else {
                return Center(
                    child: Image.asset("assets/images/empty_state_card.png"));
              }
            }
            if (state is ChatError) {
              return Column(
                children: [
                  Text(state.error),
                  IconButton(
                      onPressed: () => feedBackBloc.add(const OpenTicket()),
                      icon: const Icon(Icons.refresh, size: 24))
                ],
              );
            }

            return const Center(child: Text("retry"));
            // if (state) {
            //   return Center(child: Text("No Open Ticke yet"));
            // }
          }),
    );
  }
}
