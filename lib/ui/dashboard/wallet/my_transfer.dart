import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/product_response.dart';
import 'package:rosabon/model/response_models/walletplantransfer_request.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/plan_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class MyTransfer extends StatefulWidget {
  const MyTransfer({Key? key}) : super(key: key);

  @override
  State<MyTransfer> createState() => _MyTransferState();
}

class _MyTransferState extends State<MyTransfer> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final amount = TextEditingController();
  final form = GlobalKey<FormState>();
  // final reasonforwithdrawal = TextEditingController();

  String selectReason = "others";
  int? productId;
  int? planId;
  List<Plan> items = [];

  late CreatePlanBloc createPlanBloc;
  late WalletBloc walletBloc;

  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    walletBloc = WalletBloc();
    createPlanBloc.add(const FetchEligiblePlan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Transfer"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<CreatePlanBloc, CreatePlanState>(
                    bloc: createPlanBloc,
                    listener: (context, state) {
                      print(state);
                      if (state is PlanEligibleSuccessful) {
                        // print(state.planResponse.plans!);
                        setState(() {
                          items = state.planResponse.plans!;
                        });
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PaymentSuccess(
                      //       subTitle: "Your transfer was successful",
                      //       btnTitle: "Ok",
                      //       callback: () => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => Dashboard(page: 3),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    }),
                BlocListener<WalletBloc, WalletState>(
                    bloc: walletBloc,
                    listener: (context, state) {
                      if (state is WithdrawalLoading) {
                        setState(() {
                          isLoading.value = true;
                        });
                      }
                      if (state is WalletTransferSuccess) {
                        setState(() {
                          isLoading.value = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentSuccess(
                              subTitle: "Your transfer was successful",
                              btnTitle: "Ok",
                              callback: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(page: 3),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is WalletTransferError) {
                        PopMessage().displayPopup(
                            context: context,
                            text: state.error,
                            type: PopupType.failure);
                      }
                    })
              ],
              child: Form(
                key: form,
                child: ListView(
                  children: [
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available Balance :",
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Montserrat"),
                        ),
                        Text(
                          "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: double.parse(map.toString())).output.nonSymbol}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Transfer Amount",
                      style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10.sp,
                          fontFamily: "Montserrat"),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: amount,
                      // enabled: enabledText,
                      textInputType: TextInputType.phone,
                      hintText: "₦ 0.00",
                      validator:
                          RequiredValidator(errorText: 'This is required'),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Beneficiary account",
                      style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 10.sp,
                          fontFamily: "Montserrat"),
                    ),
                    SizedBox(height: 1.h),
                    PlanDropDown(
                        onChanged: (Plan? val) {
                          setState(() {
                            planId = val!.id!;
                          });
                        },
                        dropdownValue: "",
                        hintText: "",
                        items: items),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Appbutton(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (form.currentState!.validate()) {
                                  walletBloc.add(WalletTransfer(
                                      walletPlanTransferRequest:
                                          WalletPlanTransferRequest(
                                              amount: int.parse(amount.text),
                                              description:
                                                  "just want to transfer.",
                                              planId: planId)));
                                }
                              },
                              buttonState: val
                                  ? AppButtonState.loading
                                  : AppButtonState.idle,
                              backgroundColor: deepKoamaru,
                              textColor: Colors.white,
                              title: "Submit");
                        }),
                    SizedBox(height: 2.h),
                    Appbutton(
                      onTap: (() => Navigator.pop(context)),
                      title: "Cancel",
                      outlineColor: deepKoamaru,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ProductDropDown extends StatelessWidget {
  final String? dropdownValue;
  final ValueChanged<Item?> onChanged;
  final Color? dropIconColor;
  final Color? hintTextColor;
  final List<Item>? items;
  @required
  final String hintText;

  const ProductDropDown(
      {Key? key,
      required this.onChanged,
      required this.dropdownValue,
      required this.hintText,
      this.dropIconColor,
      this.hintTextColor,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<Item>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
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
      items: items!
          .map((item) => DropdownMenuItem<Item>(
                value: item,
                child: Text(
                  item.productName.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      // value: dropdownValue!.isNotEmpty ? dropdownValue : null,
      validator: (value) => value == null ? 'Field cannot be empty!' : null,
      onChanged: onChanged,
    );
  }
}
