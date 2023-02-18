import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/response_models/virtualacount_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:simple_moment/simple_moment.dart';

class ViewAcountDetails extends StatefulWidget {
  const ViewAcountDetails({Key? key, this.planId}) : super(key: key);

  final int? planId;

  @override
  State<ViewAcountDetails> createState() => _ViewAcountDetailsState();
}

class _ViewAcountDetailsState extends State<ViewAcountDetails> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool initLoading = false;
  late BankBloc _bankBloc;
  late CreatePlanBloc createPlanBloc;
  VirtualAccountResponse? acount;
  @override
  void initState() {
    _bankBloc = BankBloc();
    createPlanBloc = CreatePlanBloc();
    _bankBloc.add(ViewBankDetail(id: widget.planId!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: "Bank details"),
        body: BlocConsumer<BankBloc, BankState>(
            bloc: _bankBloc,
            listener: (context, state) {
              print(state);
            },
            builder: ((context, state) {
              if (state is FetchBankLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is VirtualAccountSuccess) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(children: [
                      const SizedBox(height: 20),
                      Text(acount == null
                          ? ""
                          : "${state.virtualAccountResponse.accountName}, Kindly make payment into the displayed account details"),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: alto,
                                    offset: Offset.fromDirection(2.0),
                                    blurRadius: 24.0)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Account Number",
                                        style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        state.virtualAccountResponse
                                                .accountNumber ??
                                            "missing",
                                        style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FlutterClipboard.copy(
                                              "${state.virtualAccountResponse.accountName} ${state.virtualAccountResponse.accountNumber}")
                                          .then((value) =>
                                              Fluttertoast.showToast(
                                                  msg: "Copied!",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: deepKoamaru,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0));
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Name",
                                    style: TextStyle(
                                      color: Theme.of(context).dividerColor,
                                      fontFamily: "Montserrat",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    state.virtualAccountResponse.accountName ??
                                        "missing",
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Name",
                                    style: TextStyle(
                                      color: Theme.of(context).dividerColor,
                                      fontFamily: "Montserrat",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    state.virtualAccountResponse.bankName
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                        child: Text(
                          "Account details expires in 48 hours, kindly endeavour to make transfer before ${Moment.now().add(days: 2).format("dd-MM-yyyy")}",
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                    ]));
              } else if (state is VerifyAccountError) {
                return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 18),
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: alto,
                              offset: Offset.fromDirection(2.0),
                              blurRadius: 24.0)
                        ]),
                    child: Text(
                      state.error,
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ));
              }
              return const Center(child: Text("retry"));
            })));
  }
}
