import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/feedBack/feed_back_bloc.dart';
import 'package:rosabon/model/request_model/createTicket_request.dart';
import 'package:rosabon/model/response_models/ticketCategory_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/app_popup.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/ticket_dropdown.dart';
import 'package:sizer/sizer.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  SessionManager sessionManager = SessionManager();
  final form = GlobalKey<FormState>();
  late FeedBackBloc feedBackBloc;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final messageTitle = TextEditingController();
  final messageDec = TextEditingController();
  List<TicketCategory> data = [];
  String? category;
  int? categoryId;
  @override
  void initState() {
    feedBackBloc = FeedBackBloc();
    feedBackBloc.add(const FetchCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(),
        body: BlocListener<FeedBackBloc, FeedBackState>(
            bloc: feedBackBloc,
            listener: (context, state) {
              if (state is CategorySuccess) {
                for (var el in state.ticketCategoryResponse.data!) {
                  if (el.status == "ACTIVE") {
                    data.add(el);
                  }
                }
                setState(() {
                  // data = state.ticketCategoryResponse.data!;
                });
              }
              if (state is CreateticketLoading) {
                setState(() {
                  isLoading.value = true;
                });
              }
              if (state is CreateticketSuccess) {
                setState(() {
                  isLoading.value = false;
                });

                simplePopup(context, "Your feedback has been received");
                messageDec.clear();
                messageTitle.clear();
                category = "";
              }

              if (state is CreatingticketError) {
                PopMessage().displayPopup(context: context, text: state.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: form,
                      child: ListView(
                        children: [
                          Text(
                            "Hello, ${sessionManager.firstNameVal}!",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Select a feedback category to begin with",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontSize: 10.sp,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(height: 1.h),
                          TicketDropDown(
                              onChanged: (TicketCategory? val) {
                                setState(() {
                                  categoryId = val!.id;
                                  category = val.name;
                                });
                              },
                              dropdownValue: category,
                              hintText: "",
                              items: data),
                          SizedBox(height: 2.h),
                          Text(
                            "Title of Message",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontSize: 10.sp,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(height: 1.h),
                          AppInputField(
                            controller: messageTitle,
                            hintText: "Enter your message Title",
                            validator: RequiredValidator(
                                errorText: "Message Title is required "),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Description",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontSize: 10.sp,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(height: 1.h),
                          AppInputField(
                            controller: messageDec,
                            hintText: "Enter your message",
                            maxLines: 4,
                            validator: RequiredValidator(
                                errorText: 'Description is required'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, bool val, _) {
                        return Appbutton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (form.currentState!.validate()) {
                              feedBackBloc.add(
                                CreateTicket(
                                  createTicketrequest: CreateTicketrequest(
                                    platform: 'TREASURY',
                                      categoryId: categoryId,
                                      title: messageTitle.text,
                                      images: null,
                                      content: messageDec.text),
                                ),
                              );
                            }
                          },
                          buttonState: val
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                          title: "Submit",
                          backgroundColor: deepKoamaru,
                          textColor: Colors.white,
                        );
                      }),
                  SizedBox(height: 2.h),
                ],
              ),
            )));
  }
}
