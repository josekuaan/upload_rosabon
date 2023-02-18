import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/paymentInit.dart';
import 'package:rosabon/model/response_models/exchange_rate.dart';
import 'package:rosabon/model/response_models/investmentrate_response.dart';
import 'package:rosabon/model/response_models/product_category_response.dart';
import 'package:rosabon/model/response_models/withholding_tax_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/direct_debit_test_payment.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/plan_summary.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/currency_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/utility/utility.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

class ProductScreen extends StatefulWidget {
  final Products? product;
  final int? productCategoryId;
  const ProductScreen({Key? key, this.product, this.productCategoryId})
      : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> showError = ValueNotifier(false);
  ValueNotifier<bool> showTargetAmountError = ValueNotifier(false);
  bool initLoading = false;
  final productKey = GlobalKey<FormState>();
  final planName = TextEditingController(text: "");
  final exchangeRate = TextEditingController(text: "");
  final productName = TextEditingController(text: "");
  final amountToBePlaced = TextEditingController(text: "");
  final targetAmount = TextEditingController(text: "");
  final contributedValue = TextEditingController(text: "");
  final calculatedInterestRate = TextEditingController();
  final numberOfTickets = TextEditingController(text: "");
  final date = TextEditingController(text: "");
  late CreatePlanBloc createPlanBloc;
  String periodical = "INACTIVE";

  List<Currency> currencylist = [];
  List<Tenor> tenorList = [];
  List<InvestmentValue> investmentValue = [];
  var keyList = [];
  WithholdingTaxResponse? withholdingTax;
  Products? product;
  List weeklyList = [
    {"id": 1, "name": "Monday"},
    {"id": 2, "name": "TuesDay"},
    {"id": 3, "name": "Wednesday"},
    {"id": 4, "name": "Thursday"},
    {"id": 5, "name": "Friday"},
    {"id": 6, "name": "Saturday"},
    {"id": 7, "name": "Sunday"},
  ];
  var uuid = const Uuid();

  String? cardId;
  int? currencyId;
  String? selectedcurrency = "";
  String? tenorName;
  Currency? currency;
  Tenor? tenor;
  // bool allowCustomization = false;
  String interestrecieptOption = "";
  String directDebit = "";
  String autoRenew = "";
  String allowLiquidation = "";
  String maturityValue = "";
  String savingsFrequency = "";
  double? interestRate;
  String? monthly;
  String? weekly;
  String? error;
  String? targetAmountError;
  int? weeklyId;
  int? monthlyId;
  String? val1;

  int tenorDay = 0;
  double calIntrest = 0;
  int customediffDay = 0;

  bool perodicSaving = false;
  bool autoCompute = true;
  bool autoRollover = false;
  var publicKey = 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067';
  final plugin = PaystackPlugin();
  @override
  @override
  void initState() {
    plugin.initialize(
        publicKey: 'pk_test_7e6134abc3ba34cad1566cc35a02fd4cc427b067');
    createPlanBloc = CreatePlanBloc();
    // createPlanBloc.add(const FetchTenor());
    createPlanBloc.add(const FetchInvestment());
    createPlanBloc.add(const WithholdingrateRate());
    Future.delayed(const Duration(milliseconds: 100), () {
      for (var el in widget.product!.currency!) {
        if (el.status == "ACTIVE") {
          currencylist.add(el);
        }
      }
    });
    // int? productCategory = widget.productCategoryId;
    product = widget.product!;

    for (var i = 0; i < widget.product!.tenors!.length; i++) {
      if (widget.product!.tenors![i].tenorName == "Customize Tenor") {
        widget.product!.tenors!.removeAt(i);
      }
    }
    widget.product!.allowCustomization!
        ? widget.product!.tenors!.add(Tenor(
            id: 1,
            tenorName: "Customize Tenor",
            tenorDescription: "",
            tenorDays: 0,
            tenorMonths: 0,
            tenorWeeks: 0,
            tenorYears: 0,
            tenorStatus: "ACTIVE",
            createdDate: DateTime.parse("2012-02-27"),
          ))
        : null;
    if (widget.product!.tenors != null) {
      for (var el in widget.product!.tenors!) {
        if (el.tenorStatus == "ACTIVE") {
          tenorList.add(el);
        }
        // else if (widget.product!.allowCustomization == true) {
        //   tenorList.add(el);
        // }
      }
    } else {
      tenorList = [];
    }

    // tenorList = widget.product!.tenors == null ? [] : widget.product!.tenors!;
    widget.product!.properties!.interestOption!.toJson().forEach((e, v) {
      switch (e) {
        // case 'hasBackendMaturityRate':
        //   if (v) {
        //     keyList.add({"name": "BACKEND_MATURITY"});
        //   }
        //   break;

        // case 'hasBackendBiAnnualInterestRate':
        //   if (v) {
        //     keyList.add({"name": "BACKEND_BI_ANNUAL"});
        //   }
        //   break;
        // case 'hasBackendQuarterlyInterestRate':
        //   if (v) {
        //     keyList.add({"name": "BACKEND_QUARTERLY"});
        //   }
        //   break;
        // case 'hasBackendMonthlyInterestRate':
        //   if (v) {
        //     keyList.add({"name": "BACKEND_MONTHLY"});
        //   }
        //   break;
        case 'hasMaturityRate':
          if (v) {
            keyList.add({"name": "MATURITY"});
          }
          break;
        case 'hasBiAnnualInterestRate':
          if (v) {
            keyList.add({"name": "BI_ANNUAL"});
          }
          break;
        case 'hasMonthlyInterestRate':
          if (v) {
            keyList.add({"name": "MONTHLY"});
          }
          break;
        case 'hasUpfrontInterestRate':
          if (v) {
            keyList.add({"name": "UPFRONT"});
          }
          break;
        // case 'hasBackendUpfrontInterestRate':
        //   if (v) {
        //     keyList.add({"name": "BACKEND_UPFRONT"});
        //   }
        //   break;
        case 'hasQuarterlyInterestRate':
          if (v) {
            keyList.add({"name": "QUARTERLY"});
          }
          break;

        default:
          'Day Not Found';
      }
    });

    super.initState();
  }

