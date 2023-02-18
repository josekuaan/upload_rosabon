import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/bank_details.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/top_up_card.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  SessionManager sessionManager = SessionManager();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late CreatePlanBloc createPlanBloc;
  final form = GlobalKey<FormState>();
  final paystack = PaystackPlugin();
  final topupAmount = TextEditingController();
  ValueNotifier<bool> showError = ValueNotifier(false);
  String itemSelected = "";
  bool isSwitched = false;
  bool debitCard = false;
  bool bankTransfer = false;
  String? error;
  var publicKey = 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067';

  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    paystack.initialize(
        publicKey: 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as Plan;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Top Up"),
      body: BlocListener<CreatePlanBloc, CreatePlanState>(
          bloc: createPlanBloc,
          listener: (context, state) {
            if (state is InitiatingPayment) {
              setState(() {
                isLoading.value = true;
              });
            }
            if (state is PaymentSuccessful) {
              setState(() {
                isLoading.value = false;
              });
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
                                    TopUpCard(
                                            ctx: context,
                                            paystackPlugin: paystack,
                                            topUpPrice:
                                                int.parse(topupAmount.text),
                                            ref: state.url,
                                            publicKey: publicKey,
                                            action: "TOP_UP",
                                            data: {
                                              "amount":
                                                  int.parse(topupAmount.text),
                                              "completed": true,
                                              "paymentType": "DEBIT_CARD",
                                              "plan": map.id,
                                              "planToReceive": map.id,
                                              "planAction": "TOP_UP",
                                            },
                                            planBloc: createPlanBloc)
                                        .chargeCardAndMakePayment();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    decoration: BoxDecoration(
                                        color: deepKoamaru,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Center(
                                      child: Text(
                                        "Pay with Paystack",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontFamily: "Montserrat"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            }
            if (state is PlanSuccessful) {
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
            if (state is PlanTransferError) {
              setState(() {
                isLoading.value = false;
              });
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
            if (state is PaymentError) {
              setState(() {
                isLoading.value = false;
              });
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
          },
          child: Form(
            key: form,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xfff8f9fb),
                          offset: Offset.fromDirection(2.0),
                          blurRadius: 24.0)
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/medium_bg.PNG"))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      map.planName.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      map.planName ?? "",
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Text(
                                  map.planStatus ?? "",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: jungleGreen,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                                    const SizedBox(height: 5),
                                    Text(
                                      yMDDate(map.planSummary!.startDate!),
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
                                    const SizedBox(height: 5),
                                    Text(
                                      yMDDate(map.planSummary!.endDate!),
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
                            const SizedBox(height: 10),
                            Center(
                                child: Image.asset("assets/images/line.png")),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Balance",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: deepKoamaru,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol} ${MoneyFormatter(amount: map.planSummary!.principal!).output.nonSymbol}",
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: deepKoamaru,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Amount to be Placed",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppInputField(
                    controller: topupAmount,
                    // enabled: enabledText,
                    textInputType: TextInputType.phone,
                    hintText: "₦ 0.00",
                    validator: RequiredValidator(
                        errorText: 'Amount to be placed is required'),
                    onChange: (val) {
                      // if (val != "") {
                      //   if (int.parse(val) <
                      //       map.productPlan!.minTransactionLimit!.floor()) {
                      //     setState(() {
                      //       error =
                      //           "Minimum amount connot be below ${map.productPlan!.minTransactionLimit!.floor()}";
                      //       showError.value = true;
                      //     });
                      //   } else if (int.parse(val) >
                      //       map.productPlan!.maxTransactionLimit!.floor()) {
                      //     setState(() {
                      //       error =
                      //           "Maximum amount connot be above ${map.productPlan!.maxTransactionLimit!.floor()}";
                      //       showError.value = true;
                      //     });
                      //   } else {
                      //     setState(() {
                      //       error = "";
                      //       showError.value = false;
                      //     });
                      //   }
                      // }
                    },
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: showError,
                    builder: (context, bool val, _) {
                      return Visibility(
                        visible: val,
                        child: Text(
                          error ?? "",
                          style: const TextStyle(
                              color: redOrange,
                              fontFamily: "Montserrat",
                              fontSize: 10),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/mastercard_logo.png"),
                          const SizedBox(width: 10),
                          const Text("Debit card")
                        ],
                      ),
                      Checkbox(
                        value: debitCard,
                        onChanged: (bool? value) {
                          setState(() {
                            debitCard = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: alto),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/bank.png"),
                          const SizedBox(width: 10),
                          const Text("Bank Transfer")
                        ],
                      ),
                      Checkbox(
                        value: bankTransfer,
                        onChanged: (bool? value) {
                          setState(() {
                            bankTransfer = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                debitCard
                    ? ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 24),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: bankTransfer || debitCard
                                      ? deepKoamaru
                                      : alto,
                                  borderRadius: BorderRadius.circular(30)),
                              child: IgnorePointer(
                                ignoring: !bankTransfer && !debitCard,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      if (form.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        createPlanBloc.add(
                                          PaymentInitialize(
                                            paymentInit: PaymentInit(
                                              amount: topupAmount.text,
                                              purposeOfPayment: "PLAN_CREATION",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: val == true
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              // valueColor:
                                              //     AlwaysStoppedAnimation<Color>(),
                                              // backgroundColor: silverChalice,
                                            ),
                                          )
                                        : const Text(
                                            "Pay",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 24),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                              color: bankTransfer || debitCard
                                  ? deepKoamaru
                                  : alto,
                              borderRadius: BorderRadius.circular(30)),
                          child: IgnorePointer(
                            ignoring: !bankTransfer && !debitCard,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if (form.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BankDetails(
                                              planAction: "TOP_UP",
                                              planName: map.planName),
                                          settings: RouteSettings(arguments: {
                                            "amount":
                                                int.parse(topupAmount.text),
                                            "paymentType": "BANK_TRANSFER",
                                            "planId": map.id,
                                            "planToReceive": map.id,
                                            "planAction": "TOP_UP",
                                          })),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }
}
