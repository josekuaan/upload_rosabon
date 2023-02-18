import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({Key? key}) : super(key: key);

  @override
  State<PaymentPlan> createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  bool debitCard = false;
  bool bankTransfer = false;
  bool termsOfAgreement = false;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Choose Payment Type"),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            bankTransfer = false;
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
                          Text(
                            "Bank Transfer",
                            style: TextStyle(
                                color:
                                    map["directDebit"] ? alto : Colors.black),
                          )
                        ],
                      ),
                      IgnorePointer(
                        ignoring: map["directDebit"],
                        child: Checkbox(
                          value: bankTransfer,
                          onChanged: (bool? value) {
                            setState(() {
                              bankTransfer = value!;
                              debitCard = false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: alto),
                // const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: BoxDecoration(
                  color: bankTransfer || debitCard ? deepKoamaru : alto,
                  borderRadius: BorderRadius.circular(30)),
              child: IgnorePointer(
                ignoring: !bankTransfer && !debitCard,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (!termsOfAgreement) {
                        setState(() {
                          check = !check;
                        });
                        return;
                      }
                      if (bankTransfer && debitCard) {
                        return;
                      } else {
                        setState(() {
                          check = false;
                          termsOfAgreement = false;
                        });
                        bankTransfer
                            ? Navigator.pushNamed(
                                context, AppRouter.confirmTransation,
                                arguments: {
                                    "map": map,
                                    "paymentType": "BANK_TRANSFER"
                                  })
                            : Navigator.pushNamed(
                                context, AppRouter.confirmTransation,
                                arguments: {
                                    "map": map,
                                    "paymentType": "DEBIT_CARD"
                                  });
                      }
                    },
                    child: const Text(
                      "Proceed",
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
      ),
    );
  }
}