  getInvestmentRate(intrecipt) {
    InvestmentValue? invest = InvestmentValue();

    var investRate;
    int custometenor = 100000;

    if (widget.product!.allowCustomization! && date.text.isNotEmpty) {
      var t = tenorList.where((el) => el.tenorDays! > customediffDay);
      // print(t.length);

      for (var i in t) {
        if (custometenor > i.tenorDays!) {
          custometenor = i.tenorDays!;
        }
      }

      for (var el in investmentValue) {
        if (el.investmentCurrency!.status == "ACTIVE"
            //  &&
            // el.product!.id == product!.id &&
            //         el.maximumAmount == product!.maxTransactionLimit &&
            //         selectedcurrency!.toLowerCase() ==
            //             el.investmentCurrency!.name!.toLowerCase()
            ) {
          if (targetAmount.text.isNotEmpty) {
            if (el.product!.id == product!.id &&
                    int.parse(targetAmount.text) == el.minimumAmount!.floor() ||
                int.parse(targetAmount.text) > el.minimumAmount!.floor() &&
                    int.parse(targetAmount.text) == el.maximumAmount!.floor() ||
                int.parse(targetAmount.text) < el.maximumAmount!.floor() &&
                    custometenor < el.maximumTenor! ||
                custometenor == el.maximumTenor! &&
                    custometenor > el.minimumTenor! ||
                custometenor == el.minimumTenor! &&
                    selectedcurrency!.toLowerCase() ==
                        el.investmentCurrency!.name!.toLowerCase()) {
              print("=======================");
              print(el.maturityRate);
              print("=======================");
              investRate = el;
              break;
            }
            // }
          } else {
            if (el.product!.id == product!.id &&
                el.maximumAmount == product!.maxTransactionLimit &&
                selectedcurrency!.toLowerCase() ==
                    el.investmentCurrency!.name!.toLowerCase()) {
              // print(targetAmount.text);
              // print(custometenor);
              // print(el.maximumTenor);
              // print(el.minimumTenor);
              //
              // if (el.investmentCurrency!.status == "ACTIVE") {

              if (el.product!.id == product!.id &&
                      int.parse(amountToBePlaced.text) ==
                          el.minimumAmount!.floor() ||
                  int.parse(amountToBePlaced.text) >
                          el.minimumAmount!.floor() &&
                      int.parse(amountToBePlaced.text) ==
                          el.maximumAmount!.floor() ||
                  int.parse(amountToBePlaced.text) <
                          el.maximumAmount!.floor() &&
                      custometenor < el.maximumTenor! ||
                  custometenor == el.maximumTenor! &&
                      custometenor > el.minimumTenor! ||
                  custometenor == el.minimumTenor! &&
                      selectedcurrency!.toLowerCase() ==
                          el.investmentCurrency!.name!.toLowerCase()) {
                investRate = el;
                break;
              }
            }
          }
        }
      }
    } else {
      print("================helloSS=================");
      print(
          "==================fffffff=====ffffffff=${date.text}==============");
      print("=================================");
      for (var el in investmentValue) {
        if (el.investmentCurrency!.status == "ACTIVE"
            // &&
            // el.product!.id == product!.id &&
            //         el.maximumAmount == product!.maxTransactionLimit &&
            //         selectedcurrency!.toLowerCase() ==
            //             el.investmentCurrency!.name!.toLowerCase()
            ) {
          // print("=======================");
          // print(el.minimumAmount);
          // print(el.maturityRate);
          // print(el.maximumAmount);

          // print(el.maximumTenor);
          // print("=======================");

          if (targetAmount.text.isNotEmpty) {
            bool tempdayMax = tenorDay <= el.maximumTenor!;
            bool tempdayMin = tenorDay >= el.minimumTenor!;
            bool tempAmountMin =
                int.parse(targetAmount.text) >= el.minimumAmount!.floor();
            bool tempAmountMax =
                int.parse(targetAmount.text) <= el.maximumAmount!.floor();
            if (el.product!.id == product!.id &&
                tempdayMax &&
                tempdayMin &&
                tempAmountMax &&
                tempAmountMin &&
                selectedcurrency!.toLowerCase() ==
                    el.investmentCurrency!.name!.toLowerCase()) {
              investRate = el;
              break;
            }
          } else {
            // if (el.investmentCurrency!.status == "ACTIVE") {
            bool tempdayMax = tenorDay <= el.maximumTenor!;
            bool tempdayMin = tenorDay >= el.minimumTenor!;
            bool tempAmountMin =
                int.parse(amountToBePlaced.text) >= el.minimumAmount!.floor();
            bool tempAmountMax =
                int.parse(amountToBePlaced.text) <= el.maximumAmount!.floor();
            if (el.product!.id == product!.id &&
                tempdayMax &&
                tempdayMin &&
                tempAmountMin &&
                tempAmountMax &&
                selectedcurrency!.toLowerCase() ==
                    el.investmentCurrency!.name!.toLowerCase()) {
              investRate = el;
            }
            // }
          }
        }
      }
    }

    if (investRate != null) {
      switch (intrecipt) {
        case "MONTHLY":
          if (customediffDay < 30) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option",
                type: PopupType.failure);
            return setState(() {
              calculatedInterestRate.text = '';
            });
            ;
          } else {
            setState(() {});
            if (widget.product!.properties!.allowsDirectDebit == true) {
              if (targetAmount.text.isNotEmpty) {
                double rate =
                    // selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        ? investRate.monthlyInterestRate != null
                            ? (investRate.percentDirectDebit +
                                investRate.monthlyInterestRate)
                            // : 0.0
                            : investRate.monthlyInterestRate
                        : 0.0;
                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                print("calculated interest$calIntrest");
                final String calIntrestRate;
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                // calculatedInterestRate.text = rate.toString();
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                ((calIntrest) / (customediffDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / (customediffDay / 30) * 1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                ((calIntrest) / (tenorDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / tenorDay / 30 * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.monthlyInterestRate ?? 0;
              } else {
                double rate =
                    // selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        ? investRate.monthlyInterestRate != null
                            ? (investRate.percentDirectDebit +
                                investRate.monthlyInterestRate)
                            // : 0.0
                            : investRate.monthlyInterestRate
                        : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                // calculatedInterestRate.text = rate.toString();
                print(calIntrest);
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.monthlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / (customediffDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / (customediffDay / 30) * 1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / (tenorDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / tenorDay / 30 * 1))
                            .toStringAsFixed(2)
                        : "0";

                //  investRate.monthlyInterestRate != null
                //     ? (int.parse(amountToBePlaced.text) +
                //             (investRate.monthlyInterestRate! / tenorDay * 1) -
                //             withholdingTax!.rate! *
                //                 (investRate.monthlyInterestRate! / tenorDay * 1))
                //         .toStringAsFixed(2)
                //     : "0";

                interestRate = investRate.monthlyInterestRate ?? 0;
              }
            } else {
              if (targetAmount.text.isNotEmpty) {
                double rate =
                    // selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    // directDebit == "Yes"
                    // ?
                    investRate.monthlyInterestRate ?? 0.0;
                // : 0.0;

                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                print("calculated interest$calIntrest");
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                ((calIntrest) / (customediffDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / (customediffDay / 30) * 1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                ((calIntrest) / (tenorDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / tenorDay / 30 * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.monthlyInterestRate ?? 0;
              } else {
                double rate = investRate.monthlyInterestRate ?? 0.0;

                // selectedcurrency!.toLowerCase() ==
                //         investRate.investmentCurrency!.name!.toLowerCase()
                //     ?
                // directDebit == "Yes"
                //     ? investRate.monthlyInterestRate != null
                //         ? (investRate.percentDirectDebit +
                //             investRate.monthlyInterestRate)
                //         // : 0.0
                //         : investRate.monthlyInterestRate
                //     : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                print(calIntrest);
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.monthlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / (customediffDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / (customediffDay / 30) * 1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / (tenorDay / 30) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / tenorDay / 30 * 1))
                            .toStringAsFixed(2)
                        : "0";

                //  investRate.monthlyInterestRate != null
                //     ? (int.parse(amountToBePlaced.text) +
                //             (investRate.monthlyInterestRate! / tenorDay * 1) -
                //             withholdingTax!.rate! *
                //                 (investRate.monthlyInterestRate! / tenorDay * 1))
                //         .toStringAsFixed(2)
                //     : "0";

                interestRate = investRate.monthlyInterestRate ?? 0;
              }
            }
          }
          break;
        case "UPFRONT":
          if (widget.product!.properties!.allowsDirectDebit == true) {
            if (targetAmount.text.isNotEmpty) {
              double rate = selectedcurrency!.toLowerCase() ==
                      investRate.investmentCurrency!.name!.toLowerCase()
                  ? directDebit == "Yes"
                      ? investRate.upfrontInterestRate != null
                          ? (investRate.percentDirectDebit +
                              investRate.upfrontInterestRate)
                          : 0.0
                      : investRate.upfrontInterestRate
                  : 0.0;

              calIntrest =
                  widget.product!.allowCustomization! && date.text.isNotEmpty
                      ? (int.parse(targetAmount.text) *
                              rate *
                              customediffDay /
                              365) /
                          100
                      : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                          100;
              print(rate);
              print(calIntrest);
              calculatedInterestRate.text = rate.toString();
              maturityValue = targetAmount.text;

              interestRate = investRate.upfrontInterestRate ?? 0;
            } else {
              double rate =
                  // selectedcurrency!.toLowerCase() ==
                  //         investRate.investmentCurrency!.name!.toLowerCase()
                  //     ?
                  directDebit == "Yes"
                      // ? investRate.upfrontInterestRate != null
                      ? (investRate.percentDirectDebit +
                          investRate.upfrontInterestRate)
                      // : 0.0
                      : investRate.upfrontInterestRate
                  // : 0.0
                  ;
              calIntrest = widget.product!.allowCustomization! &&
                      date.text.isNotEmpty
                  ? (int.parse(amountToBePlaced.text) *
                          rate *
                          customediffDay /
                          365) /
                      100
                  : (int.parse(amountToBePlaced.text) * rate * tenorDay / 365) /
                      100;
              // calculatedInterestRate.text = rate.toString();
              setState(() {
                String? calIntrestRate = rate.toString();
                calculatedInterestRate.text = calIntrestRate.toString();
              });
              maturityValue = amountToBePlaced.text;
              interestRate = investRate.upfrontInterestRate ?? 0;
            }
          } else {
            if (targetAmount.text.isNotEmpty) {
              double rate = investRate.upfrontInterestRate ?? 0.0;
              // selectedcurrency!.toLowerCase() ==
              //         investRate.investmentCurrency!.name!.toLowerCase()
              //     ?
              directDebit == "Yes"
                  //     ? investRate.upfrontInterestRate != null
                  ? (investRate.percentDirectDebit +
                      investRate.upfrontInterestRate)
                  //         // : 0.0
                  : investRate.upfrontInterestRate;
              //     : 0.0;
              calIntrest =
                  widget.product!.allowCustomization! && date.text.isNotEmpty
                      ? (int.parse(targetAmount.text) *
                              rate *
                              customediffDay /
                              365) /
                          100
                      : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                          100;
              print(calIntrest);
              // calculatedInterestRate.text = rate.toString();
              setState(() {
                String? calIntrestRate = rate.toString();
                calculatedInterestRate.text = calIntrestRate.toString();
              });
              maturityValue = targetAmount.text;

              interestRate = investRate.upfrontInterestRate ?? 0;
            } else {
              double rate = investRate.upfrontInterestRate ?? 0.0;

              // selectedcurrency!.toLowerCase() ==
              //         investRate.investmentCurrency!.name!.toLowerCase()
              //     ?
              directDebit == "Yes"
                  //     ? investRate.upfrontInterestRate != null
                  ? (investRate.percentDirectDebit +
                      investRate.upfrontInterestRate)
                  //         // : 0.0
                  : investRate.upfrontInterestRate;
              //     : 0.0;
              calIntrest = widget.product!.allowCustomization! &&
                      date.text.isNotEmpty
                  ? (int.parse(amountToBePlaced.text) *
                          rate *
                          customediffDay /
                          365) /
                      100
                  : (int.parse(amountToBePlaced.text) * rate * tenorDay / 365) /
                      100;
              // calculatedInterestRate.text = rate.toString();
              setState(() {
                String? calIntrestRate = rate.toString();
                calculatedInterestRate.text = calIntrestRate.toString();
              });
              maturityValue = amountToBePlaced.text;
              interestRate = investRate.upfrontInterestRate ?? 0;
            }
          }
          break;
        case "QUARTERLY":
          if (customediffDay < 90) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option",
                type: PopupType.failure);
            return setState(() {
              calculatedInterestRate.text = '';
            });
          } else {
            if (widget.product!.properties!.allowsDirectDebit == true) {
              if (targetAmount.text.isNotEmpty) {
                double rate =
                    //  selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        // ? investRate.quarterlyInterestRate != null
                        ? (investRate.percentDirectDebit +
                            investRate.quarterlyInterestRate)
                        // : 0.0
                        : investRate.quarterlyInterestRate;
                // : 0.0;
                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.quarterlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((customediffDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest /
                                        ((customediffDay / 30) / 4) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((tenorDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest / ((tenorDay / 30) / 4) * 1))
                            .toStringAsFixed(2)
                        : "0";

                // investRate.quarterlyInterestRate != null
                //     ? (int.parse(targetAmount.text) +
                //             (investRate.quarterlyInterestRate! /
                //                 ((tenorDay / 30) / 4) *
                //                 1) -
                //             withholdingTax!.rate! *
                //                 (investRate.quarterlyInterestRate! /
                //                     ((tenorDay / 30) / 4) *
                //                     1))
                //         .toStringAsFixed(2)
                //     : "0";
                interestRate = investRate.quarterlyInterestRate ?? 0;
              } else {
                double rate =
                    // selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        // ? investRate.quarterlyInterestRate != null
                        ? (investRate.percentDirectDebit +
                            investRate.quarterlyInterestRate)
                        // : 0.0
                        : investRate.quarterlyInterestRate;
                // : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.quarterlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) /
                                    ((customediffDay / 30) / 4) *
                                    1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 4) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.quarterlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / ((tenorDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / ((tenorDay / 30) / 4) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.quarterlyInterestRate ?? 0;
              }
            } else {
              if (targetAmount.text.isNotEmpty) {
                double rate = investRate.quarterlyInterestRate ?? 0.0;

                //  selectedcurrency!.toLowerCase() ==
                //         investRate.investmentCurrency!.name!.toLowerCase()
                //     ?
                directDebit == "Yes"
                    //     ? investRate.quarterlyInterestRate != null
                    ? (investRate.percentDirectDebit +
                        investRate.quarterlyInterestRate)
                    //         // : 0.0
                    : investRate.quarterlyInterestRate;
                //     : 0.0;
                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.quarterlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((customediffDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest /
                                        ((customediffDay / 30) / 4) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.monthlyInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((tenorDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest / ((tenorDay / 30) / 4) * 1))
                            .toStringAsFixed(2)
                        : "0";

                // investRate.quarterlyInterestRate != null
                //     ? (int.parse(targetAmount.text) +
                //             (investRate.quarterlyInterestRate! /
                //                 ((tenorDay / 30) / 4) *
                //                 1) -
                //             withholdingTax!.rate! *
                //                 (investRate.quarterlyInterestRate! /
                //                     ((tenorDay / 30) / 4) *
                //                     1))
                //         .toStringAsFixed(2)
                //     : "0";
                interestRate = investRate.quarterlyInterestRate ?? 0;
              } else {
                double rate = investRate.quarterlyInterestRate ?? 0.0;
                // selectedcurrency!.toLowerCase() ==
                //         investRate.investmentCurrency!.name!.toLowerCase()
                //     ?
                directDebit == "Yes"
                    //     ? investRate.quarterlyInterestRate != null
                    ? (investRate.percentDirectDebit +
                        investRate.quarterlyInterestRate)
                    //         // : 0.0
                    : investRate.quarterlyInterestRate;
                //     : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                // calculatedInterestRate.text = rate.toString();
                setState(() {
                  String? calIntrestRate = rate.toString();
                  calculatedInterestRate.text = calIntrestRate.toString();
                });
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.quarterlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) /
                                    ((customediffDay / 30) / 4) *
                                    1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 4) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.quarterlyInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / ((tenorDay / 30) / 4) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / ((tenorDay / 30) / 4) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.quarterlyInterestRate ?? 0;
              }
            }
          }
          break;
        case "BI_ANNUAL":
          if (customediffDay < 180) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option");
            return setState(() {
              calculatedInterestRate.text = '';
            });
          } else {
            if (widget.product!.properties!.allowsDirectDebit == true) {
              if (targetAmount.text.isNotEmpty) {
                double rate =
                    //  selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        // ? investRate.biAnnualInterestRate != null
                        ? (investRate.percentDirectDebit +
                            investRate.biAnnualInterestRate)
                        // : 0.0
                        : investRate.biAnnualInterestRate;
                // : 0.0;
                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                calculatedInterestRate.text = rate.toString();
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.biAnnualInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((customediffDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 6) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.biAnnualInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((tenorDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest / ((tenorDay / 30) / 6) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.biAnnualInterestRate ?? 1;
              } else {
                double rate =
                    //  selectedcurrency!.toLowerCase() ==
                    //         investRate.investmentCurrency!.name!.toLowerCase()
                    //     ?
                    directDebit == "Yes"
                        // ? investRate.biAnnualInterestRate != null
                        ? (investRate.percentDirectDebit +
                            investRate.biAnnualInterestRate)
                        // : 0.0
                        : investRate.biAnnualInterestRate;
                // : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                calculatedInterestRate.text = rate.toString();
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.biAnnualInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) /
                                    ((customediffDay / 30) / 6) *
                                    1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 6) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.biAnnualInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / ((tenorDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / ((tenorDay / 30) / 6) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.biAnnualInterestRate ?? 0;
              }
            } else {
              if (targetAmount.text.isNotEmpty) {
                double rate = investRate.biAnnualInterestRate ?? 0.0;

                //  selectedcurrency!.toLowerCase() ==
                //         investRate.investmentCurrency!.name!.toLowerCase()
                //     ?
                directDebit == "Yes"
                    //     ? investRate.biAnnualInterestRate != null
                    ? (investRate.percentDirectDebit +
                        investRate.biAnnualInterestRate)
                    //         // : 0.0
                    : investRate.biAnnualInterestRate;
                //     : 0.0;
                calIntrest = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? (int.parse(targetAmount.text) *
                            rate *
                            customediffDay /
                            365) /
                        100
                    : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                        100;
                calculatedInterestRate.text = rate.toString();
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.biAnnualInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((customediffDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 6) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.biAnnualInterestRate != null
                        ? (int.parse(targetAmount.text) +
                                (calIntrest / ((tenorDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    (calIntrest / ((tenorDay / 30) / 6) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.biAnnualInterestRate ?? 1;
              } else {
                double rate = investRate.biAnnualInterestRate ?? 0.0;
                //  selectedcurrency!.toLowerCase() ==
                //         investRate.investmentCurrency!.name!.toLowerCase()
                //     ?
                directDebit == "Yes"
                    //     ? investRate.biAnnualInterestRate != null
                    ? (investRate.percentDirectDebit +
                        investRate.biAnnualInterestRate)
                    //         // : 0.0
                    : investRate.biAnnualInterestRate;
                //     : 0.0;
                calIntrest =
                    widget.product!.allowCustomization! && date.text.isNotEmpty
                        ? (int.parse(amountToBePlaced.text) *
                                rate *
                                customediffDay /
                                365) /
                            100
                        : (int.parse(amountToBePlaced.text) *
                                rate *
                                tenorDay /
                                365) /
                            100;
                calculatedInterestRate.text = rate.toString();
                maturityValue = widget.product!.allowCustomization! &&
                        date.text.isNotEmpty
                    ? investRate.biAnnualInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) /
                                    ((customediffDay / 30) / 6) *
                                    1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) /
                                        ((customediffDay / 30) / 6) *
                                        1))
                            .toStringAsFixed(2)
                        : "0"
                    : investRate.biAnnualInterestRate != null
                        ? (int.parse(amountToBePlaced.text) +
                                ((calIntrest) / ((tenorDay / 30) / 6) * 1) -
                                (withholdingTax!.rate! / 100) *
                                    ((calIntrest) / ((tenorDay / 30) / 6) * 1))
                            .toStringAsFixed(2)
                        : "0";

                interestRate = investRate.biAnnualInterestRate ?? 0;
              }
            }
          }
          break;
        case "MATURITY":
          if (widget.product!.properties!.allowsDirectDebit == true) {
            if (targetAmount.text.isNotEmpty) {
              double rate = selectedcurrency!.toLowerCase() ==
                      investRate.investmentCurrency!.name!.toLowerCase()
                  ? directDebit == "Yes"
                      ? investRate.maturityRate != null
                          ? (investRate.percentDirectDebit +
                              investRate.maturityRate)
                          : 0.0
                      : investRate.maturityRate
                  : 0.0;
              

              calIntrest =
                  widget.product!.allowCustomization! && date.text.isNotEmpty
                      ? (int.parse(targetAmount.text) *
                              rate *
                              customediffDay /
                              365) /
                          100
                      : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                          100;
              print(calIntrest);
              calculatedInterestRate.text = rate.toString();
              maturityValue = investRate.maturityRate != null
                  ? ((int.parse(targetAmount.text) + calIntrest) -
                          (withholdingTax!.rate! / 100) * calIntrest)
                      .toStringAsFixed(2)
                  : "0";
              print(maturityValue);
              interestRate = investRate.maturityRate ?? 0;
            } else {
              double rate =
                  // selectedcurrency!.toLowerCase() ==
                  //         investRate.investmentCurrency!.name!.toLowerCase()
                  //     ?
                  directDebit == "Yes"
                      // ? investRate.maturityRate != null
                      ? (investRate.percentDirectDebit +
                          investRate.maturityRate)
                      // : 0.0
                      : investRate.maturityRate;
              // : 0.0;
              calIntrest = widget.product!.allowCustomization! &&
                      date.text.isNotEmpty
                  ? (int.parse(amountToBePlaced.text) *
                          rate *
                          customediffDay /
                          365) /
                      100
                  : (int.parse(amountToBePlaced.text) * rate * tenorDay / 365) /
                      100;
              calculatedInterestRate.text = rate.toString();
              maturityValue = investRate.maturityRate != null
                  ? ((int.parse(amountToBePlaced.text) + calIntrest) -
                          (withholdingTax!.rate! / 100) * calIntrest)
                      .toStringAsFixed(2)
                  : "0";
              interestRate = investRate.maturityRate ?? 0;
            }
          } else {
            if (targetAmount.text.isNotEmpty) {
              double rate = investRate.maturityRate ?? 0.0;

              // selectedcurrency!.toLowerCase() ==
              //         investRate.investmentCurrency!.name!.toLowerCase()
              //     ?
              directDebit == "Yes"
                  //     ? investRate.maturityRate != null
                  ? (investRate.percentDirectDebit + investRate.maturityRate)
                  //         // : 0.0
                  : investRate.maturityRate;
              //     : 0.0;

              calIntrest =
                  widget.product!.allowCustomization! && date.text.isNotEmpty
                      ? (int.parse(targetAmount.text) *
                              rate *
                              customediffDay /
                              365) /
                          100
                      : (int.parse(targetAmount.text) * rate * tenorDay / 365) /
                          100;

              calculatedInterestRate.text = rate.toString();
              maturityValue = investRate.maturityRate != null
                  ? ((int.parse(targetAmount.text) + calIntrest) -
                          (withholdingTax!.rate! / 100) * calIntrest)
                      .toStringAsFixed(2)
                  : "0";

              interestRate = investRate.maturityRate ?? 0;
            } else {
              double rate = investRate.maturityRate ?? 0.0;
              // selectedcurrency!.toLowerCase() ==
              //         investRate.investmentCurrency!.name!.toLowerCase()
              //     ?
              directDebit == "Yes"
                  //     ? investRate.maturityRate != null
                  ? (investRate.percentDirectDebit + investRate.maturityRate)
                  //         // : 0.0
                  : investRate.maturityRate;
              //     : 0.0;
              calIntrest = widget.product!.allowCustomization! &&
                      date.text.isNotEmpty
                  ? (int.parse(amountToBePlaced.text) *
                          rate *
                          customediffDay /
                          365) /
                      100
                  : (int.parse(amountToBePlaced.text) * rate * tenorDay / 365) /
                      100;
              calculatedInterestRate.text = rate.toString();
              maturityValue = investRate.maturityRate != null
                  ? ((int.parse(amountToBePlaced.text) + calIntrest) -
                          (withholdingTax!.rate! / 100) * calIntrest)
                      .toStringAsFixed(2)
                  : "0";
              interestRate = investRate.maturityRate ?? 0;
            }
          }
          break;
        default:
          calculatedInterestRate.text = " 0.0";
          maturityValue = "0";
          interestRate = 0;
          calIntrest = 0.0;
      }
    } else {
      calculatedInterestRate.text = "0.0";
      maturityValue = "0.0";
      interestRate = 0;
      calIntrest = 0.0;
    }
  }

  List<Exchange> index = [];

  void testCard(String cardId, String url) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              // insetPadding:
              //     const EdgeInsets.symmetric(horizontal: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
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
                          DirectDebitTestPayment(
                                  cardId: cardId,
                                  ctx: context,
                                  paystackPlugin: plugin,
                                  price: 1000,
                                  url: url,
                                  // * map["map"]["exchangeRate"],
                                  // ref: state.url,
                                  publicKey: publicKey,
                                  userId: SessionManager().userIdVal,
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
                              borderRadius: BorderRadius.circular(30)),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: deepKoamaru,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          leadingWidth: 48.0,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(widget.product!.productName.toString(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ),
        body: BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is Fetching) {
                setState(() {
                  initLoading = true;
                });
              }
              if (state is RateLoading) {
                setState(() {
                  exchangeRate.text = "Loading...";
                });
              }

              if (state is RateSuccessful) {
                var map = {};
                // state.exchangeResponse.exchange!.forEach((e) {e.sellingPrice; })
                for (var exchange in state.exchangeResponse.exchange!) {
                  map[exchange.buyingPrice] = exchange.buyingPrice;
                  if (currency!.name == exchange.name) {
                    exchangeRate.text = exchange.buyingPrice != null
                        ? exchange.buyingPrice.toString()
                        : '';
                    setState(() {});
                  }
                }
              }

              if (state is InvestmentSuccessful) {
                for (var el in state.investmentRateResponse.investmentValue!) {
                  if (el.status == "ACTIVE") {
                    investmentValue.add(el);
                  }
                }
              }
              if (state is WithholdingSuccessful) {
                withholdingTax = state.withholdingTaxResponse;
              }
              // if (state is TenorSuccess) {
              //   setState(() {
              //     initLoading = false;
              //   });
              //   tenorList = state.tenorResponse.body!;
              // }
              if (state is PaymentSuccessful) {
                setState(() {
                  cardId = uuid.v4().split("-").join();
                });

                testCard(cardId!, state.url);
              }
              if (state is PlanCreating) {
                setState(() {
                  isLoading.value = true;
                });
              }
              if (state is PaymentError) {
                Navigator.pop(context);
                setState(() {
                  isLoading.value = false;
                });
                PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure);
              }
              if (state is PaymentVerified) {
                print("hhhhhhhhhhhhhhhh");
                Navigator.pop(context);
                PopMessage().displayPopup(
                    context: context,
                    text:
                        "A sum of ₦1000 was debited from your card and refunded.",
                    type: PopupType.success);
              }
            },
            child: initLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Form(
                      key: productKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              // Text(
                              //   ".",
                              //   style: TextStyle(
                              //     color: Theme.of(context).dividerColor,
                              //     fontFamily: "Montserrat",
                              //     fontSize: 9,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                              // const CircleAvatar(radius: 2),
                              // const SizedBox(width: 5),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  widget.product!.productDescription ?? "",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontFamily: "Montserrat",
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Plan Details",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Plan Name",
                            style: TextStyle(
                              color: Theme.of(context).dividerColor,
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppInputField(
                            onChange: (value) {
                              setState(() {});
                            },
                            controller: planName,
                            hintText: "Enter Plan Name",
                            validator: RequiredValidator(
                                errorText: 'this field is required'),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Currency",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 8),
                          CurrencyDropDown(
                              onChanged: (Currency? val) {
                                currency = val!;
                                currencyId = val.id!;
                                selectedcurrency = val.name!;

                                if (val.name != "NGN") {
                                  createPlanBloc.add(
                                      FetchExchangeRate(currency: val.name));
                                } else {
                                  exchangeRate.text = "1";
                                }
                              },
                              dropdownValue: currency,
                              hintText: "Select investment currency",
                              items: currencylist),
                          const SizedBox(height: 20),
                          Text(
                            "Exchange Rate",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: exchangeRate,
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              // hintText: hintText,
                              prefixText: selectedcurrency!.isEmpty
                                  ? ""
                                  : NumberFormat.simpleCurrency(
                                          locale: Platform.localeName,
                                          name: selectedcurrency)
                                      .currencySymbol,
                              hintStyle: const TextStyle(
                                  color: silverChalic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).dividerColor,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                            ),
                            validator: RequiredValidator(
                                errorText: 'This field is required'),
                            // keyboardType: TextInputType.,
                          ),

                          const SizedBox(height: 20),
                          widget.product!.properties!.hasTargetAmount!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Target Amount",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: targetAmount,
                                      // hintText: "",
                                      decoration: InputDecoration(
                                        isDense: true,
                                        // hintText: hintText,
                                        prefixText: selectedcurrency!.isEmpty
                                            ? ""
                                            : NumberFormat.simpleCurrency(
                                                    locale: Platform.localeName,
                                                    name: selectedcurrency)
                                                .currencySymbol,
                                        hintStyle: const TextStyle(
                                            color: silverChalic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                      ),

                                      keyboardType: TextInputType.phone,
                                      validator: RequiredValidator(
                                          errorText: 'This field is required'),
                                      onChanged: (val) {
                                        if (val.isNotEmpty) {
                                          if (int.parse(val) <
                                              widget.product!
                                                  .minTransactionLimit!) {
                                            setState(() {
                                              showTargetAmountError.value =
                                                  true;
                                              targetAmountError =
                                                  "Minimum amount cannot be below ${widget.product!.minTransactionLimit!}";
                                            });
                                          } else if (int.parse(val) >
                                              widget.product!
                                                  .maxTransactionLimit!) {
                                            setState(() {
                                              showTargetAmountError.value =
                                                  true;
                                              targetAmountError =
                                                  "Maximum amount cannot be above ${widget.product!.maxTransactionLimit!}";
                                            });
                                          } else {
                                            setState(() {
                                              targetAmountError = "";
                                              showTargetAmountError.value =
                                                  false;
                                            });
                                          }

                                          int value = (int.parse(val) /
                                                  widget.product!
                                                      .minTransactionLimit!)
                                              .floor();
                                          numberOfTickets.text =
                                              value.toString();
                                        }
                                      },
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: showTargetAmountError,
                                        builder: (context, bool val, _) {
                                          return Visibility(
                                            visible: val,
                                            child: Text(
                                              targetAmountError ?? "",
                                              style: const TextStyle(
                                                  color: redOrange,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 10),
                                            ),
                                          );
                                        }),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Amount To Be Placed",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    //
                                    TextFormField(
                                        controller: amountToBePlaced,
                                        // hintText: "",
                                        decoration: InputDecoration(
                                          isDense: true,
                                          // hintText: hintText,
                                          prefixText: selectedcurrency!.isEmpty
                                              ? ""
                                              : NumberFormat.simpleCurrency(
                                                      locale:
                                                          Platform.localeName,
                                                      name: selectedcurrency)
                                                  .currencySymbol,
                                          hintStyle: const TextStyle(
                                              color: silverChalic,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  'AmountTo be placed is required'),
                                        ]),

                                        //  RequiredValidator(
                                        //     errorText: 'This field is required'),
                                        onChanged: (val) {
                                          if (val.isNotEmpty) {
                                            if (int.parse(val) <
                                                widget.product!
                                                    .minTransactionLimit!
                                                    .floor()) {
                                              setState(() {
                                                error =
                                                    "Minimum amount cannot be below ${widget.product!.minTransactionLimit!.floor()}";
                                                showError.value = true;
                                              });
                                            } else if (int.parse(val) >
                                                widget.product!
                                                    .maxTransactionLimit!
                                                    .floor()) {
                                              setState(() {
                                                error =
                                                    "Maximum amount cannot be above ${widget.product!.maxTransactionLimit!.floor()}";
                                                showError.value = true;
                                              });
                                            } else {
                                              setState(() {
                                                error = "";
                                                showError.value = false;
                                              });
                                            }
                                            int value = (double.parse(val) /
                                                    widget.product!
                                                        .minTransactionLimit!)
                                                .floor();
                                            numberOfTickets.text =
                                                value.toString();
                                          }
                                        }),
                                    ValueListenableBuilder(
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
                                    const SizedBox(height: 20),
                                  ],
                                ),
                          Text(
                            "Tenor",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                          DropdownButtonFormField2<Tenor>(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.red),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  )),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Tenor",
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                            iconSize: 30,
                            buttonHeight: 50,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: tenorList
                                .map((item) => DropdownMenuItem<Tenor>(
                                      value: item,
                                      child: Text(
                                        item.tenorName != null
                                            ? "${item.tenorName}"
                                            : "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: tenor,
                            validator: (value) =>
                                value == null ? 'Field cannot be empty' : null,
                            onChanged: (Tenor? val) {
                              tenor = val;
                              setState(() {
                                tenorName = val!.tenorName;
                                if (val.tenorName != "Customize Tenor") {
                                  date.text = "";
                                  tenorDay = val.tenorDays!;
                                } else {
                                  customediffDay = val.tenorDays!;
                                  var now = DateTime.now()
                                      .add(Duration(days: customediffDay));
                                  var formatter = DateFormat('yyyy-MM-dd');
                                  date.text = formatter.format(now).toString();

                                  if (customediffDay >= 2) {
                                    setState(() {
                                      periodical = "ACTIVE";
                                    });
                                  } else {
                                    setState(() {
                                      periodical = "INACTIVE";
                                    });
                                  }
                                }
                              });

                              // date.text = DateTime.now()
                              //     .add(Duration(days: customediffDay))
                              //     .toString();
                              //  DateFormat(
                              //                                   "yyyy-MM-dd")
                              //                               .format(customediffDay);
                              //                           customediffDay.toString();
                              // tenorDay = customediffDay;
                              // allowCustomization = val!.allowCustomization!;
                            },
                          ),
                          tenorName == "Customize Tenor"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      "Customize",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: date,
                                      onTap: () async {
                                        var tempMin = 0;
                                        int tempMax = 0;
                                        // productElement.tenors.sort((a,b)=>a)
                                        for (var el
                                            in widget.product!.tenors!) {
                                          if (tempMax < el.tenorDays!) {
                                            tempMax = el.tenorDays!;
                                          }
                                          for (var el
                                              in widget.product!.tenors!) {
                                            if (tempMax > el.tenorDays!) {
                                              if (tempMin < el.tenorDays!) {
                                                tempMin = el.tenorDays!;
                                              }
                                            }
                                          }
                                        }

                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 24),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: SizedBox(
                                                  height: 320,
                                                  child: SfDateRangePicker(
                                                    onSelectionChanged:
                                                        (DateRangePickerSelectionChangedArgs
                                                            args) {
                                                      getDateDiff(DateFormat(
                                                              "dd-MM-yyyy HH:mm")
                                                          .format(args.value));

                                                      setState(() {
                                                        date.text = DateFormat(
                                                                "yyyy-MM-dd")
                                                            .format(args.value);
                                                        args.value.toString();
                                                      });
                                                      // tenorDay = 0;
                                                      Navigator.pop(context);
                                                    },
                                                    selectionMode:
                                                        DateRangePickerSelectionMode
                                                            .single,
                                                    minDate: DateTime.now()
                                                        .add(Duration(days: 0)),
                                                    maxDate: DateTime.now().add(
                                                        Duration(
                                                            days: tempMax)),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        // hintText: widget.hintText,
                                        suffixIcon: const Icon(
                                            Icons.calendar_today_outlined),
                                        hintStyle: const TextStyle(
                                            color: silverChalic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          widget.product!.properties!.hasTargetAmount!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      "Savings Frequency",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppDropDown(
                                        onChanged: (dynamic val) {
                                          computeValue(val);

                                          savingsFrequency = val;
                                          setState(() {});
                                        },
                                        dropdownValue: savingsFrequency,
                                        hintText: "",
                                        items: const <dynamic>[
                                          {"name": "Daily"},
                                          {"name": "Weekly"},
                                          {"name": "Monthly"}
                                        ]),
                                    savingsFrequency == "Weekly"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                              Text(
                                                "Set Weekly Contribution Day",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat"),
                                              ),
                                              const SizedBox(height: 8),
                                              DropdownButtonFormField2<dynamic>(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  errorBorder:
                                                      const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid,
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                5.0),
                                                          )),
                                                ),
                                                isExpanded: true,
                                                // hint: Text(
                                                //   "",
                                                //   style: const TextStyle(fontSize: 14),
                                                // ),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .color,
                                                ),
                                                iconSize: 30,
                                                buttonHeight: 55,
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                // value: weekly,
                                                items: weeklyList
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            dynamic>(
                                                          value: item,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 13),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 15,
                                                                    width: 15,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50)),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(item[
                                                                          "name"]
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              const Divider(
                                                                  color: alto)
                                                            ],
                                                          ),
                                                        ))
                                                    .toList(),
                                                validator: (value) => value ==
                                                        null
                                                    ? 'Field cannot be empty'
                                                    : null,
                                                onChanged: (dynamic val) {
                                                  setState(() {
                                                    weekly = val["name"];
                                                    weeklyId = val["id"];
                                                  });
                                                },
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    savingsFrequency == "Monthly"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                              Text(
                                                "Set Monthly Contribution Day",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat"),
                                              ),
                                              const SizedBox(height: 8),
                                              DropdownButtonFormField(
                                                selectedItemBuilder:
                                                    (BuildContext context) {
                                                  return months.map((value) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0,
                                                              left: 16.0),
                                                      child: Text(
                                                        value["name"],
                                                      ),
                                                    );
                                                  }).toList();
                                                },
                                                items: months.map((value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 13),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 15,
                                                              width: 15,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Text(value["name"]
                                                                .toString()),
                                                          ],
                                                        ),
                                                        const Divider(
                                                            color: alto)
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (dynamic val) {
                                                  setState(() {
                                                    monthly = val["name"]!;
                                                    monthlyId = val["id"]!;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  // borderRadius: BorderRadius.circular(5),
                                                ),
                                                icon: const Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              : Container(),
                          if (widget.product!.properties!.allowsDirectDebit ==
                              true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Direct Debit",
                                  style: TextStyle(
                                      color: Theme.of(context).dividerColor,
                                      fontFamily: "Montserrat"),
                                ),
                                const SizedBox(height: 8),
                                AppDropDown(
                                    onChanged: (dynamic val) {
                                      directDebit = val;
                                      setState(() {
                                        interestrecieptOption;
                                        getInvestmentRate(
                                            interestrecieptOption);
                                        if (val == 'Yes') {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) => const Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                          createPlanBloc.add(PaymentInitialize(
                                            paymentInit: PaymentInit(
                                              amount: "1000",
                                              email:
                                                  SessionManager().userEmailVal,
                                              refund: true,
                                              purposeOfPayment: "TEST_CARD",
                                            ),
                                          ));
                                        }
                                      });
                                    },
                                    dropdownValue: directDebit,
                                    hintText: "Setup Direct Debit ",
                                    items: const <dynamic>[
                                      {"name": "Yes"},
                                      {"name": "No"}
                                    ]),
                                // const SizedBox(height: 8),
                                Text(
                                  "The direct debit mandate automatically deducts your contribution value from your bank account at zero cost.",
                                  style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontFamily: "Montserrat",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 20),
                          Text(
                            "Interest Receipt Option",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 8),
                          AppDropDown(
                              onChanged: (dynamic val1) {
                                interestrecieptOption = val1;
                                getInvestmentRate(val1);
                              },
                              dropdownValue: "",
                              hintText: "Select Interest Receipt option",
                              items: keyList),
                          const SizedBox(height: 8),
                          Text(
                            "You have an option of choosing when to be paid your interest",
                            style: TextStyle(
                              color: Theme.of(context).dividerColor,
                              fontFamily: "Montserrat",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          !widget.product!.properties!.hasTargetAmount!
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contribution value",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppInputField(
                                      controller: contributedValue,
                                      hintText: "",
                                      enabled: !autoCompute,
                                      textInputType: TextInputType.phone,
                                      onChange: (val) {
                                        if (val.isNotEmpty) {
                                          var v =
                                              (int.parse(contributedValue.text)
                                                          .floor() *
                                                      tenorDay)
                                                  .toString();

                                          targetAmount.text = v;
                                        }
                                      },
                                      validator: RequiredValidator(
                                          errorText: 'this field is required'),
                                    ),
                                    widget.product!.properties!.acceptsRollover!
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Checkbox(
                                                    value: autoCompute,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        autoCompute = value!;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  // width: 200,
                                                  child: Text(
                                                    autoCompute
                                                        ? "Uncheck to change contribution value"
                                                        : "Check to lock contribution value",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .dividerColor,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                          // const SizedBox(height: 20),
                          widget.product!.properties!.hasSavingFrequency!
                              ? Container()
                              : Column(
                                  children: [
                                    if (periodical == 'ACTIVE')
                                      if (widget.product!.properties!
                                              .hasContributionValue! ==
                                          true)
                                        // if (customediffDay= null||customediffDay >= 2)

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: Checkbox(
                                                      value: perodicSaving,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          perodicSaving =
                                                              value!;
                                                        });
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    // width: 200,
                                                    child: Text(
                                                      "I agree to pay this amount periodically",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            perodicSaving
                                                ? Container()
                                                : const Text(
                                                    "Kindly confirm periodic payment",
                                                    style: TextStyle(
                                                      color: redOrange,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                  ],
                                ),
                          const SizedBox(height: 10),
                          Text(
                            "Interest Rate (%)",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 8),
                          AppInputField(
                            controller: calculatedInterestRate,
                            hintText: "",
                            enabled: false,
                            textInputType: TextInputType.phone,
                            validator: RequiredValidator(
                                errorText: 'this field is required'),
                          ),
                          widget.product!.properties!.allowsMonthlyDraw!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      "Number of tickets",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppInputField(
                                      controller: numberOfTickets,
                                      hintText: "",
                                      enabled: false,
                                      textInputType: TextInputType.phone,
                                      validator: RequiredValidator(
                                          errorText: 'this field is required'),
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 20),
                          widget.product!.properties!.acceptsRollover!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Auto renew",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppDropDown(
                                        onChanged: (dynamic val) {
                                          setState(() {
                                            autoRenew = val;
                                          });
                                        },
                                        dropdownValue: autoRenew,
                                        hintText: "",
                                        items: const <dynamic>[
                                          {"name": "Yes"},
                                          {"name": "No"}
                                        ]),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Allows for funds to be automatically rolled over at maturity.",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              : Container(),
                          widget.product!.properties!.allowsLiquidation!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Allow liquidation",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppDropDown(
                                        onChanged: (dynamic val) {
                                          setState(() {
                                            allowLiquidation = val;
                                          });
                                        },
                                        dropdownValue: allowLiquidation,
                                        hintText: "",
                                        items: const <dynamic>[
                                          {"name": "Yes"},
                                          {"name": "No"}
                                        ]),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Allows for you to withdraw before maturity.",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 40),
                          Appbutton(
                            onTap: () {
                              // if (savingsFrequency.toLowerCase() != "daily"
                              // ) {
                              //   if (customediffDay < 7) {
                              //     PopMessage().displayPopup(
                              //         context: context,
                              //         text:
                              //             "The savings frequency you chose is not valid",
                              //         type: PopupType.failure);
                              //     return;
                              //   } else {}
                              //   if (customediffDay < 30) {
                              //     PopMessage().displayPopup(
                              //         context: context,
                              //         text:
                              //             "The savings frequency you chose is not valid",
                              //         type: PopupType.failure);
                              //     return;
                              //   }
                              // }

                              if (productKey.currentState!.validate() &&
                                  contributedValue.text != "0" &&
                                  targetAmount.text != "0") {
                                if (amountToBePlaced.text.isNotEmpty) {
                                  if (int.parse(amountToBePlaced.text) <=
                                          widget.product!.maxTransactionLimit!
                                              .floor() &&
                                      int.parse(amountToBePlaced.text) >=
                                          widget.product!.minTransactionLimit!
                                              .floor()) {
                                    double withholding = calIntrest *
                                        withholdingTax!.rate! /
                                        100;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlanSummary(arguments: {
                                          "action": "create",
                                          "productId": widget.product!.id,
                                          "cardId": cardId,
                                          "productCategoryId":
                                              widget.productCategoryId,
                                          "planName": planName.text,
                                          "paymentType": widget
                                              .product!.properties!.paymentType,
                                          "allowsLiquidation":
                                              allowLiquidation == "Yes"
                                                  ? true
                                                  : false,
                                          "amount": amountToBePlaced
                                                  .text.isNotEmpty
                                              ? int.parse(amountToBePlaced.text)
                                              : null,
                                          "maturityValue": maturityValue,
                                          "principal": amountToBePlaced
                                                  .text.isNotEmpty
                                              ? int.parse(amountToBePlaced.text)
                                              : int.parse(targetAmount.text),
                                          "autoRenew":
                                              autoRenew == "Yes" ? true : false,
                                          "autoRollover": false,
                                          // widget.product!
                                          //     .properties!.acceptsRollover,
                                          "contributionValue":
                                              contributedValue.text.isEmpty
                                                  ? "0.0"
                                                  : contributedValue.text,
                                          "currency": currencyId,
                                          "currency_symbol": selectedcurrency,
                                          "withholdingTax":
                                              withholdingTax!.rate,
                                          "withholding":
                                              withholding.toStringAsFixed(2),
                                          "customizeTenor": date.text,
                                          "calculatedInterest":
                                              calIntrest.toStringAsFixed(2),
                                          "calculatedInterestRate":
                                              calculatedInterestRate
                                                      .text.isEmpty
                                                  ? 0.0
                                                  : calculatedInterestRate.text,
                                          "targetAmount":
                                              targetAmount.text.isNotEmpty
                                                  ? int.parse(targetAmount.text)
                                                  : null,
                                          "interestRate": interestRate ?? 0.0,
                                          "interestReceiptOption":
                                              interestrecieptOption,
                                          "exchangeRate": exchangeRate
                                                  .text.isNotEmpty
                                              ? double.parse(exchangeRate.text)
                                              : 0.0,
                                          "directDebit": directDebit == "Yes"
                                              ? true
                                              : false,
                                          "numberOfTickets":
                                              numberOfTickets.text.isNotEmpty
                                                  ? numberOfTickets.text
                                                  : 0,
                                          "savingFrequency":
                                              savingsFrequency.isNotEmpty
                                                  ? savingsFrequency
                                                  : null,
                                          "monthlyContributionDay": monthlyId,
                                          "weeklyContributionDay": weekly ?? "",
                                          "tenorId":
                                              //  date.text.isNotEmpty
                                              //     ? null
                                              // :
                                              tenor!.id,
                                          "actualMaturityDate": date
                                                  .text.isEmpty
                                              ? Moment.fromDateTime(DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day)
                                                      .add(Duration(
                                                          days:
                                                              customediffDay)))
                                                  .format("yyyy-MM-dd")
                                              : date.text,
                                          // date.text,

                                          "tenorDay": tenorDay
                                        }),
                                      ),
                                    );
                                  }
                                } else {
                                  double withholding =
                                      calIntrest * withholdingTax!.rate! / 100;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlanSummary(arguments: {
                                        "action": "create",
                                        "productId": widget.product!.id,
                                        "cardId": cardId,
                                        "productCategoryId":
                                            widget.productCategoryId,
                                        "planName": planName.text,
                                        "paymentType": widget
                                            .product!.properties!.paymentType,
                                        "allowsLiquidation":
                                            allowLiquidation == "Yes"
                                                ? true
                                                : false,
                                        "amount": amountToBePlaced
                                                .text.isNotEmpty
                                            ? int.parse(amountToBePlaced.text)
                                            : 0,
                                        "maturityValue": maturityValue,
                                        "principal": amountToBePlaced
                                                .text.isNotEmpty
                                            ? int.parse(amountToBePlaced.text)
                                            : int.parse(targetAmount.text),
                                        "autoRenew":
                                            autoRenew == "Yes" ? true : false,
                                        "autoRollover": false,
                                        //  widget
                                        //     .product!.properties!.acceptsRollover,
                                        "contributionValue":
                                            contributedValue.text.isEmpty
                                                ? 0.0
                                                : contributedValue.text,
                                        "currency": currencyId,
                                        "currency_symbol": selectedcurrency,
                                        "withholdingTax": withholdingTax!.rate!,
                                        "withholding":
                                            withholding.toStringAsFixed(2),
                                        "calculatedInterest":
                                            calIntrest.toStringAsFixed(2),
                                        "calculatedInterestRate":
                                            calculatedInterestRate.text.isEmpty
                                                ? 0.0
                                                : calculatedInterestRate.text,
                                        "targetAmount":
                                            targetAmount.text.isNotEmpty
                                                ? int.parse(targetAmount.text)
                                                : null,
                                        "interestRate": interestRate ?? 0.0,
                                        "interestReceiptOption":
                                            interestrecieptOption,
                                        "exchangeRate": exchangeRate
                                                .text.isNotEmpty
                                            ? double.parse(exchangeRate.text)
                                            : 0.0,
                                        "directDebit": // remember to change this back to true/false
                                            directDebit == "Yes" ? true : false,
                                        "numberOfTickets":
                                            numberOfTickets.text.isNotEmpty
                                                ? numberOfTickets.text
                                                : 0,
                                        "savingFrequency":
                                            savingsFrequency.isNotEmpty
                                                ? savingsFrequency
                                                : null,
                                        "monthlyContributionDay": monthlyId,
                                        "weeklyContributionDay": weekly ?? "",
                                        "tenorId":
                                            //  date.text.isNotEmpty
                                            //     ? null
                                            // :
                                            tenor!.id,
                                        "actualMaturityDate": date.text.isEmpty
                                            ? Moment.fromDateTime(DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        DateTime.now().day)
                                                    .add(Duration(
                                                        days: customediffDay)))
                                                .format("yyyy-MM-dd")
                                            : date.text,
                                        "tenorDay": tenorDay,
                                      }),
                                    ),
                                  );
                                }
                              }
                            },
                            title: "Next",
                            backgroundColor: deepKoamaru,
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 24)
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }

  getDateDiff(String date) {
    var dt2 = DateFormat("dd-MM-yyyy").parse(date);

    final date1 = Moment.now().format("dd-MM-yyyy");

    final dt1 = DateFormat("dd-MM-yyyy").parse(date1);
    customediffDay = dt2.difference(dt1).inDays;
  }

  computeValue(dynamic val) {
    if (tenor == null) return;
    if (tenor!.tenorDays == 0 && customediffDay == 0) {
      PopMessage().displayPopup(
          context: context,
          text: "Please Select a Custome Date",
          type: PopupType.failure);
    }
    if (autoCompute == true) {
      switch (val) {
        case "Daily":
          contributedValue.text = tenor!.tenorDays == 0
              ? customediffDay == 0
                  ? ""
                  : (int.parse(targetAmount.text) / customediffDay)
                      .floor()
                      .toStringAsFixed(2)
              : (int.parse(targetAmount.text) / tenor!.tenorDays!)
                  .floor()
                  .toStringAsFixed(2);
          break;

        case "Weekly":
          contributedValue.text = tenor!.tenorDays == 0
              ? customediffDay == 0
                  ? ""
                  : (int.parse(targetAmount.text) /
                          (customediffDay / 7).floor())
                      .toStringAsFixed(2)
              : (int.parse(targetAmount.text) /
                      ((tenor!.tenorDays!) / 7).floor())
                  .toStringAsFixed(2);
          break;

        case "Monthly":

          // int tenormonth = tenor!.tenorMonths! != 0 ? tenor!.tenorMonths! : 1;
          contributedValue.text = tenor!.tenorDays == 0
              ? customediffDay == 0
                  ? ""
                  : (int.parse(targetAmount.text) / (customediffDay / 30))
                      .toStringAsFixed(2)
              : tenor!.tenorMonths != 0
                  ? (int.parse(targetAmount.text) / tenor!.tenorMonths!)
                      .toStringAsFixed(2)
                  : "0";
          break;

        default:
          break;
      }
    } else {
      switch (val) {
        case "Daily":
          targetAmount.text = tenor!.tenorDays == 0
              ? (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * customediffDay)
                  .toStringAsFixed(2)
              : (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * (tenor!.tenorDays!))
                  .toStringAsFixed(2);
          // targetAmount.text = (contributedValue.text.isEmpty
          //         ? 0
          //         : contributedValue.text * tenor!.tenorDays!)
          //     .toString();

          break;

        case "Weekly":
          targetAmount.text = tenor!.tenorDays == 0
              ? (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * customediffDay / 7)
                  .floor()
                  .toStringAsFixed(2)
              : (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * (tenor!.tenorDays!) / 7)
                  .floor()
                  .toStringAsFixed(2);
          // targetAmount.text = (contributedValue.text.isEmpty
          //         ? 1
          //         : contributedValue.text * tenor!.tenorWeeks!)
          //     .toString();
          break;

        case "Monthly":
          targetAmount.text = tenor!.tenorDays == 0
              ? (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * customediffDay / 30)
                  .toStringAsFixed(2)
              : (contributedValue.text.isNotEmpty
                      ? int.parse(contributedValue.text)
                      : 0 * (tenor!.tenorDays!) / 30)
                  .toStringAsFixed(2);
          // targetAmount.text = (contributedValue.text.isEmpty
          //         ? 1
          //         : contributedValue.text * tenor!.tenorMonths!)
          //     .toString();
          break;

        default:
          break;
      }
    }
  }
}
