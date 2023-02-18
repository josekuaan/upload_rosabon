import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/rollover_request.dart';
import 'package:rosabon/model/request_model/rollover_request.dart'
    as planSumary;
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/partial_payment_info.dart';

import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/app_popup.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class RolloverSummary extends StatefulWidget {
  const RolloverSummary({Key? key}) : super(key: key);

  @override
  State<RolloverSummary> createState() => _RolloverSummaryState();
}

class _RolloverSummaryState extends State<RolloverSummary> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late CreatePlanBloc _createPlanBloc;
  bool termsOfAgreement = false;
  bool check = false;

  @override
  void initState() {
    _createPlanBloc = CreatePlanBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;
    Plan plan = map["plan"];
    print(plan.planSummary!.paymentMaturity);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Rollover Summary"),
      body: BlocListener(
          bloc: _createPlanBloc,
          listener: (context, state) {
            if (state is PlanCreating) {
              isLoading.value = true;
            }

            if (state is PlanSuccessful) {
              isLoading.value = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentSuccess(
                    subTitle: "Rollover was successful",
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

            if (state is PlanError) {
              isLoading.value = false;
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: ListView(
              children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                plan.planName ?? "",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
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
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    yMDDate(plan.planSummary!.startDate!),
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
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    yMDDate(plan.planSummary!.endDate!),
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
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Principal",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan.currency != null ? plan.currency!.name : "NGN").currencySymbol} ${MoneyFormatter(amount: plan.planSummary!.principal!).output.nonSymbol}",
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
                                    "Amount for Withdrawal",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "1,000,000",
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
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Interest Rate",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${plan.planSummary!.calculatedInterest}",
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
                                    "Interest Payment \n Frequency",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    plan.interestReceiptOption ?? "",
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
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Calculated Interest",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan.currency != null ? plan.currency!.name : "NGN").currencySymbol} ${MoneyFormatter(amount: plan.planSummary!.calculatedInterest!).output.nonSymbol}",
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
                                    "Withholding Tax",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan.currency != null ? plan.currency!.name : "NGN").currencySymbol} ${MoneyFormatter(amount: plan.planSummary!.withholdingTax!).output.nonSymbol}",
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
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment at Maturity",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan.currency != null ? plan.currency!.name : "NGN").currencySymbol} ${MoneyFormatter(amount: plan.planSummary!.paymentMaturity!).output.nonSymbol}",
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
                          SizedBox(height: 3.h),
                        ]),
                  ),
                ),
                SizedBox(height: 1.h),
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
                      ),
                SizedBox(height: 10.h),
                map["rollover"] == "fullrollover"
                    ? ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Appbutton(
                            onTap: () {
                              appPopUp(
                                context,
                                "Your plan is about to be rolled over, kindly confirm action",
                                () {
                                  // isLoading.value = true;
                                  _createPlanBloc.add(RolloverPlan(
                                      rolloverResquest: RolloverResquest(
                                          // balanceAfterRollover: null,
                                          // bankAccountDetails: ,
                                          completed: true,
                                          // corporateUserWithdrawalMandate:
                                          //     manifestBase64,
                                          plan: plan.id,
                                          amount: int.parse(map["amount"]),
                                          planAction: "ROLLOVER",
                                          withdrawTo: "TO_WALLET",
                                          bankAccountDetails: null,
                                          rollToPlan: RollToPlan(
                                              acceptPeriodicContribution: true,
                                              actualMaturityDate:
                                                  plan.actualMaturityDate,
                                              allowsLiquidation:
                                                  plan.allowsLiquidation,
                                              amount: plan.amountToBePlaced,
                                              autoRenew: plan.autoRenew,
                                              autoRollOver: false,
                                              bankAccountInfo: null,
                                              contributionValue:
                                                  plan.contributionValue,
                                              currency: plan.currency!.id,
                                              dateCreated: plan.createdDate,
                                              directDebit: plan.directDebit,
                                              exchangeRate: plan.exchangeRate,
                                              interestRate: plan.interestRate,
                                              interestReceiptOption:
                                                  plan.interestReceiptOption,
                                              monthlyContributionDay:
                                                  plan.monthlyContributionDay,
                                              numberOfTickets:
                                                  plan.numberOfTickets,
                                              // paymentMethod: plan.paymentMethod,
                                              paymentMethod: "DEBIT_CARD",
                                              planDate: plan.planDate,
                                              planStatus: "ACTIVE",
                                              planName: plan.planName,
                                              product: plan.productPlan!.id,
                                              productCategory:
                                                  plan.productCategory!.id,
                                              tenor: map["tenorId"],
                                              savingFrequency:
                                                  plan.savingFrequency,
                                              targetAmount: plan.targetAmount,
                                              weeklyContributionDay:
                                                  plan.weeklyContributionDay,
                                              planSummary:
                                                  planSumary.PlanSummary(
                                                calculatedInterest: plan
                                                    .planSummary!
                                                    .calculatedInterest,
                                                startDate: DateTime.now(),
                                                endDate:
                                                    plan.planSummary!.endDate,
                                                interestReceiptOption:
                                                    plan.interestReceiptOption,
                                                interestRate: plan
                                                    .planSummary!.interestRate,
                                                planName: plan.planName,
                                                principal:
                                                    plan.planSummary!.principal,
                                                withholdingTax: plan
                                                    .planSummary!
                                                    .withholdingTax,
                                                paymentMaturity: plan
                                                    .planSummary!
                                                    .paymentMaturity,
                                                interestPaymentFrequency: plan
                                                    .planSummary!
                                                    .interestPaymentFrequency,
                                              )))));
                                },
                                () => Navigator.pop(context),
                              );
                            },
                            buttonState: val
                                ? AppButtonState.loading
                                : AppButtonState.idle,
                            title: "Procceed",
                            backgroundColor: deepKoamaru,
                            textColor: Colors.white,
                          );
                        })
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
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
                            if (map["rollover"] == "partialrollover") {
                              if (map["user"] == "COMPANY" ||
                                  map["user"] == "INDIVIDUAL_USER") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PartialPaymentInfo(
                                        role: map["user"],
                                        plan: plan,
                                        tenorId: map["tenorId"],
                                        amount: map["amount"]),
                                  ),
                                );
                              }

                              return;
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
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
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Appbutton(
                      onTap: (() => Navigator.pop(context)),
                      title: "Cancel",
                      outlineColor: deepKoamaru,
                    )),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
