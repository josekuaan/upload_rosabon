import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/request_model/plan_request.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/bank_details.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/card_payment.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:simple_moment/simple_moment.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class ConfirmTransaction extends StatefulWidget {
  const ConfirmTransaction({Key? key}) : super(key: key);

  @override
  State<ConfirmTransaction> createState() => _ConfirmTransactionState();
}

class _ConfirmTransactionState extends State<ConfirmTransaction> {
  SessionManager sessionManager = SessionManager();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> popuploading = ValueNotifier(false);
  late CreatePlanBloc createPlanBloc;
  var publicKey = 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067';
  final plugin = PaystackPlugin();
  int? currentPlanId;

  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();

    plugin.initialize(
        publicKey: 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: const AppBarWidget(
          title: "Kindly confirm your transaction \n details  below"),
      body: BlocListener<CreatePlanBloc, CreatePlanState>(
        bloc: createPlanBloc,
        listener: (context, state) async {
          print(state);
          if (state is PlanCreating) {
            setState(() {
              isLoading.value = true;
            });
          }

          if (state is PaymentSuccessful) {
            CardPayment(
                    ctx: context,
                    paystackPlugin: plugin,
                    price: map["map"]["contributionValue"] != "0.0"
                        ? double.parse(map["map"]["contributionValue"]) *
                            map["map"]["exchangeRate"]
                        : map["map"]["amount"].toDouble(),
                    ref: state.url,
                    publicKey: publicKey,
                    data: map,
                    currentPlanId: currentPlanId,
                    action: "CREATE_PLAN",
                    planBloc: createPlanBloc)
                .chargeCardAndMakePayment();
          }
          if (state is PlanCreating) {
            setState(() {
              isLoading.value = true;
            });
          }
          if (state is PaymentError) {
            setState(() {
              isLoading.value = false;
            });
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
          if (state is PlanError) {
            setState(() {
              isLoading.value = false;
            });
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
          if (state is PlanCreatedSuccessful) {
            // isLoading.value = false;
            currentPlanId = state.createPlanResponse.plans!.id;
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                      // insetPadding:
                      //     const EdgeInsets.symmetric(horizontal: 20),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: const Icon(
                        Icons.info,
                        color: deepKoamaru,
                        size: 50,
                      ),
                      content: SizedBox(
                        height: 120,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // top: 70,
                                    right: 20,
                                    child: Image.asset(
                                      "assets/images/box.png",
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.black,
                                  ),
                                  Positioned(
                                    top: 25,
                                    left: 20,
                                    child: Image.asset(
                                      "assets/images/polygon3.png",
                                      color: Colors.blue,
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    isLoading.value = true;
                                  });
                                  createPlanBloc.add(PaymentInitialize(
                                    paymentInit: PaymentInit(
                                      amount: map["map"]["amount"] == 0
                                          ? map["map"]["targetAmount"]
                                              .toString()
                                          : map["map"]["amount"].toString(),
                                      purposeOfPayment: "PLAN_CREATION",
                                    ),
                                  ));
                                },
                                child: Container(
                                  height: 50,
                                  width: 240,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  decoration: BoxDecoration(
                                      color: deepKoamaru,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      "Continue with Paystack",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ),
                                ),
                              ),

                              //  InkWell(
                              //   onTap: () {

                              //   },
                              //   child: Container(
                              //     height: 50,
                              //     width: 200,
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 10, horizontal: 30),
                              //     decoration: BoxDecoration(
                              //         color: deepKoamaru,
                              //         borderRadius: BorderRadius.circular(30)),
                              //     child: const Center(
                              //       child: Text(
                              //         "Continue with payment",
                              //         style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w500,
                              //             color: Colors.white,
                              //             fontFamily: "Montserrat"),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ));
                });
          }
          if (state is PlanUpdateSuccessful) {
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
        child: ListView(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xfff8f9fb),
                        offset: Offset.fromDirection(2.0),
                        blurRadius: 30.0)
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Payment Type :",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500)),
                      map["paymentType"] == "DEBIT_CARD"
                          ? Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    "assets/images/mastercard_logo.png"),
                                const SizedBox(width: 10),
                                const Text("Debit card",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500))
                              ],
                            )
                          : Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("assets/images/bank.png"),
                                const SizedBox(width: 10),
                                const Text("Bank Transfer",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xfff8f9fb),
                        offset: Offset.fromDirection(2.0),
                        blurRadius: 24.0)
                  ],
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/bg.PNG"))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "${map["map"] == "" ? "" : map["map"]["planName"]}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Start Date",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    DateFormat.yMd().format(DateTime.now()),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "End Date",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    Moment.now()
                                        .add(days: map["map"]["tenorDay"])
                                        .format("dd-MM-yyyy"),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Center(child: Image.asset("assets/images/line.png")),
                          const SizedBox(height: 23),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Principal",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map["map"]["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: map["map"]["principal"].toDouble()).output.nonSymbol}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Interest Rate",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    map["map"]["interestRate"].toString(),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Interest Payment Frequency",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    map["map"]["interestReceiptOption"]
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Calculated Interest",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map["map"]["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(map["map"]["calculatedInterest"])).output.nonSymbol}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 23),
                          Center(child: Image.asset("assets/images/line.png")),
                          const SizedBox(height: 23),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Withholding tax",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map["map"]["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(map["map"]["withholding"])).output.nonSymbol}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Payment at Maturity",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: deepKoamaru,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300)),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map["map"]["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(map["map"]["maturityValue"])).output.nonSymbol}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                        onTap: () async {
                          if (map["paymentType"] == "BANK_TRANSFER") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BankDetails(
                                      planAction: "",
                                      planName: map["map"]["planName"]),
                                  settings: RouteSettings(arguments: map)),
                            );
                          } else {
                            setState(() {
                              isLoading.value = true;
                            });
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              double? contributed =
                                  map["map"]["contributionValue"] != 0
                                      ? double.parse(
                                          map["map"]["contributionValue"])
                                      : 0;
                              createPlanBloc.add(
                                CreatePlan(
                                  planRequest: PlanRequest(
                                    product: map["map"]["productId"],
                                    nameOfDirectDebitCard: map["map"]["cardId"],
                                    productCategory: map["map"]
                                        ["productCategoryId"],

                                    planName: map["map"]["planName"],
                                    // paymentType: map["map"]["paymentType"],
                                    paymentMethod: map["paymentType"],
                                    allowsLiquidation: map["map"]
                                        ["allowsLiquidation"],
                                    amount: map["map"]["amount"],
                                    targetAmount: map["map"]["targetAmount"],
                                    autoRenew: map["map"]["autoRenew"],
                                    contributionValue: contributed,
                                    currency: map["map"]["currency"],
                                    interestReceiptOption: map["map"]
                                        ["interestReceiptOption"],
                                    autoRollover: map["map"]["autoRollover"],
                                    exchangeRate:
                                        map["map"]["exchangeRate"] == 0
                                            ? null
                                            : map["map"]["exchangeRate"],
                                    directDebit: map["map"]["directDebit"],
                                    interestRate: double.parse(map["map"]
                                                ["calculatedInterestRate"]) ==
                                            0.0
                                        ? 0.0
                                        : double.parse(map["map"]
                                            ["calculatedInterestRate"]),
                                    numberOfTickets: int.parse(
                                        map["map"]["numberOfTickets"]),
                                    // numberOfTickets: 0,
                                    acceptPeriodicContribution: true,
                                    actualMaturityDate: map["map"]
                                                ["actualMaturityDate"]
                                            .isNotEmpty
                                        ? map["map"]["actualMaturityDate"]
                                        : Moment.now()
                                            .add(days: map["map"]["tenorDay"])
                                            .format("yyyy-MM-dd"),
                                    // paymentMaturity: 0,
                                    savingFrequency: map["map"]
                                                ["savingFrequency"] !=
                                            null
                                        ? map["map"]["savingFrequency"] ==
                                                "Daily"
                                            ? "DAILY"
                                            : map["map"]["savingFrequency"] ==
                                                    "Weekly"
                                                ? "WEEKLY"
                                                : "MONTHLY"
                                        : null,
                                    //when this error happens know john need to make them nullable

                                    monthlyContributionDay: map["map"]
                                            ["monthlyContributionDay"] ??
                                        1,
                                    weeklyContributionDay: map["map"]
                                                ["weeklyContributionDay"] !=
                                            ""
                                        ? map["map"]["weeklyContributionDay"] ==
                                                "Monday"
                                            ? "MONDAY"
                                            : map["map"][
                                                        "weeklyContributionDay"] ==
                                                    "TuesDay"
                                                ? "TUESDAY"
                                                : map["map"][
                                                            "weeklyContributionDay"] ==
                                                        "Wednesday"
                                                    ? "WEDNESDAY"
                                                    : map["map"][
                                                                "weeklyContributionDay"] ==
                                                            "Thursday"
                                                        ? "THURSDAY"
                                                        : map["map"][
                                                                    "weeklyContributionDay"] ==
                                                                "Thursday"
                                                            ? "FRIDAY"
                                                            : map["map"][
                                                                        "weeklyContributionDay"] ==
                                                                    "Saturday"
                                                                ? "SATURDAY"
                                                                : "MONTHLY"
                                        : null,
                                    tenor: map["map"]["tenorId"],
                                    planStatus: "PENDING",
                                    // tenor: 1,
                                    dateCreated: DateTime.now(),
                                    planDate: DateTime.now(),
                                    planSummary: PlanSummary(
                                      planName: map["map"]["planName"],
                                      startDate:
                                          Moment.now().format("yyyy-MM-dd"),
                                      endDate: Moment.now()
                                          .add(days: map["map"]["tenorDay"])
                                          .format("yyyy-MM-dd"),
                                      principal: map["map"]["principal"],
                                      // principal: map["map"]["map"]["amount"],
                                      interestRate: double.parse(map["map"]
                                                  ["calculatedInterestRate"]) ==
                                              0
                                          ? 0.0
                                          : double.parse(map["map"]
                                              ["calculatedInterestRate"]),
                                      // interestPaymentFrequency: "DAILY",

                                      interestReceiptOption: map["map"]
                                          ["interestReceiptOption"],
                                      calculatedInterest: double.parse(
                                          map["map"]["calculatedInterest"]),

                                      withholdingTax: double.parse(
                                          map["map"]["withholding"]),
                                      paymentMaturity: double.parse(
                                          map["map"]["maturityValue"]),
                                    ),
                                  ),
                                ),
                              );
                              // createPlanBloc.add(PaymentInitialize(
                              //   paymentInit: PaymentInit(
                              //     amount: map["map"]["amount"] == 0
                              //         ? map["map"]["targetAmount"].toString()
                              //         : map["map"]["amount"].toString(),
                              //     purposeOfPayment: "PLAN_CREATION",
                              //   ),
                              // ));
                            } else {
                              PopMessage().displayPopup(
                                  context: context,
                                  text: "Please check your internet",
                                  type: PopupType.failure);
                            }
                          }
                        },
                        buttonState:
                            val ? AppButtonState.loading : AppButtonState.idle,
                        title: "Proceed",
                        backgroundColor: deepKoamaru,
                        textColor: Colors.white,
                      );
                    })

                // InkWell(
                //   onTap:
                //   child: Container(
                //     height: 50,
                //     padding:
                //         const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                //     decoration: BoxDecoration(
                //         color: deepKoamaru,
                //         borderRadius: BorderRadius.circular(30)),
                //     child: const Center(
                //       child: Text(
                //         "Pay",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontFamily: "Montserrat",
                //           fontSize: 15,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                // ),
                // ),
                // ),
                ),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Appbutton(
                  onTap: (() => Navigator.pop(context)),
                  title: "Cancel",
                  outlineColor: deepKoamaru,
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
