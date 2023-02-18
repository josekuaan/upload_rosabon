import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/rollover_request.dart';
import 'package:rosabon/model/request_model/rollover_request.dart'
    as plan_summary;
import 'package:rosabon/model/response_models/accountnumber_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class PartialPaymentInfo extends StatefulWidget {
  final String role;
  final Plan plan;
  final int tenorId;
  final String amount;
  const PartialPaymentInfo(
      {Key? key,
      required this.role,
      required this.plan,
      required this.tenorId,
      required this.amount})
      : super(key: key);

  @override
  State<PartialPaymentInfo> createState() => _PartialPaymentInfoState();
}

class _PartialPaymentInfoState extends State<PartialPaymentInfo> {
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
    var map = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: const AppBarWidget(title: ""),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is PlanCreating) {
                setState(() {
                  isLoading.value = true;
                });
              }
              if (state is PaymentSuccessful) {
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentSuccess(
                //       subTitle: "Your payment was successful",
                //       btnTitle: "Check my Investment",
                //       subBtnTitle: "Invest more",
                //       callback: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Dashboard(page: 2),
                //         ),
                //       ),
                //     ),
                //   ),
                // );
              }
              if (state is PlanSuccessful) {
                setState(() {
                  isLoading.value = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccess(
                      subTitle: "Plan Successfully Saved",
                      btnTitle: "Check my Investment",
                      subBtnTitle: "Invest more",
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
              if (state is PlanError) {
                setState(() {
                  isLoading.value = false;
                });
                PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure);
              }

              if (state is PlanError) {
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
                setState(() {
                  loadAccount = false;
                });
                var data = <String, dynamic>{};

                bankDetail = state.bankAccountResponse;
                data.addAll({
                  "number": state.bankAccountResponse.accountNumber,
                  "id": state.bankAccountResponse.id,
                  "bankName": state.bankAccountResponse.bank!.name
                });
                setState(() {
                  account.add(data);
                });
              }

              if (state is VerifyAccountError) {
                setState(() {
                  loadAccount = false;
                });
                error = state.error;
              }
            },
          )
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
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
                        "Amount for withdrawal is ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.plan.currency!.name).currencySymbol}"
                        "${double.parse(widget.amount)}",
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
                        // bankBloc.add(VirtualAccount(
                        //     planName: widget.plan.planName!,
                        //     action: "ROLLOVER"));
                      },
                      items: const <dynamic>[
                        {"name": "To Bank"},
                        {"name": "To Wallet"}
                      ],
                    ),
                    const SizedBox(height: 50),
                    destination == "To Bank" && widget.role == "INDIVIDUAL_USER"
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
                        : destination == "To Bank" && widget.role == "COMPANY"
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
              ),
              Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, bool val, _) {
                        return Appbutton(
                            onTap: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                createPlanBloc.add(RolloverPlan(
                                    rolloverResquest: RolloverResquest(
                                        // balanceAfterRollover: null,
                                        // bankAccountDetails: ,
                                        completed: true,
                                        corporateUserWithdrawalMandate:
                                            manifestBase64,
                                        plan: widget.plan.id,
                                        amount: int.parse(widget.amount),
                                        planAction: "ROLLOVER",
                                        withdrawTo: destination == "To Wallet"
                                            ? "TO_WALLET"
                                            : "TO_BANK",
                                        bankAccountDetails: bankDetail!.id,
                                        rollToPlan: RollToPlan(
                                            acceptPeriodicContribution: true,
                                            actualMaturityDate:
                                                widget.plan.actualMaturityDate,
                                            allowsLiquidation:
                                                widget.plan.allowsLiquidation,
                                            amount:
                                                widget.plan.amountToBePlaced,
                                            autoRenew: widget.plan.autoRenew,
                                            autoRollOver: false,
                                            bankAccountInfo: null,
                                            //  BankAccountInfo(
                                            //   accountName:
                                            //       bankDetail!.accountName,
                                            //   accountNumber:
                                            //       bankDetail!.accountNumber,
                                            //   // bankName:""
                                            // ),
                                            contributionValue:
                                                widget.plan.contributionValue,
                                            currency: widget.plan.currency!.id,
                                            dateCreated:
                                                widget.plan.createdDate,
                                            directDebit:
                                                widget.plan.directDebit,
                                            exchangeRate:
                                                widget.plan.exchangeRate,
                                            interestRate:
                                                widget.plan.interestRate,
                                            interestReceiptOption: widget
                                                .plan.interestReceiptOption,
                                            monthlyContributionDay: widget
                                                .plan.monthlyContributionDay,
                                            numberOfTickets:
                                                widget.plan.numberOfTickets,
                                            paymentMethod: null,
                                            // widget.plan.paymentMethod,
                                            planDate: widget.plan.planDate,
                                            planStatus: "ACTIVE",
                                            planName: widget.plan.planName,
                                            product:
                                                widget.plan.productPlan!.id,
                                            productCategory:
                                                widget.plan.productCategory!.id,
                                            tenor: widget.tenorId,
                                            savingFrequency:
                                                widget.plan.savingFrequency,
                                            targetAmount:
                                                widget.plan.targetAmount,
                                            weeklyContributionDay: widget
                                                .plan.weeklyContributionDay,
                                            planSummary:
                                                plan_summary.PlanSummary(
                                              calculatedInterest: widget
                                                  .plan
                                                  .planSummary!
                                                  .calculatedInterest,
                                              startDate: widget
                                                  .plan.planSummary!.startDate,
                                              endDate: widget
                                                  .plan.planSummary!.endDate,
                                              interestReceiptOption: widget
                                                  .plan.interestReceiptOption,
                                              interestRate: widget.plan
                                                  .planSummary!.interestRate,
                                              planName: widget.plan.planName,
                                              principal: widget
                                                  .plan.planSummary!.principal,
                                              withholdingTax: widget.plan
                                                  .planSummary!.withholdingTax,
                                              paymentMaturity: widget.plan
                                                  .planSummary!.paymentMaturity,
                                              interestPaymentFrequency: widget
                                                  .plan
                                                  .planSummary!
                                                  .interestPaymentFrequency,
                                            )))));
                              } else {
                                PopMessage().displayPopup(
                                    context: context,
                                    text: "Please check your internet",
                                    type: PopupType.failure);
                              }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ListView(
          // children: [
          //   Text(
          //     "Bank Name",
          //     style: TextStyle(
          //         color: Theme.of(context).dividerColor,
          //         fontFamily: "Montserrat"),
          //   ),
          //   const SizedBox(height: 8),
          //   AppInputField(
          //     controller: bankName,
          //     hintText: "",
          //     validator: RequiredValidator(errorText: 'Bank name is required'),
          //   ),
          //   const SizedBox(height: 20),
          //   Text(
          //     "Account Number",
          //     style: TextStyle(
          //         color: Theme.of(context).dividerColor,
          //         fontFamily: "Montserrat"),
          //   ),
          //   const SizedBox(height: 8),
          //   AppInputField(
          //     controller: acctnumber,
          //     hintText: "",
          //     validator:
          //         RequiredValidator(errorText: 'Account number is required'),
          //   ),
          //   const SizedBox(height: 20),
          //   Text(
          //     "Account Name",
          //     style: TextStyle(
          //         color: Theme.of(context).dividerColor,
          //         fontFamily: "Montserrat"),
          //   ),
          //   const SizedBox(height: 8),
          //   AppInputField(
          //     controller: acctName,
          //     hintText: "",
          //     validator:
          //         RequiredValidator(errorText: 'Account name is required'),
          //   ),
          //   const SizedBox(height: 8),
          //   const Text("Amount for withdrawal is ₦ 1,500,000"),
          //   const SizedBox(height: 150),
          //   InkWell(
          //     onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => PaymentSuccess(
          //           subTitle: "Rollover was successful",
          //           btnTitle: "Go Back to Plan",
          //           callback: () => Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => Dashboard(page: 2),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     child: Container(
          //       height: 50,
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          //       decoration: BoxDecoration(
          //           color: deepKoamaru,
          //           borderRadius: BorderRadius.circular(30)),
          //       child: const Center(
          //         child: Text(
          //           "Submit",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontFamily: "Montserrat",
          //             fontSize: 15,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   const SizedBox(height: 20),
          //   Appbutton(onTap: (() => Navigator.pop(context)), title: "Cancel"),
