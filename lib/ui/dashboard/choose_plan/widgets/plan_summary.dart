import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:simple_moment/simple_moment.dart';

class PlanSummary extends StatefulWidget {
  final Map arguments;
  const PlanSummary({Key? key, required this.arguments}) : super(key: key);

  @override
  State<PlanSummary> createState() => _PlanSummaryState();
}

class _PlanSummaryState extends State<PlanSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Plan summary"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ListView(
          children: [
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
                            "${widget.arguments["planName"]}",
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
                                    Moment.now().format("dd-MM-yyyy"),
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
                                        .add(days: widget.arguments["tenorDay"])
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
                                    " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.arguments["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: widget.arguments["principal"].toDouble()).output.nonSymbol}",
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
                                    "${double.parse(widget.arguments["calculatedInterestRate"])}%",
                                    // "${double.parse(widget.arguments["calculatedInterestRate"]).floor()}%",
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
                                    widget.arguments["interestReceiptOption"]
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
                                    " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.arguments["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(widget.arguments["calculatedInterest"])).output.nonSymbol}",
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
                                    " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.arguments["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(widget.arguments["withholding"])).output.nonSymbol}",
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
                                    " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.arguments["currency_symbol"]).currencySymbol} ${MoneyFormatter(amount: double.parse(widget.arguments["maturityValue"])).output.nonSymbol}",
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
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: deepKoamaru,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.paymentplan,
                          arguments: widget.arguments);
                    },
                    child: const Text(
                      "Next",
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
          ],
        ),
      ),
    );
  }
}
