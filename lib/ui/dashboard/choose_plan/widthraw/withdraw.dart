import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/penal_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/withdrawalReason_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widthraw/withdraw_summary.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_Withdrawal.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  ValueNotifier<bool> showError = ValueNotifier(false);
  var amount = TextEditingController();
  // late TextEditingController balance;
  var balancevalidator = GlobalKey<FormState>();

  final reasonforwithdrawal = TextEditingController();
  late WalletBloc walletBloc;
  late CreatePlanBloc createPlanBloc;
  Plan? plan;
  int? withdrawalReasonId;
  List<WithdrawalReason>? withdrawalReason = [];
  List<Penal>? penal = [];

  String selectReason = "others";
  bool partialwithdraw = false;
  bool fullwithdraw = false;
  var bal = 0;
  var input = 0;
  String? error;
  @override
  void initState() {
    walletBloc = WalletBloc();
    createPlanBloc = CreatePlanBloc();
    createPlanBloc.add(const FetchPenalcharge());
    walletBloc.add(const FetchWithdrawalReason());

    super.initState();
    ;
  }

  late String accbalance = plan!.planSummary!.principal.toString();
  // "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan!.currency!.name).currencySymbol} ${MoneyFormatter(amount: plan!.planSummary!.principal!).output.nonSymbol}";

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;
    plan = map["plan"] as Plan;
    if (plan!.planStatus == "MATURED") {
      amount.text = plan!.planSummary!.principal!.ceil().toString();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Withdrawal"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<WalletBloc, WalletState>(
            bloc: walletBloc,
            listener: (context, state) {
              if (state is WithdrawalReasonSuccess) {
                for (var el
                    in state.withdrawalReasonResponse.withdrawalReason!) {
                  if (el.status == "ACTIVE") {
                    withdrawalReason!.add(el);
                  }
                }
                withdrawalReason!.add(WithdrawalReason(
                    id: 0,
                    status: "active",
                    reason: "Others",
                    createdDate: DateTime.now()));

                setState(() {
                  // withdrawalReason =
                  //     state.withdrawalReasonResponse.withdrawalReason;
                });
              }
            },
          ),
          BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is PenalSuccessful) {
                setState(() {
                  penal = state.penalResponse.penal!;
                });
              }
            },
          )
        ],
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: ListView(
            children: [
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
                                    plan!.planName.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    plan!.productPlan!.productName ?? "",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Text(
                                plan!.planStatus ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: plan!.planStatus == "ACTIVE"
                                        ? jungleGreen
                                        : plan!.planStatus == "MATURED"
                                            ? Colors.blue
                                            : Colors.orange,
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
                                    yMDDate(plan!.planSummary!.startDate!),
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
                                    yMDDate(plan!.planSummary!.endDate!),
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
                          Center(child: Image.asset("assets/images/line.png")),
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
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan!.currency!.name).currencySymbol} ${MoneyFormatter(amount: plan!.planSummary!.principal!).output.nonSymbol}",
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Partial Withdrawal",
                      style: TextStyle(
                          color: plan!.planStatus == "MATURED"
                              ? alto
                              : Colors.black),
                    ),
                    IgnorePointer(
                      ignoring: plan!.planStatus == "MATURED" ? true : false,
                      child: Checkbox(
                        value: partialwithdraw,
                        onChanged: (bool? value) {
                          setState(() {
                            partialwithdraw = value!;
                            // value = true;
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Full Withdrawal",
                      style: TextStyle(
                          color: plan!.planStatus == "ACTIVE"
                              ? alto
                              : Colors.black),
                    ),
                    IgnorePointer(
                      ignoring: plan!.planStatus == "MATURED" ? false : true,
                      child: Checkbox(
                        value: fullwithdraw,
                        onChanged: (bool? value) {
                          setState(() {
                            fullwithdraw = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Amount to liquidate",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: amount,
                  enabled: plan!.planStatus == "ACTIVE" ? true : false,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "₦ 0.00",
                    prefixText: NumberFormat.simpleCurrency(
                            locale: Platform.localeName,
                            name: plan!.currency!.name)
                        .currencySymbol,
                    hintStyle: const TextStyle(
                        color: silverChalic,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).dividerColor, width: 1.0),
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                  ),
                  keyboardType: TextInputType.phone,
                  validator:
                      RequiredValidator(errorText: 'This field is required'),
                  // keyboardType: TextInputType.,
                  onChanged: ((val) {
                    if (val.isNotEmpty) {
                      bal = plan!.planSummary!.principal!.floor() -
                          int.parse(val);

                      if (int.parse(val) >
                              plan!.planSummary!.principal!.floor() &&
                          plan!.planStatus == "MATURED") {
                        setState(() {
                          error =
                              "Amount to withdraw is more than ${plan!.planSummary!.principal!.floor()}";
                          showError.value = true;
                        });
                      } else if (bal <
                              plan!.productPlan!.minTransactionLimit!.floor() &&
                          plan!.planStatus == "ACTIVE") {
                        setState(() {
                          error =
                              "Plan Balance cannot be less than ${plan!.productPlan!.minTransactionLimit!.floor()}";
                          showError.value = true;
                        });
                      } else {
                        setState(() {
                          error = "";
                          showError.value = false;
                        });
                      }
                      input = int.parse(val);
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ValueListenableBuilder(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    "Balance is ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: plan!.currency!.name).currencySymbol} ${plan!.planStatus == "MATURED" ? "0" : MoneyFormatter(amount: double.parse(accbalance)).output.nonSymbol}"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Reason for withdrawal",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppWithdrawal(
                    onChanged: (WithdrawalReason? val) {
                      setState(() {
                        selectReason = val!.reason!;
                        withdrawalReasonId = val.id;
                      });
                    },
                    dropdownValue: "",
                    hintText: "Seslect reason for withdrawal",
                    items: withdrawalReason),
              ),
              const SizedBox(height: 20),
              selectReason == "Others"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AppInputField(
                        controller: reasonforwithdrawal,
                        // enabled: enabledText,

                        hintText: "Please provide reason for withdrawal",
                        // validator:
                        //     RequiredValidator(errorText: 'This is required'),
                        maxLines: 4,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
                child: bal < plan!.productPlan!.minTransactionLimit!.floor() &&
                            plan!.planStatus == "ACTIVE" ||
                        input > plan!.planSummary!.principal!.floor() &&
                            plan!.planStatus == "MATURED"
                    ? Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            color: alto,
                            borderRadius: BorderRadius.circular(30)),
                        child: const IgnorePointer(
                            ignoring: false,
                            child: Center(
                                child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))))
                    : Appbutton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          double penalCharge =
                              conputcharg(plan!.interestReceiptOption!);

                          if (partialwithdraw || fullwithdraw) {
                            if (partialwithdraw) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WithdrawSummary(argument: {
                                            "partialwithdraw":
                                                "partialwithdraw",
                                            "penal": penal,
                                            "user": map["role"],
                                            "balance":
                                                plan!.planSummary!.principal,
                                            "penalCharges":
                                                penalCharge.toStringAsFixed(2),
                                            "startDate": yMDDate(
                                                plan!.planSummary!.startDate!),
                                            "endDate": yMDDate(
                                                plan!.planSummary!.endDate!),
                                            "amountToWithdrawal": amount.text,
                                            "availableBalance":
                                                plan!.planSummary!.principal! -
                                                    (int.parse(amount.text) +
                                                        penalCharge.floor()),
                                            "reason": selectReason,
                                            "planId": plan!.id,
                                            "currency": plan!.currency!.name,
                                            "status": plan!.planStatus,
                                            "planName": plan!.planName,
                                            "withdrawType": partialwithdraw
                                                ? "PARTIAL"
                                                : "FULL"
                                          })));
                            } else {
                              plan!.planSummary!.startDate!
                                  .difference(plan!.planSummary!.endDate!)
                                  .inDays;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WithdrawSummary(argument: {
                                            "fullwithdraw": "fullwithdraw",
                                            "penal": penal,
                                            "user": map["role"],
                                            "balance":
                                                plan!.planSummary!.principal,
                                            "penalCharges":
                                                penalCharge.toStringAsFixed(2),
                                            "startDate": yMDDate(
                                                plan!.planSummary!.startDate!),
                                            "endDate": yMDDate(
                                                plan!.planSummary!.endDate!),
                                            "amountToWithdrawal": plan!
                                                .planSummary!.principal!
                                                .ceil()
                                                .toString(),
                                            "availableBalance": 0.0,
                                            "reason": selectReason,
                                            "status": plan!.planStatus,
                                            "planId": plan!.id,
                                            "currency": plan!.currency!.name,
                                            "planName": plan!.planName,
                                            // "tenorDays": plan!.tenor!.tenorDays,
                                            "withdrawType": partialwithdraw
                                                ? "PARTIAL"
                                                : "FULL"
                                          })));
                            }
                          } else {
                            PopMessage().displayPopup(
                                context: context,
                                text: "Select Withdral type",
                                type: PopupType.failure);
                          }
                        },
                        title: "Next",
                        backgroundColor: deepKoamaru,
                        textColor: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double conputcharg(String options) {
    double maxDays = 0.0;
    double minDays = 0.0;
    double penalCharge = 0;
    double? excessIntPaid;
    double? penalRate;

    var planProductCharges =
        penal!.where((el) => plan!.productPlan!.id == el.product!.id);

    int currentNumberOfDays =
        DateTime.now().difference(plan!.planSummary!.startDate!).inDays;
    int maximumNumberOfDays = plan!.planSummary!.endDate!
        .difference(plan!.planSummary!.startDate!)
        .inDays;
currentNumberOfDays=currentNumberOfDays==0?1:currentNumberOfDays;
    for (var item in planProductCharges) {
      maxDays = ((item.maxDaysElapsed! * maximumNumberOfDays) / 100);

      minDays = ((item.minDaysElapsed! * maximumNumberOfDays) / 100);

      if (currentNumberOfDays >= minDays.floor() &&
          currentNumberOfDays <= maxDays.floor()) {
        penalRate = item.penalRate;
      }
    }

    if (penalRate != null) {
      print(plan!.productPlan!.properties!.penaltyFormula);
      switch (options) {
        case "MATURITY":
          if (plan!.productPlan!.properties!.penaltyFormula ==
              "FIXED_FORMULA") {
            penalCharge = (currentNumberOfDays *
                    (penalRate / 100) *
                    int.parse(amount.text)) /
                365;
          } else if (plan!.productPlan!.properties!.penaltyFormula ==
              "TARGET_FORMULA") {
            double totalEarnedInt = ((plan!.planSummary!.principal! *
                        plan!.interestRate! *
                        currentNumberOfDays) /
                    365) /
                100;
            penalCharge = totalEarnedInt * (penalRate / 100);
          }

          break;
        case "UPFRONT":
          if (plan!.productPlan!.properties!.penaltyFormula ==
              "FIXED_FORMULA") {
            excessIntPaid = int.parse(amount.text) *
                    (plan!.interestRate! / 100) *
                    (maximumNumberOfDays / 365) -
                int.parse(amount.text) *
                    (plan!.interestRate! / 100) *
                    (currentNumberOfDays / 365);
          }
          penalCharge = (currentNumberOfDays / 365) *
                  (penalRate / 100) *
                  int.parse(amount.text) +
              excessIntPaid!;

          break;
        case "MONTHLY":
          if (plan!.productPlan!.properties!.penaltyFormula ==
              "FIXED_FORMULA") {
            penalCharge = (currentNumberOfDays / 365) *
                (penalRate / 100) *
                int.parse(amount.text);
          }
          break;
        case "QUARTERLY":
          if (plan!.productPlan!.properties!.penaltyFormula ==
              "FIXED_FORMULA") {
            penalCharge = (currentNumberOfDays / 365) *
                (penalRate / 100) *
                int.parse(amount.text);
          }
          break;
        case "BI_ANNUAL":
          if (plan!.productPlan!.properties!.penaltyFormula ==
              "FIXED_FORMULA") {
            penalCharge = (currentNumberOfDays / 365) *
                (penalRate / 100) *
                int.parse(amount.text);
          }
          break;

        default:
          penalCharge = 0;
          break;
      }
    } else {
      penalCharge = 0;
    }

    return penalCharge;
  }
}
