import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/model/request_model/bank_request.dart';
import 'package:rosabon/model/request_model/verify_account_request.dart';
import 'package:rosabon/model/response_models/bank_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/bank_dropdown.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class MyBankDetailsScreen extends StatefulWidget {
  const MyBankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MyBankDetailsScreen> createState() => _MyBankDetailsScreenState();
}

class _MyBankDetailsScreenState extends State<MyBankDetailsScreen> {
  var bankKey = GlobalKey<FormState>();
  var acctkeyName = GlobalKey<FormState>();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  var acctName = TextEditingController();
  final acctNumber = TextEditingController();
  bool veryPhone = false;
  bool enabledText = false;
  bool initLoading = false;
  String bankName = "";
  String bankCode = "";
  String bankId = "";
  String pin = "";

  late BankBloc bankBloc;

  List<Banks> banks = [];

  @override
  void initState() {
    bankBloc = BankBloc();
    bankBloc.add(const FetchBankAccount());
    bankBloc.add(const FetchBanks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
          ]),
          child: AppBar(
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
            title: const Text("My Bank Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: BlocListener<BankBloc, BankState>(
        bloc: bankBloc,
        listener: (context, state) {
          if (state is FetchBankLoading) {
            setState(() {
              initLoading = true;
            });
          }
          if (state is VerifyAccountLoading) {
            acctName.text = "Loading...";
          }
          if (state is FetchAccountSuccess) {
            setState(() {
              bankName = state.bankAccountResponse.bank!.name!;
              acctNumber.text = state.bankAccountResponse.accountNumber!;
              acctName.text = state.bankAccountResponse.accountName!;
            });
          }
          if (state is FetchBankSuccess) {
            setState(() {
              initLoading = false;
            });
            banks = state.banksResponse.data!;
          }
          if (state is OtpSuccess) {}
          if (state is OtpError) {
            setState(() {
              initLoading = false;
            });
            Navigator.pop(context);
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
          if (state is VerifyAccountSuccess) {
            acctName.text = state.verifyAccountResponse.account!.accountName!;
            PopMessage().displayPopup(
                context: context,
                text: "Bank Account Verified",
                type: PopupType.success);
          }
          if (state is BankLoading) {
            isLoading.value = true;
          }
          if (state is BankSavedSuccess) {
            isLoading.value = false;
            setState(() {
              enabledText = !enabledText;
            });
          }
          if (state is BankSavedError) {
            isLoading.value = false;
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
          if (state is VerifyAccountError) {
            acctName.text = "";
            setState(() {
              veryPhone = !veryPhone;
            });
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
        },
        child: initLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(height: 4.h),
                          Form(
                            key: bankKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Bank",
                                  style: TextStyle(
                                      color: Theme.of(context).dividerColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(height: 1.h),
                                IgnorePointer(
                                  ignoring: !enabledText,
                                  child: BankDropDown(
                                      onChanged: (Banks? val) {
                                        bankName = val!.name!;
                                        bankCode = val.code!;
                                      },
                                      dropdownValue: "",
                                      hintText: bankName,
                                      items: banks),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Account Number",
                                  style: TextStyle(
                                      color: Theme.of(context).dividerColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Montserrat"),
                                ),
                                const SizedBox(height: 8),
                                AppInputField(
                                  controller: acctNumber,
                                  hintText: "",
                                  enabled: enabledText,
                                  textInputType: TextInputType.phone,
                                  validator: RequiredValidator(
                                      errorText: "Account number is required"),
                                ),
                                const SizedBox(height: 10),
                                enabledText
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Checkbox(
                                              value: veryPhone,
                                              onChanged: (bool? value) {
                                                if (bankKey.currentState!
                                                        .validate() &&
                                                    !veryPhone) {
                                                  bankBloc.add(VerifyAccount(
                                                      verifyAccountRequest:
                                                          VerifyAccountRequest(
                                                              accountNumber:
                                                                  acctNumber
                                                                      .text,
                                                              bankCode:
                                                                  bankCode,
                                                              verifyBusinessBankAccount:
                                                                  true)));
                                                }
                                                setState(() {
                                                  veryPhone = value!;
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                            "Verify Account Number",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Theme.of(context)
                                                    .dividerColor,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Form(
                              key: acctkeyName,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Name",
                                    style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat"),
                                  ),
                                  SizedBox(height: 1.h),
                                  AppInputField(
                                    controller: acctName,
                                    enabled: false,
                                    validator: RequiredValidator(
                                        errorText: "Please add acct number"),
                                    hintText: "",
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    enabledText
                        ? Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, bool val, _) {
                                    return Appbutton(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        if (bankKey.currentState!.validate() &&
                                            acctkeyName.currentState!
                                                .validate()) {
                                          var connectivityResult =
                                              await (Connectivity()
                                                  .checkConnectivity());
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            bankBloc.add(UpdateBankAccount(
                                                bankRequest: BankRequest(
                                                    bankCode: bankCode,
                                                    accountName: acctName.text,
                                                    accountNumber:
                                                        acctNumber.text,
                                                    otp: pin)));
                                          } else {
                                            PopMessage().displayPopup(
                                                context: context,
                                                text:
                                                    "Please check your internet",
                                                type: PopupType.failure);
                                          }
                                        }
                                      },
                                      buttonState: val
                                          ? AppButtonState.loading
                                          : AppButtonState.idle,
                                      title: "Save",
                                      textColor: Colors.white,
                                      backgroundColor: deepKoamaru,
                                    );
                                  }),
                              SizedBox(height: 2.h),
                              Appbutton(
                                onTap: () => Navigator.pop(context),
                                title: "Cancel",
                                outlineColor: deepKoamaru,
                                textColor: deepKoamaru,
                              )
                            ],
                          )
                        : ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (context, bool val, _) {
                              return Appbutton(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    bankBloc.add(const Otp());
                                    pinCode(
                                      context,
                                      "Enter OTP sent to your email.",
                                      enabledText,
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          // enabledText = value ?? false;

                                          enabledText =
                                              value["enabledText"] ?? false;
                                          pin = value["pin"] ?? '';
                                        });
                                      }
                                    });
                                  },
                                  buttonState: val
                                      ? AppButtonState.loading
                                      : AppButtonState.idle,
                                  title: "Edit",
                                  textColor: Colors.white,
                                  backgroundColor: deepKoamaru);
                            }),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
      ),
    );
  }
}
