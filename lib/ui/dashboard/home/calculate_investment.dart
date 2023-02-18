import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/product/products_bloc.dart';
import 'package:rosabon/model/response_models/investmentrate_response.dart';
import 'package:rosabon/model/response_models/product_response.dart';
import 'package:rosabon/model/response_models/withholding_tax_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/investment_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class Investmentcalculator extends StatefulWidget {
  const Investmentcalculator({Key? key}) : super(key: key);

  @override
  State<Investmentcalculator> createState() => _InvestmentcalculatorState();
}

class _InvestmentcalculatorState extends State<Investmentcalculator> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> showError = ValueNotifier(false);
  final amounttoPlace = TextEditingController();
  final finalvalue = TextEditingController();
  final calculatedInterestRate = TextEditingController();
  late CreatePlanBloc createPlanBloc;
  late ProductsBloc productsBloc;
  String selectProduct = "Product 1";
  String maturityValue = "";
  String? error;
  // String tenor = "Product 1";
  int? tenorDay;
  List<Item> products = [];
  ProductTenor? singleTenor;
  List<ProductTenor>? tenors = [];
  Item? product;
  InvestmentValue? investment;
  List<InvestmentValue> investmentValue = [];
  WithholdingTaxResponse? withholdingTax;
  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    productsBloc = ProductsBloc();
    productsBloc.add(const FetchAllproducts());
    createPlanBloc.add(const FetchInvestment());
    createPlanBloc.add(const WithholdingrateRate());
    super.initState();
  }

  getInvestmentRate() {
    InvestmentValue? investRate = InvestmentValue();

    for (var el in investmentValue) {
      if (product!.id == el.product!.id &&
          int.parse(amounttoPlace.text) >=
              el.product!.minTransactionLimit!.floor() &&
          int.parse(amounttoPlace.text) <=
              el.product!.maxTransactionLimit!.floor() &&
          el.investmentCurrency!.name == "NGN") {
        print(el.maturityRate!);
        finalvalue.text = ((int.parse(amounttoPlace.text) *
                        el.maturityRate! *
                        tenorDay! /
                        365) /
                    100 +
                int.parse(amounttoPlace.text))
            .toStringAsFixed(2)
            .toString();
        return;
      } else {
        investRate = null;
      }
    }

    PopMessage().displayPopup(
        context: context,
        text: "Check the amount placed.",
        type: PopupType.failure);

    // interestRate = investRate.maturityRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Investment Calculator"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreatePlanBloc, CreatePlanState>(
            bloc: createPlanBloc,
            listener: (context, state) {
              if (state is InvestmentSuccessful) {
                // for (var el in state.investmentRateResponse.investmentValue!) {
                //   if (el.status == "ACTIVE") {
                //     investmentValue.add(el);
                //   }
                // }
                setState(() {
                  investmentValue =
                      state.investmentRateResponse.investmentValue!;
                });
              }

              if (state is WithholdingSuccessful) {
                setState(() {
                  withholdingTax = state.withholdingTaxResponse;
                });
              }
            },
          ),
          BlocListener<ProductsBloc, ProductsState>(
            bloc: productsBloc,
            listener: (context, state) {
              if (state is ProductSuccessful) {
                // for (var el in state.productResponse.items!) {
                //   if (el.status == "ACTIVE") {
                //     products.add(el);
                //   }
                // }
                setState(() {
                  products = state.productResponse.items!;
                });
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Select Product",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                ProductDropDown(
                    onChanged: (Item? val) {
                      for (var el in investmentValue) {
                        if (val!.id == el.product!.id) {
                          investment = el;
                          product = val;
                        }
                      }

                      setState(() {
                        tenors = [];
                      });

                      // setState(() {
                      //   product = val;
                      // });
                      tenors = val!.tenors ?? [];
                    },
                    dropdownValue: "",
                    hintText: "Select product",
                    items: products),
                const SizedBox(height: 20),
                Text(
                  "Select Tenor",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField2<ProductTenor>(
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
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: tenors!.map((item) {
                    singleTenor = item;

                    return DropdownMenuItem<ProductTenor>(
                      value: item,
                      child: Text(
                        item.tenorName != null ? "//${item.tenorName}" : "",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  // value: singleTenor,
                  validator: (value) =>
                      value == null ? 'Field cannot be empty!' : null,
                  onChanged: (ProductTenor? val) {
                    setState(() {
                      // tenor = val;
                      tenorDay = val!.tenorDays;
                      // allowCustomization = val!.allowCustomization!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Amount to be Placed",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: amounttoPlace,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: "₦ 0.00",
                  validator: RequiredValidator(errorText: 'This is required'),
                  onChange: (String val) {
                    if (val != "") {
                      if (int.parse(val) <
                          product!.minTransactionLimit!.floor()) {
                        setState(() {
                          error =
                              "Minimum amount connot be below ${product!.minTransactionLimit!.floor()}";
                          showError.value = true;
                        });
                      } else if (int.parse(val) >
                          product!.maxTransactionLimit!.floor()) {
                        setState(() {
                          error =
                              "Maximum amount connot be above ${product!.maxTransactionLimit!.floor()}";
                          showError.value = true;
                        });
                      } else {
                        setState(() {
                          error = "";
                          showError.value = false;
                        });
                      }
                    }
                  },
                ),
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
                const SizedBox(height: 40),
                Appbutton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      finalvalue.text = "";
                      if (product != null) {
                        getInvestmentRate();
                      }
                    }
                  },
                  title: "Calculate Amount at Maturity",
                  backgroundColor: deepKoamaru,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 60),
                AppInputField(
                  controller: finalvalue,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: "₦ 0.00",
                ),
                const SizedBox(height: 8),
                Text(
                  "Please note that this is an estimate and final value is subject to withholding tax",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
