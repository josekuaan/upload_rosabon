import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/plan_request.dart';
import 'package:rosabon/model/request_model/topup_request.dart';
import 'package:rosabon/model/response_models/virtualacount_response.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:simple_moment/simple_moment.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key, this.planAction, this.planName})
      : super(key: key);
  final String? planAction;
  final String? planName;

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool initLoading = false;
  late BankBloc _bankBloc;
  late CreatePlanBloc _createPlanBloc;
  VirtualAccountResponse? acount;
  @override
  void initState() {
    _bankBloc = BankBloc();
    _createPlanBloc = CreatePlanBloc();
    _bankBloc.add(VirtualAccount(
        action: widget.planAction!.isNotEmpty ? "TOP_UP" : "",
        planName: widget.planName!));

    // _bankBloc.add(const VirtualAccount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Bank details"),
      body: MultiBlocListener(
          listeners: [
            BlocListener<CreatePlanBloc, CreatePlanState>(
              bloc: _createPlanBloc,
              listener: (context, state) {
                print(state);
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
                        subTitle: "Your payment was successful",
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
                if (state is PlanCreatedSuccessful) {
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
                if (state is PaymentError) {
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

                if (state is PlanTransferSuccess) {
                  setState(() {
                    isLoading.value = false;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSuccess(
                        subTitle: "Your payment was successful",
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
              },
            ),
            BlocListener<BankBloc, BankState>(
              bloc: _bankBloc,
              listener: (context, state) {
                if (state is BankLoading) {
                  setState(() {
                    isLoading.value = true;
                  });
                }

                if (state is BankSavedError) {
                  setState(() {
                    isLoading.value = false;
                  });
                  PopMessage().displayPopup(
                      context: context,
                      text: state.error,
                      type: PopupType.failure);
                }
                if (state is FetchBankLoading) {
                  setState(() {
                    initLoading = true;
                  });
                }
                if (state is VirtualAccountSuccess) {
                  setState(() {
                    initLoading = false;
                    acount = state.virtualAccountResponse;
                  });
                }
              },
            )
          ],
          child: initLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Text(acount == null
                          ? ""
                          : "${acount!.accountName}, Kindly make payment into the displayed account details"),
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
                                        acount == null
                                            ? ""
                                            : acount!.accountNumber ??
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
                                      FlutterClipboard.copy(acount == null
                                              ? ""
                                              : "${acount!.accountName} ${acount!.accountNumber}")
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
                                    acount == null
                                        ? ""
                                        : acount!.accountName ?? "missing",
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
                                  const Text(
                                    "Providus",
                                    style: TextStyle(
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
                      ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, bool val, _) {
                            return Appbutton(
                                onTap: () async {
                                  if (map["planAction"] == "TOP_UP") {
                                    _createPlanBloc.add(SavePlan(
                                        topUpRequest: TopUpRequest(
                                      amount: map["amount"],
                                      completed: true,
                                      paymentType: map["paymentType"],
                                      plan: map["planId"],
                                      planToReceive: map["planToReceive"],
                                      planAction: "TOP_UP",
                                    )));
                                  } else {
                                    setState(() {
                                      isLoading.value = true;
                                    });
                                    // double? contributed =
                                    //     map["map"]["contributionValue"] != 0
                                    //         ? double.tryParse(
                                    //             map["map"]["contributionValue"])
                                    //         : 0;

                                    _createPlanBloc.add(CreatePlan(
                                      planRequest: PlanRequest(
                                          product: map["map"]["productId"],
                                          productCategory: map["map"]
                                              ["productCategoryId"],
                                          planName: map["map"]["planName"],
                                          // paymentType: map["map"]["paymentType"],
                                          paymentMethod: map["paymentType"],
                                          allowsLiquidation: map["map"]
                                              ["allowsLiquidation"],
                                          amount: map["map"]["amount"],
                                          targetAmount: map["map"]
                                              ["targetAmount"],
                                          autoRenew: map["map"]["autoRenew"],
                                          contributionValue: map["map"]["contributionValue"] == "0.0"
                                              ? 0.0
                                              : double.parse(map["map"]
                                                  ["contributionValue"]),
                                          currency: map["map"]["currency"],
                                          bankAccountInfo: BankAccountInfo(
                                              accountName: acount!.accountName,
                                              accountNumber:
                                                  acount!.accountNumber,
                                              bankName: "Providus"),
                                          interestReceiptOption: map["map"]
                                              ["interestReceiptOption"],
                                          autoRollover: map["map"]
                                              ["autoRollover"],
                                          exchangeRate: map["map"]["exchangeRate"] == 0
                                              ? null
                                              : map["map"]["exchangeRate"],
                                          directDebit: map["map"]
                                              ["directDebit"],
                                          interestRate: double.parse(map["map"]["calculatedInterestRate"]) == 0
                                              ? 0.0
                                              : double.parse(map["map"]
                                                  ["calculatedInterestRate"]),
                                          numberOfTickets: int.parse(
                                              map["map"]["numberOfTickets"]),
                                          // numberOfTickets: 0,
                                          acceptPeriodicContribution: true,
                                          actualMaturityDate: map["map"]["actualMaturityDate"].isNotEmpty
                                              ? map["map"]["actualMaturityDate"]
                                              : Moment.now().add(days: map["map"]["tenorDay"]).format("yyyy-MM-dd"),

                                          // paymentMaturity: 0,
                                          savingFrequency: map["map"]["savingFrequency"] != null
                                              ? map["map"]["savingFrequency"] == "Daily"
                                                  ? "DAILY"
                                                  : map["map"]["savingFrequency"] == "Weekly"
                                                      ? "WEEKLY"
                                                      : "MONTHLY"
                                              : null,
                                          //when this error happens know john need to make them nullable
                                          monthlyContributionDay: map["map"]["monthlyContributionDay"] ?? 1,
                                          weeklyContributionDay: ["weeklyContributionDay"] != ""
                                              ? map["map"]["weeklyContributionDay"] == "Monday"
                                                  ? "MONDAY"
                                                  : map["map"]["weeklyContributionDay"] == "TuesDay"
                                                      ? "TUESDAY"
                                                      : map["map"]["weeklyContributionDay"] == "Wednesday"
                                                          ? "WEDNESDAY"
                                                          : map["map"]["weeklyContributionDay"] == "Thursday"
                                                              ? "THURSDAY"
                                                              : map["map"]["weeklyContributionDay"] == "Friday"
                                                                  ? "FRIDAY"
                                                                  : map["map"]["weeklyContributionDay"] == "Saturday"
                                                                      ? "SATURDAY"
                                                                      : "SUNDAY"
                                              : null,
                                          tenor: map["map"]["tenorId"],
                                          planStatus: "PENDING",
                                          // tenor: 1,
                                          dateCreated: DateTime.now(),
                                          planDate: DateTime.now(),
                                          planSummary: PlanSummary(
                                            planName: map["map"]["planName"],
                                            startDate: Moment.now()
                                                .format("yyyy-MM-dd"),
                                            endDate: Moment.now()
                                                .add(
                                                    days: map["map"]
                                                        ["tenorDay"])
                                                .format("yyyy-MM-dd"),
                                            principal: map["map"]
                                                    ["targetAmount"] ??
                                                map["map"]["amount"],
                                            // principal: map["map"]["map"]["amount"],

                                            interestRate: double.parse(map[
                                                            "map"][
                                                        "calculatedInterestRate"]) ==
                                                    0
                                                ? 0.0
                                                : double.parse(map["map"]
                                                    ["calculatedInterestRate"]),
                                            // interestPaymentFrequency: "DAILY",

                                            interestReceiptOption: map["map"]
                                                ["interestReceiptOption"],
                                            calculatedInterest: double.parse(
                                                map["map"]
                                                    ["calculatedInterest"]),
                                            withholdingTax: double.parse(
                                                map["map"]["withholding"]),
                                            paymentMaturity: double.parse(
                                                map["map"]["maturityValue"]),
                                          )),
                                    ));
                                  }
                                },
                                buttonState: val
                                    ? AppButtonState.loading
                                    : AppButtonState.idle,
                                title: "Save",
                                backgroundColor: deepKoamaru,
                                textColor: Colors.white);
                          })
                    ],
                  ),
                )),
    );
  }
}
