import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/top_up_card.dart';

class PayWithCard extends StatefulWidget {
  const PayWithCard({Key? key}) : super(key: key);

  @override
  State<PayWithCard> createState() => _PayWithCardState();
}

class _PayWithCardState extends State<PayWithCard> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool debitCard = false;
  bool bankTransfer = false;
  bool termsOfAgreement = false;
  bool check = false;
  late CreatePlanBloc createPlanBloc;
  var publicKey = 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067';
  final plugin = PaystackPlugin();
  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    plugin.initialize(
        publicKey: 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Plan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Choose Payment Type"),
      body: BlocListener<CreatePlanBloc, CreatePlanState>(
          bloc: createPlanBloc,
          listener: (context, state) async {
            if (state is PlanCreating) {
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
                                    // print(map["map"]["principal"]);
                                    TopUpCard(
                                            ctx: context,
                                            paystackPlugin: plugin,
                                            topUpPrice:
                                                map.contributionValue!.toInt() *
                                                    map.exchangeRate!.toInt(),
                                            ref: state.url,
                                            publicKey: publicKey,
                                            data: {"planId": map.id},
                                            action: "PAY_WITH_CARD",
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
          },
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 26),
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
                    // const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: termsOfAgreement,
                              onChanged: (bool? value) {
                                setState(() {
                                  termsOfAgreement = value!;
                                  // check = value;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text(
                                "I agree to the ",
                                style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Montserrat"),
                              ),
                              const Text(
                                " Terms",
                                style: TextStyle(
                                    color: deepKoamaru,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Montserrat"),
                              ),
                              Text(
                                "  and",
                                style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Montserrat"),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  '  Condition',
                                  style: TextStyle(
                                      color: deepKoamaru,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Montserrat"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    !check
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Kindly agree to the terms before you continue",
                              style: TextStyle(
                                color: redOrange,
                                fontFamily: "Montserrat",
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              debitCard
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, bool val, _) {
                            return Appbutton(
                              onTap: () async {
                                if (!termsOfAgreement) {
                                  setState(() {
                                    // check = !check;
                                  });
                                  return;
                                }
                                if (bankTransfer && debitCard) {
                                  return;
                                } else {
                                  setState(() {
                                    // check = false;
                                    // termsOfAgreement = false;
                                  });
                                  var connectivityResult = await (Connectivity()
                                      .checkConnectivity());
                                  if (connectivityResult ==
                                          ConnectivityResult.mobile ||
                                      connectivityResult ==
                                          ConnectivityResult.wifi) {
                                    createPlanBloc.add(PaymentInitialize(
                                      paymentInit: PaymentInit(
                                        amount: map.planSummary!.principal!
                                            .toString(),
                                        purposeOfPayment: "PLAN_CREATION",
                                      ),
                                    ));
                                    //      Navigator.pushNamed(
                                    // context, AppRouter.confirmTransation,
                                    // arguments: {
                                    //     "map": map,
                                    //     "paymentType": "DEBIT_CARD"
                                    //   });
                                    //      Navigator.pushNamed(
                                    //     context, AppRouter.confirmTransation, arguments: {
                                    //   "map": map,
                                    //   "paymentType": "DEBIT_CARD"
                                    // });
                                  } else {
                                    PopMessage().displayPopup(
                                        context: context,
                                        text: "Please check your internet",
                                        type: PopupType.failure);
                                  }
                                }
                              },
                              buttonState: val
                                  ? AppButtonState.loading
                                  : AppButtonState.idle,
                              title: "Pay",
                              backgroundColor: deepKoamaru,
                              textColor: Colors.white,
                            );
                          }))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            color: debitCard ? deepKoamaru : alto,
                            borderRadius: BorderRadius.circular(30)),
                        child: IgnorePointer(
                          ignoring: !debitCard,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (!termsOfAgreement) {
                                  setState(() {
                                    // check = !check;
                                  });
                                  return;
                                }
                                if (bankTransfer && debitCard) {
                                  return;
                                } else {
                                  // setState(() {
                                  //   check = false;
                                  //   termsOfAgreement = false;
                                  // });
                                  // createPlanBloc.add(PaymentInitialize(
                                  //   paymentInit: PaymentInit(
                                  //     amount: map.targetAmount.toString(),
                                  //     purposeOfPayment: "PLAN_CREATION",
                                  //   ),
                                  // ));
                                  // Navigator.pushNamed(
                                  //     context, AppRouter.confirmTransation, arguments: {
                                  //   "map": map,
                                  //   "paymentType": "DEBIT_CARD"
                                  // });
                                }
                              },
                              child: const Text(
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
                    ),
              const SizedBox(height: 40)
            ],
          )),
    );
  }
}
