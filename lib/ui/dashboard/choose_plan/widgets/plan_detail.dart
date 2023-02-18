import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class PlanDetail extends StatefulWidget {
  const PlanDetail({Key? key}) : super(key: key);

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as Plan;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Plan Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
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
                    image: AssetImage("assets/images/large_bg.PNG"))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                map.planName ?? "",
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
                        ),
                        Text(
                          map.planStatus ?? "",
                          style: TextStyle(
                              fontSize: 14,
                              color: map.planStatus == "ACTIVE"
                                  ? jungleGreen
                                  : map.planStatus == "PENDING"
                                      ? Colors.orange
                                      : Colors.blue,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                        ),
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
                              "Start Date",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    Center(child: Image.asset("assets/images/line.png")),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (map.targetAmount != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Target",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol}${MoneyFormatter(amount: map.targetAmount ?? 0.0).output.nonSymbol}",
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        if (map.contributionValue != 0.0)
                          if (map.contributionValue != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  // map.savingFrequency == null
                                  //     ? ''
                                  //     : map.savingFrequency.toString(),

                                  " Contribution Value",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: deepKoamaru,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol} ${MoneyFormatter(amount: map.contributionValue == null ? 0.0 : map.contributionValue!).output.nonSymbol}",
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
                              "Principal",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Tenor",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              map.tenor == null
                                  ? ''
                                  : map.tenor!.tenorName.toString(),
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
                    Center(child: Image.asset("assets/images/line.png")),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Interest Rate",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20), //"20%"
                            Text(
                              map.interestRate.toString(),
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
                              "Interest Earned",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol} ${MoneyFormatter(amount: map.planSummary!.dailyInterestAccrued!).output.nonSymbol}",
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
                            if (map.planSummary!.interestPaymentFrequency !=
                                null)
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
                              map.planSummary!.interestPaymentFrequency ?? "",
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
                              "Current Balance",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol}${MoneyFormatter(amount: map.planSummary!.principal!).output.nonSymbol}",
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
                    Center(child: Image.asset("assets/images/line.png")),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Type",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              map.paymentMethod.toString(),
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Direct Debit Option",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              map.directDebit! ? "Yes" : "No",
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
                        if (map.numberOfTickets != 0)
                          if (map.productPlan!.properties!.allowsMonthlyDraw ==
                              true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Number of Tickets",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: deepKoamaru,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  map.numberOfTickets.toString(),
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
                              "Auto Renewal",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: deepKoamaru,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            FlutterSwitch(
                              width: 60.0,
                              height: 30.0,
                              valueFontSize: 20.0,
                              toggleSize: 30.0,
                              value: map.autoRenew!,
                              borderRadius: 15.0,
                              inactiveColor: alto,
                              padding: 2.0,
                              onToggle: (val) {
                                setState(() {
                                  isSwitched = val;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
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
