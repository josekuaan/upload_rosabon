import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/request_model/withdrawal_request.dart';
import 'package:rosabon/model/response_models/withdrawalReason_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_Withdrawal.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class WalletToBank extends StatefulWidget {
  const WalletToBank({Key? key}) : super(key: key);

  @override
  State<WalletToBank> createState() => _WalletToBankState();
}

class _WalletToBankState extends State<WalletToBank> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final form = GlobalKey<FormState>();
  final amount = TextEditingController();
  final reasonforwithdrawal = TextEditingController();
  late BankBloc bankBloc;
  late WalletBloc walletBloc;

  String selectReason = "";
  int? accountId;
  bool partialwithdraw = false;
  bool fullwithdraw = false;
  String bankName = "";
  String bankCode = "";
  String bankId = "";

  List<Map<String, dynamic>> account = [];
  int? withdrawalReasonId;
  List<WithdrawalReason>? withdrawalReason = [];
  @override
  void initState() {
    bankBloc = BankBloc();
    walletBloc = WalletBloc();
    walletBloc.add(const FetchWithdrawalReason());
    bankBloc.add(const FetchBankAccount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Withdraw to  Bank"),
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
                setState(() {
                  // withdrawalReason =
                  //     state.withdrawalReasonResponse.withdrawalReason;
                });
              }
              if (state is WithdrawalLoading) {
                setState(() {
                  isLoading.value = true;
                });
              }
              if (state is WithdrawalSuccess) {
                setState(() {
                  isLoading.value = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccess(
                        subTitle: "Withdrawal Requested Successfully",
                        btnTitle: "Ok",
                        callback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(page: 3),
                              ),
                            )),
                  ),
                );
              }
              if (state is WithdrawalError) {
                setState(() {
                  isLoading.value = false;
                });
                PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure);
              }
            },
          ),
          BlocListener<BankBloc, BankState>(
            bloc: bankBloc,
            listener: (context, state) {
              if (state is FetchBankLoading) {
                // setState(() {
                //   initLoading = true;
                // });
              }

              if (state is FetchAccountSuccess) {
                var data = <String, dynamic>{};

                data.addAll({
                  "number": state.bankAccountResponse.accountNumber,
                  "id": state.bankAccountResponse.id,
                  "bankName": state.bankAccountResponse.bank!.name
                });
                setState(() {
                  account.add(data);
                });
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: form,
            child: ListView(
              children: [
                SizedBox(height: 4.h),
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
                  "Withdrawal amount",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: amount,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: "₦ 0.00",
                  validator: RequiredValidator(errorText: 'This is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Beneficiary account",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontSize: 10.sp,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(height: 1.h),
                DropdownButtonFormField2<dynamic>(
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
                  // hint: Text(
                  //   hintText,
                  //   style: const TextStyle(fontSize: 14),
                  // ),
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
                  items: account
                      .map((item) => DropdownMenuItem<dynamic>(
                            value: item,
                            child: Text(
                              "${item["bankName"]}-${item["number"]}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  // value: ,
                  validator: (value) =>
                      value == null ? 'Field cannot be empty!' : null,
                  onChanged: (dynamic val) {
                    setState(() {
                      accountId = val["id"];
                    });
                  },
                ),

                // SizedBox(height: 2.h),
                // Text(
                //   "Letter must be on a company’s letter head and also carry bank account details",
                //   style: TextStyle(
                //     fontFamily: "Montserrat",
                //     fontSize: 10.sp,
                //     color: gray,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                SizedBox(height: 2.h),
                Text(
                  "Reason for withdrawal",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontSize: 10.sp,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(height: 1.h),
                AppWithdrawal(
                  onChanged: (WithdrawalReason? val) {
                    setState(() {
                      selectReason = val!.reason!;
                      withdrawalReasonId = val.id;
                    });
                  },
                  dropdownValue: "",
                  hintText: "Select reason for withdrawal",
                  items: withdrawalReason,
                ),
                SizedBox(height: 2.h),
                selectReason == "Others"
                    ? AppInputField(
                        controller: amount,
                        hintText: "Please provide reason for withdrawal",
                        // validator:
                        //     RequiredValidator(errorText: 'This is required'),
                        maxLines: 4,
                      )
                    : Container(),
                selectReason == "Others"
                    ? SizedBox(height: 3.h)
                    : SizedBox(height: 12.h),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                        onTap: () {
                          if (form.currentState!.validate()) {
                            walletBloc.add(WithdrawNow(
                                withdrawalRequest: WithdrawalRequest(
                                    bankAccountId: accountId,
                                    withdrawalAmount: int.parse(amount.text),
                                    withdrawalInstructionImage: null,
                                    withdrawalMandateLetterImage: null,
                                    withdrawalReasonId: withdrawalReasonId,
                                    withdrawalReasonOthers: "")));
                          }
                        },
                        title: "Submit",
                        buttonState:
                            val ? AppButtonState.loading : AppButtonState.idle,
                        backgroundColor: deepKoamaru,
                        textColor: Colors.white,
                      );
                    }),

                SizedBox(height: 2.h),
                Appbutton(
                  onTap: (() => Navigator.pop(context)),
                  title: "Cancel",
                  outlineColor: deepKoamaru,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
