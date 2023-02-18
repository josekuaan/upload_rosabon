import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/plan_request.dart';
import 'package:rosabon/model/request_model/topup_request.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:uuid/uuid.dart';

class CardPayment {
  CardPayment({
    this.ctx,
    required this.paystackPlugin,
    this.planBloc,
    this.ref,
    this.data,
    this.publicKey,
    this.currentPlanId,
    this.action,
    this.price,
  });

  BuildContext? ctx;
  PaystackPlugin paystackPlugin;
  String? ref;
  String? action;
  Map<String, dynamic>? data;
  int? currentPlanId;
  String? publicKey;

  CreatePlanBloc? planBloc;

  final String _cardNumber = "";
  final String _cvv = "";
  String platform = "";
  final int _expiryMonth = 0;
  final int _expiryYear = 0;
  double? price = 0;

  var uuid = const Uuid();

  String _getReference() {
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return ref!;
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  Future chargeCardAndMakePayment() async {
    Charge charge = Charge()
      ..amount = price!.ceil() * 100
      ..email = SessionManager().userEmailVal
      ..reference = ref
      ..card = _getCardFromUI()
      ..putCustomField('Charged From', 'Flutter SDK');

    CheckoutResponse response = await paystackPlugin.checkout(ctx!,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: Image.asset(
          "assets/images/logo.png",
          height: 80,
          width: 80,
        ));

    if (response.status) {
      var res = await ProductRepository().verifyPayment("PAYSTACK", ref!);

      if (res.baseStatus) {
        if (action == "CREATE_PLAN") {
          double? contributed = data!["map"]["contributionValue"] != 0
              ? double.parse(data!["map"]["contributionValue"])
              : 0;

          planBloc!.add(
            UpdatePlan(
                planRequest: PlanRequest(
                  product: data!["map"]["productId"],
                  productCategory: data!["map"]["productCategoryId"],
                  planName: data!["map"]["planName"],
                  // paymentType: map["map"]["paymentType"],
                  paymentMethod: data!["paymentType"],
                  allowsLiquidation: data!["map"]["allowsLiquidation"],
                  amount: data!["map"]["amount"],
                  targetAmount: data!["map"]["targetAmount"],
                  autoRenew: data!["map"]["autoRenew"],
                  contributionValue: contributed,
                  currency: data!["map"]["currency"],
                  interestReceiptOption: data!["map"]["interestReceiptOption"],
                  autoRollover: data!["map"]["autoRollover"],
                  exchangeRate: data!["map"]["exchangeRate"] == 0
                      ? null
                      : data!["map"]["exchangeRate"],
                  directDebit: data!["map"]["directDebit"],
                  interestRate: double.parse(
                              data!["map"]["calculatedInterestRate"]) ==
                          0.0
                      ? 0.0
                      : double.parse(data!["map"]["calculatedInterestRate"]),
                  numberOfTickets: int.parse(data!["map"]["numberOfTickets"]),
                  // numberOfTickets: 0,
                  acceptPeriodicContribution: true,
                  actualMaturityDate:
                      data!["map"]["actualMaturityDate"].isNotEmpty
                          ? data!["map"]["actualMaturityDate"]
                          : Moment.now()
                              .add(days: data!["map"]["tenorDay"])
                              .format("yyyy-MM-dd"),
                  // paymentMaturity: 0,
                  savingFrequency: data!["map"]["savingFrequency"] != null
                      ? data!["map"]["savingFrequency"] == "Daily"
                          ? "DAILY"
                          : data!["map"]["savingFrequency"] == "Weekly"
                              ? "WEEKLY"
                              : "MONTHLY"
                      : null,
                  //when this error happens know john need to make them nullable

                  monthlyContributionDay:
                      data!["map"]["monthlyContributionDay"] ?? 1,
                  weeklyContributionDay: data!["map"]
                              ["weeklyContributionDay"] !=
                          ""
                      ? data!["map"]["weeklyContributionDay"] == "Monday"
                          ? "MONDAY"
                          : data!["map"]["weeklyContributionDay"] == "TuesDay"
                              ? "TUESDAY"
                              : data!["map"]["weeklyContributionDay"] ==
                                      "Wednesday"
                                  ? "WEDNESDAY"
                                  : data!["map"]["weeklyContributionDay"] ==
                                          "Thursday"
                                      ? "THURSDAY"
                                      : data!["map"]["weeklyContributionDay"] ==
                                              "Thursday"
                                          ? "FRIDAY"
                                          : data!["map"][
                                                      "weeklyContributionDay"] ==
                                                  "Saturday"
                                              ? "SATURDAY"
                                              : "MONTHLY"
                      : null,
                  tenor: data!["map"]["tenorId"],
                  planStatus: "ACTIVE",
                  // tenor: 1,
                  dateCreated: DateTime.now(),
                  planDate: DateTime.now(),
                  planSummary: PlanSummary(
                    planName: data!["map"]["planName"],
                    startDate: Moment.now().format("yyyy-MM-dd"),
                    endDate: Moment.now()
                        .add(days: data!["map"]["tenorDay"])
                        .format("yyyy-MM-dd"),
                    principal: data!["map"]["principal"],
                    // principal: map["map"]["map"]["amount"],
                    interestRate: double.parse(
                                data!["map"]["calculatedInterestRate"]) ==
                            0
                        ? 0.0
                        : double.parse(data!["map"]["calculatedInterestRate"]),
                    // interestPaymentFrequency: "DAILY",

                    interestReceiptOption: data!["map"]
                        ["interestReceiptOption"],
                    calculatedInterest:
                        double.parse(data!["map"]["calculatedInterest"]),

                    withholdingTax: double.parse(data!["map"]["withholding"]),
                    paymentMaturity:
                        double.parse(data!["map"]["maturityValue"]),
                  ),
                ),
                id: currentPlanId!),
          );
        }
      }
    }
  }
}
