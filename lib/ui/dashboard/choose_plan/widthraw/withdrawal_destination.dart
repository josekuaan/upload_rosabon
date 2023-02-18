import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/withdraw_plan_request.dart';
import 'package:rosabon/model/response_models/accountnumber_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class WithdrawalDestination extends StatefulWidget {
  const WithdrawalDestination({Key? key}) : super(key: key);

  @override
  State<WithdrawalDestination> createState() => _WithdrawalDestinationState();
}

class _WithdrawalDestinationState extends State<WithdrawalDestination> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late BankBloc bankBloc;
  late CreatePlanBloc createPlanBloc;
  String destination = "";
  String? manifestBase64;
  bool loadAccount = false;

  File? manifestUpload;
  String bankName = "";
  String bankCode = "";
  String bankId = "";
  String error = "";
  BankAccountResponse? bankDetail;

  List<Map<String, dynamic>> account = [];
  uploadmanefest() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        manifestUpload = File(pickedFile!.path);
        manifestBase64 = base64Encode(manifestUpload!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        // error = e.toString();
      });
    }
  }

  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    bankBloc = BankBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;
    print(map);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: ""),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BankBloc, BankState>(
            bloc: bankBloc,
            listener: (context, state) {
              print(state);
              if (state is FetchBankLoading) {
                setState(() {
                  loadAccount = true;
                });
              }
              if (state is FetchAccountSuccess) {
                print("jjjjjjjjjjjjjjjjj");
                setState(() {
                  loadAccount = false;
                });
                var data = <String, dynamic>{};

                bankDetail = state.bankAccountResponse;
                // data.addAll({
                //   "number": state.bankAccountResponse.accountNumber,
                //   "id": state.bankAccountResponse.id,
                //   "bankName": state.bankAccountResponse.bank!.name
                // });
                // print(data);
                // setState(() {
                //   account.add(data);
                // });
              }

              if (state is VerifyAccountError) {
                setState(() {
                  loadAccount = false;
                });
                error = state.error;
              }
            },
          ),
          BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is PlanCreating) {
                setState(() {
                  isLoading.value = true;
                });
              }
              if (state is WithdrawPlanSuccess) {
                setState(() {
                  isLoading.value = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccess(
                      subTitle: "Withdrawal requested successfully",
                      btnTitle: "Go Back to Plan",
                      callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(page: 2),
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (state is WithdrawPlanError) {
                setState(() {
                  isLoading.value = false;
                });
                PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure);
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Kindly select beneficiary account to receive the withdrawal",
                      style: TextStyle(
                          fontSize: 14,
                          color: mineShaft,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Amount for withdrawal is ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map["currency"]).currencySymbol}"
                      "${map["amountToWithdrawal"]}",
                      style: const TextStyle(
                          fontSize: 11,
                          color: mineShaft,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  AppDropDown(
                    dropdownValue: "",
                    hintText: "",
                    onChanged: (dynamic val) {
                      setState(() {
                        destination = val!;
                      });
                      bankBloc.add(const FetchBankAccount());
                    },
                    items: const <dynamic>[
                      {"name": "To Bank"},
                      {"name": "To Wallet"}
                    ],
                  ),
                  const SizedBox(height: 50),
                  destination == "To Bank" && map["user"] == "INDIVIDUAL_USER"
                      ? loadAccount
                          ? const Center(child: CircularProgressIndicator())
                          : error.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: concreteLight,
                                            offset: Offset(2, 2.0),
                                            blurRadius: 24.0)
                                      ]),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      error,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.red,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: concreteLight,
                                            offset: Offset(2, 2.0),
                                            blurRadius: 24.0)
                                      ]),
                                  height: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Account Number",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mineShaft,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            bankDetail!.accountNumber ?? "",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Account Name",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mineShaft,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            bankDetail!.accountName ?? "",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Bank Name",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mineShaft,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            bankDetail!.bank!.name ?? "",
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                      : destination == "To Bank" && map["user"] == "COMPANY"
                          ? DottedBorder(
                              padding: const EdgeInsets.all(20),
                              borderType: BorderType.Rect,
                              radius: const Radius.circular(20),
                              color: gray,
                              strokeWidth: 0.3,
                              dashPattern: const [10, 5, 10, 5, 10, 5],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 35.w,
                                        child: Text(
                                          manifestUpload != null
                                              ? manifestUpload!.path
                                                  .split("/")
                                                  .last
                                              : "Upload withdrawal mandate instruction",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        "jpg, PDF. 2MB",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 8.sp,
                                          color: gray,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: uploadmanefest,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: alto,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "Choose File",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 10.sp,
                                            color: gray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                  )
                                ],
                              ), //optional
                            )
                          : Container(),
                  const SizedBox(height: 70),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, bool val, _) {
                            return Appbutton(
                                onTap: () {
                                  createPlanBloc.add(WithdrawPlan(
                                      withdrawPlanRequest: WithdrawPlanRequest(
                                          amount: int.parse(
                                              map["amountToWithdrawal"]),
                                          plan: map["planId"],
                                          planAction: "WITHDRAW",
                                          // status: map["status"],
                                          withdrawTo: destination == "To Bank"
                                              ? "TO_BANK"
                                              : "TO_WALLET",
                                          completed: true,
                                          penalCharge:
                                              double.parse(map["penalCharges"]),
                                          withdrawType: map["withdrawType"])));
                                },
                                buttonState: val
                                    ? AppButtonState.loading
                                    : AppButtonState.idle,
                                backgroundColor: deepKoamaru,
                                textColor: Colors.white,
                                title: "Submit");
                          }),
                      const SizedBox(height: 20),
                      Appbutton(
                        onTap: (() => Navigator.pop(context)),
                        title: "Cancel",
                        outlineColor: deepKoamaru,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
