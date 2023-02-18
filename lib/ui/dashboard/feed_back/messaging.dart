import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/feedBack/feed_back_bloc.dart';
import 'package:rosabon/model/request_model/replychat_request.dart';
import 'package:rosabon/model/response_models/ticketchat_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class Messaging extends StatefulWidget {
  final int? id;
  final String? title;
  const Messaging({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final reply = TextEditingController();
  late FeedBackBloc feedBackBloc;
  List<String> user = [];
  List<Reply> response = [];
  @override
  void initState() {
    feedBackBloc = FeedBackBloc();
    feedBackBloc.add(TicketReply(id: widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: BlocConsumer<FeedBackBloc, FeedBackState>(
        bloc: feedBackBloc,
        listener: (context, state) {
          if (state is ChatTicketSuccess) {
            response = state.ticketChatResponse.reply!;
            user = [];
            for (var i = 0; i < state.ticketChatResponse.reply!.length; i++) {
              if (state.ticketChatResponse.reply![i].replyType ==
                  "USER_REPLY") {
                // var data = <String, dynamic>{};
                user.add(state.ticketChatResponse.reply![i].content!);

                // user.add(data);
              }
            }
            // print(user);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatTicketSuccess) {
            // for (var i = 0;
            //     i < state.ticketChatResponse.reply!.length - 1;
            //     i++) {
            //   if (state.ticketChatResponse.reply![i].replyType ==
            //       "USER_REPLY") {
            //     // var data = <String, dynamic>{};
            //     user.add(state.ticketChatResponse.reply![i].content!);

            //     // user.add(data);
            //   }
            // }
            return Stack(
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text("Close Ticket",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Title",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: mineShaft,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600)),
                          Text("Status",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: mineShaft,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.title.toString(),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: mineShaft,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                            child: Text("Open",
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          return response[index].replyType == "USER_REPLY"
                              ? UserChat(msg: user[index])
                              : AdminChat(msg: user[index]);
                        }),
                    const SizedBox(height: 30)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          width: 70.w,
                          child: TextFormField(
                            controller: reply,
                            onChanged: (String val) {},
                            // maxLines: 5,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Type your message",
                              hintStyle: const TextStyle(
                                  color: silverChalic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).dividerColor,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(30)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            if (reply.text.isNotEmpty) {
                              feedBackBloc.add(ChatReply(
                                  replyCahtrequest: ReplyCahtrequest(
                                      images: [],
                                      content: reply.text,
                                      ticketId: widget.id,
                                      title: widget.title)));

                              setState(() {
                                user.add(reply.text);
                                response.add(Reply(replyType: "USER_REPLY"));
                                reply.text = "";
                              });
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            color: deepKoamaru,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.error.toString()));
          }
          return const Center(child: Text("Retry"));
        },
      ),
    );
  }
}

class UserChat extends StatelessWidget {
  String? msg;
  UserChat({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    // print(user);
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text("You",
              style: TextStyle(
                  fontSize: 10.sp,
                  color: mineShaft,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: mystic,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Text(msg.toString(),
              style: TextStyle(
                  fontSize: 9.sp,
                  color: mineShaft,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400)),
        ),
      ],
    ));
  }
}

class AdminChat extends StatelessWidget {
  String? msg;
  AdminChat({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text("Admin",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: mineShaft,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: mystic,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: SizedBox(
              // width: 220,
              child: Text(msg.toString(),
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: mineShaft,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
