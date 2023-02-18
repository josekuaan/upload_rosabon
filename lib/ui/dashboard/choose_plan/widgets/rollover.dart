import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/product/products_bloc.dart';
import 'package:rosabon/model/response_models/investmentrate_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/product_response.dart';
import 'package:rosabon/model/response_models/withholding_tax_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';

import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class RollOver extends StatefulWidget {
  final String role;
  final Plan plan;
  const RollOver({Key? key, required this.role, required this.plan})
      : super(key: key);

  @override
  State<RollOver> createState() => _RollOverState();
}

class _RollOverState extends State<RollOver> {
  final rolloverKey = GlobalKey<FormState>();
  final amount = TextEditingController();
  final calculatedIntrest = TextEditingController();
  ValueNotifier<bool> showError = ValueNotifier(false);
  Plan? plan;
  List<ProductTenor> _tenor = [];
  ProductTenor? productTenor;

  String selectProduct = "3 Month";
  bool partialrollover = false;
  bool fullrollover = false;
  double? calIntrest = 0.0;
  String? maturityValue;
  String? error;
  WithholdingTaxResponse? withholdingTax;
  InvestmentValue? investment;
  List<InvestmentValue> investmentValue = [];

  late CreatePlanBloc createPlanBloc;
  late ProductsBloc productsBloc;

  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    productsBloc = ProductsBloc();
    productsBloc.add(FetchProductById(id: widget.plan.productPlan!.id!));
    createPlanBloc.add(const FetchInvestment());
    createPlanBloc.add(const WithholdingrateRate());
    super.initState();
  }

  // withholdTax() {
  //   double withholding = calIntrest * withholdingTax!.rate! / 100;
  // }

  getInvestmentRate(option) {
    print(investmentValue);
    print("===================");
    for (var el in investmentValue) {
      // print(productTenor!.tenorDays);
      // print(el.maximumTenor);
      // print(el.maximumAmount);
      // print(el.minimumAmount);
      // print(el.maximumTenor);
      // print(productTenor!.tenorDays);
      // print(investment!.minimumTenor);
      bool productTenorDaysLessThanMax =
          productTenor!.tenorDays! <= el.maximumTenor!;
      bool productTenorDaysLessThanMin =
          productTenor!.tenorDays! >= el.minimumTenor!;
      bool amountMax = int.parse(amount.text) <= el.maximumAmount!.floor();
      bool amountMin = int.parse(amount.text) >= el.minimumAmount!.floor();

      if (el.product!.id == widget.plan.productPlan!.id) {
        if (amountMax && amountMin) {
          if (productTenorDaysLessThanMax && productTenorDaysLessThanMin) {
            investment = el;
          }
        }
      }
    }
    // print(investment!.maximumAmount);
    // print(investment!.minimumAmount);
    // print(investment!.maximumTenor);
    // print(productTenor!.tenorDays);
    // print(investment!.minimumTenor);
    // print(option);
    // print(investment);

    if (investment != null) {
      // print(investment!.toJson());
      switch (option) {
        case "MONTHLY":
          if (productTenor!.tenorDays! < 30) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option");
            return;
          }
          double rate = widget.plan.currency!.name!.toLowerCase() ==
                  investment!.investmentCurrency!.name!.toLowerCase()
              ? widget.plan.directDebit!
                  ? investment!.monthlyInterestRate != null
                      ? (investment!.percentDirectDebit +
                          investment!.monthlyInterestRate)
                      : 0.0
                  : investment!.monthlyInterestRate
              : 0.0;
          calIntrest =
              (int.parse(amount.text) * rate * productTenor!.tenorDays! / 365) /
                  100;
          print("calculated interest$calIntrest");

          calculatedIntrest.text = rate.toString();
          maturityValue = investment!.monthlyInterestRate != null
              ? (int.parse(amount.text) +
                      ((calIntrest)! / (productTenor!.tenorDays! / 30) * 1) -
                      (withholdingTax!.rate! / 100) *
                          ((calIntrest)! / (productTenor!.tenorDays! / 30) * 1))
                  .toStringAsFixed(2)
              : amount.text;

          // interestRate = investRate.monthlyInterestRate ?? 0;

          break;

        case "UPFRONT":
          print(widget.plan.currency!.name);
          print(investment!.investmentCurrency!.name);
          double rate = widget.plan.currency!.name!.toLowerCase() ==
                  investment!.investmentCurrency!.name!.toLowerCase()
              ? widget.plan.directDebit!
                  ? investment!.upfrontInterestRate != null
                      ? (investment!.percentDirectDebit +
                          investment!.upfrontInterestRate)
                      : 0.0
                  : investment!.upfrontInterestRate
              : 0.0;
          calIntrest =
              (int.parse(amount.text) * rate * productTenor!.tenorDays! / 365) /
                  100;
          print("calculated upfront$rate");
          print("calculated upfront$calIntrest");

          calculatedIntrest.text = rate.toString();
          maturityValue = amount.text;

          // interestRate = investRate.monthlyInterestRate ?? 0;

          break;
        case "QUARTERLY":
          if (productTenor!.tenorDays! < 90) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option");
            return;
          }
          double rate = widget.plan.currency!.name!.toLowerCase() ==
                  investment!.investmentCurrency!.name!.toLowerCase()
              ? widget.plan.directDebit!
                  ? investment!.quarterlyInterestRate != null
                      ? (investment!.percentDirectDebit +
                          investment!.quarterlyInterestRate)
                      : 0.0
                  : investment!.quarterlyInterestRate
              : 0.0;
          calIntrest =
              (int.parse(amount.text) * rate * productTenor!.tenorDays! / 365) /
                  100;
          print("calculated interest$calIntrest");

          calculatedIntrest.text = rate.toString();
          maturityValue = investment!.quarterlyInterestRate != null
              ? (int.parse(amount.text) +
                      ((calIntrest)! /
                          ((productTenor!.tenorDays! / 30) / 4) *
                          1) -
                      (withholdingTax!.rate! / 100) *
                          ((calIntrest)! /
                              ((productTenor!.tenorDays! / 30) / 4) *
                              1))
                  .toStringAsFixed(2)
              : amount.text;

          // interestRate = investRate.monthlyInterestRate ?? 0;

          break;
        case "BI_ANNUAL":
          if (productTenor!.tenorDays! < 180) {
            PopMessage().displayPopup(
                context: context,
                text: "Select a valid interest reciept option");
            return;
          }
          double rate = widget.plan.currency!.name!.toLowerCase() ==
                  investment!.investmentCurrency!.name!.toLowerCase()
              ? widget.plan.directDebit!
                  ? investment!.quarterlyInterestRate != null
                      ? (investment!.percentDirectDebit +
                          investment!.quarterlyInterestRate)
                      : 0.0
                  : investment!.quarterlyInterestRate
              : 0.0;
          calIntrest =
              (int.parse(amount.text) * rate * productTenor!.tenorDays! / 365) /
                  100;
          print("calculated interest$calIntrest");

          calculatedIntrest.text = rate.toString();
          maturityValue = investment!.quarterlyInterestRate != null
              ? (int.parse(amount.text) +
                      ((calIntrest)! /
                          ((productTenor!.tenorDays! / 30) / 6) *
                          1) -
                      (withholdingTax!.rate! / 100) *
                          ((calIntrest)! /
                              ((productTenor!.tenorDays! / 30) / 6) *
                              1))
                  .toStringAsFixed(2)
              : amount.text;

          // interestRate = investRate.monthlyInterestRate ?? 0;

          break;
        case "MATURITY":
          double rate = widget.plan.currency!.name!.toLowerCase() ==
                  investment!.investmentCurrency!.name!.toLowerCase()
              ? widget.plan.directDebit!
                  ? investment!.maturityRate != null
                      ? (investment!.percentDirectDebit +
                          investment!.maturityRate)
                      : 0.0
                  : investment!.maturityRate
              : 0.0;
          calIntrest =
              (int.parse(amount.text) * rate * productTenor!.tenorDays! / 365) /
                  100;
          print("calculated interest$calIntrest");

          calculatedIntrest.text = rate.toString();
          maturityValue = investment!.maturityRate != null
              ? ((int.parse(amount.text) + calIntrest!) -
                      (withholdingTax!.rate! / 100) * calIntrest!)
                  .toStringAsFixed(2)
              : amount.text;

          // interestRate = investRate.monthlyInterestRate ?? 0;

          break;

        default:
          calculatedIntrest.text = " 0.0";
          maturityValue = amount.text;
          // interestRate = 0;
          calIntrest = 0.0;
      }
    } else {
      print("come hereeeeeeeeeeee");
      setState(() {
        calculatedIntrest.text = "0.0";
        maturityValue = amount.text;
        // interestRate = 0;
        calIntrest = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Rollover"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is InvestmentSuccessful) {
                setState(() {
                  investmentValue =
                      state.investmentRateResponse.investmentValue!;
                });
              }
              if (state is Fetching) {}

              if (state is WithholdingSuccessful) {
                withholdingTax = state.withholdingTaxResponse;
              }
            },
          ),
          BlocListener<ProductsBloc, ProductsState>(
            bloc: productsBloc,
            listener: (context, state) {
              if (state is SingleProduct) {
                setState(() {
                  _tenor = state.item.tenors!;
                });
              }
            },
          ),
        ],
        child: Form(
          key: rolloverKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
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
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/medium_bg.PNG"))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.plan.planName ?? "",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    widget.plan.planName ?? "",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Text(
                                widget.plan.planStatus ?? "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
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
                                    yMDDate(
                                        widget.plan.planSummary!.startDate!),
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
                                    yMDDate(widget.plan.planSummary!.endDate!),
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
                          const SizedBox(height: 23),
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
                                    "//${NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.plan.currency != null ? widget.plan.currency!.name : "NGN").currencySymbol} ${MoneyFormatter(amount: widget.plan.planSummary!.principal!).output.nonSymbol}",
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
                    const Text("Partial Rollover"),
                    Checkbox(
                      value: partialrollover,
                      onChanged: (bool? value) {
                        setState(() {
                          partialrollover = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
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
                    const Text("Full Rollover"),
                    Checkbox(
                      value: fullrollover,
                      onChanged: (bool? value) {
                        setState(() {
                          fullrollover = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Input amount",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppInputField(
                  controller: amount,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: "₦ 0.00",
                  validator: RequiredValidator(errorText: 'This is required'),
                  onChange: (val) {
                    if (val.isNotEmpty) {
                      if (int.parse(val) >
                          widget.plan.productPlan!.maxTransactionLimit!
                              .floor()) {
                        setState(() {
                          error =
                              "Maximum Amount connot be above ${widget.plan.planSummary!.principal!.floor()}";
                          showError.value = true;
                        });

                        // } else if (int.parse(val) <
                        //     widget.plan.productPlan!.minTransactionLimit!
                        //         .floor()) {
                        //   setState(() {
                        //     error =
                        //         "Minimum amount connot be below ${widget.plan.productPlan!.minTransactionLimit!.floor()}";
                        //     showError.value = true;
                        //   });
                      } else {
                        setState(() {
                          error = "";
                          showError.value = false;
                        });
                      }
                    }
                  },
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Select a new tenor",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonFormField2<ProductTenor>(
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
                        "",
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: _tenor.map((item) {
                        // dropdownValue = item;

                        return DropdownMenuItem<ProductTenor>(
                          value: item,
                          child: Text(
                            item.tenorName != null ? "${item.tenorName}" : "",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      // value: dropdownValue,
                      validator: (value) =>
                          value == null ? 'Field cannot be empty!' : null,
                      onChanged: (val) {
                        setState(() {
                          productTenor = null;
                          investment = null;
                          print("productTenor");
                          productTenor = val;
                          selectProduct = val!.tenorName!;
                        });
                        getInvestmentRate(widget.plan.interestReceiptOption);
                      })),
              const SizedBox(height: 20),
              fullrollover || partialrollover
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Interest rate",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat"),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 8),
              fullrollover || partialrollover
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AppInputField(
                        controller: calculatedIntrest,
                        enabled: false,
                        textInputType: TextInputType.phone,
                        hintText: "0.00",
                        validator:
                            RequiredValidator(errorText: 'This is required'),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
                child: Appbutton(
                  onTap: () {
                    double withholding =
                        calIntrest! * withholdingTax!.rate! / 100;
                    widget.plan.planSummary!.calculatedInterest =
                        double.parse(calculatedIntrest.text);
                    widget.plan.planSummary!.withholdingTax = withholding;
                    widget.plan.planSummary!.paymentMaturity =
                        double.parse(maturityValue!);
                    widget.plan.actualMaturityDate = DateTime.now()
                        .add(Duration(days: productTenor!.tenorDays!));
                    if (rolloverKey.currentState!.validate()) {
                      if (partialrollover && fullrollover) {
                        return;
                      } else {
                        if (partialrollover) {
                          Navigator.pushNamed(
                              context, AppRouter.rolloversummary,
                              arguments: {
                                "rollover": "partialrollover",
                                "user": widget.role,
                                "plan": widget.plan,
                                "tenorId": productTenor!.id,
                                "amount": amount.text
                              });
                        } else {
                          Navigator.pushNamed(
                              context, AppRouter.rolloversummary,
                              arguments: {
                                "rollover": "fullrollover",
                                "user": widget.role,
                                "plan": widget.plan,
                                "amount": amount.text
                              });
                        }
                      }
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
}
