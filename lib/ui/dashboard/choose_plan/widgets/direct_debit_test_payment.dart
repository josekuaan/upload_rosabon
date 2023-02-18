import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:uuid/uuid.dart';

class DirectDebitTestPayment {
  DirectDebitTestPayment(
      {this.ctx,
      required this.paystackPlugin,
      this.planBloc,
      this.cardId,
      this.ref,
      this.url,
      this.userId,
      this.publicKey,
      this.currentPlanId,
      this.action,
      this.price});
  String? cardId;
  BuildContext? ctx;
  PaystackPlugin paystackPlugin;
  String? ref;
  String? url;
  String? action;
  int? userId;
  int? currentPlanId;
  String? publicKey;

  CreatePlanBloc? planBloc;

  final String _cardNumber = "";
  final String _cvv = "";
  String platform = "";
  final int _expiryMonth = 0;
  final int _expiryYear = 0;
  int? price = 0;
  var uuid = const Uuid();

  String _getReference() {
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return ref = '${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
        number: _cardNumber,
        cvc: _cvv,
        expiryMonth: _expiryMonth,
        expiryYear: _expiryYear,
        name: cardId);
  }

  Future chargeCardAndMakePayment() async {
    Charge charge = Charge()
      ..amount = price! * 100
      ..email = SessionManager().userEmailVal
      ..reference = url
      ..card = _getCardFromUI()
      ..putCustomField('Charged From', 'Flutter SDK')
      ..putMetaData(
        "metadata",
        {"cardName": cardId, "refund": true, "userId": userId},
      );

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
      planBloc!.add(VerifyPayment(
        gateWay: "PAYSTACK",
        ref: url!,
      ));
    }
  }
}
// go to a screen