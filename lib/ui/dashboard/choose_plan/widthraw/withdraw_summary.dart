import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:sizer/sizer.dart';

class WithdrawSummary extends StatefulWidget {
  final Map argument;
  const WithdrawSummary({Key? key, required this.argument}) : super(key: key);

  @override
  State<WithdrawSummary> createState() => _WithdrawSummaryState();
}

class _WithdrawSummaryState extends State<WithdrawSummary> {
  bool termsandcondition = false;
  bool termsOfAgreement = false;
  bool check = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Withdrawal Summary"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 4.h),
            Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
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
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.argument["planName"].toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                widget.argument["startDate"].toString(),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "End Date",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                widget.argument["endDate"].toString(),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(height: 2.h),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance Before Liquidation",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.argument["currency"]).currencySymbol}"
                                "${widget.argument["balance"]}",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Withdrawal Amount",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.argument["currency"]).currencySymbol}"
                                "${widget.argument["amountToWithdrawal"]}",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Penal Charges",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.argument["currency"]).currencySymbol}"
                                "${widget.argument["penalCharges"]}",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Available Plan Balance",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                " ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.argument["currency"]).currencySymbol}"
                                "${MoneyFormatter(amount: widget.argument["availableBalance"]).output.nonSymbol}",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: deepKoamaru,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reason for Withdrawal",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: deepKoamaru,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            widget.argument["reason"].toString(),
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: deepKoamaru,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                    ]),
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
                  ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  if (!termsOfAgreement) {
                    setState(() {
                      check = !check;
                    });
                    return;
                  }
                  setState(() {
                    check = false;
                    termsOfAgreement = false;
                  });
                  Navigator.pushNamed(context, AppRouter.withdrawaldestination,
                      arguments: widget.argument);
                },
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                      color: deepKoamaru,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
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
            const SizedBox(height: 20),
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
