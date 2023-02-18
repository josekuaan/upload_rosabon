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

class TopUpCard {
  TopUpCard(
      {this.ctx,
      required this.paystackPlugin,
      this.planBloc,
      this.ref,
      this.data,
      this.publicKey,
      this.currentPlanId,
      this.action,
      this.topUpPrice});

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

  int? topUpPrice = 0;
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
      ..amount = topUpPrice! * 100
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
        if (action == "PAY_WITH_CARD") {
          planBloc!.add(AnyPlanAction(
              topUpRequest: TopUpRequest(
            amount: 0,
            completed: true,
            paymentType: "CARD",
            plan: data!["planId"],
            planToReceive: data!["planId"],
            planAction: "PAY_WITH_CARD",
          )));
        } else {
          planBloc!.add(AnyPlanAction(
              topUpRequest: TopUpRequest(
            amount: data!["amount"],
            completed: true,
            paymentType: data!["paymentType"],
            plan: data!["plan"],
            planToReceive: data!["planToReceive"],
            planAction: "TOP_UP",
          )));
        }
      }
    }
  }
}
