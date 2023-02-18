import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/request_model/withdrawal_request.dart';
import 'package:rosabon/model/response_models/withdrawalReason_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_Withdrawal.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class CompanyWithdrawToBank extends StatefulWidget {
  const CompanyWithdrawToBank({Key? key}) : super(key: key);

  @override
  State<CompanyWithdrawToBank> createState() => _CompanyWithdrawToBankState();
}

class _CompanyWithdrawToBankState extends State<CompanyWithdrawToBank> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final amount = TextEditingController();
  final reasonforwithdrawal = TextEditingController();
  late WalletBloc walletBloc;

  String selectReason = "others";
  String selectbeneficiary = "";
  bool partialwithdraw = false;
  bool fullwithdraw = false;
  String? manifestBase64;
  int? withdrawalReasonId;
  List<WithdrawalReason>? withdrawalReason = [];

  File? manifestUpload;
  uploadmanefest() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        manifestUpload = File(pickedFile!.path);
        manifestBase64 = base64Encode(manifestUpload!.readAsBytesSync());
      });
    } catch (e) {
      print(e);
      setState(() {
        // error = e.toString();
      });
    }
  }

  @override
  void initState() {
    walletBloc = WalletBloc();
    walletBloc.add(const FetchWithdrawalReason());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Withdraw to  Bank"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocListener<WalletBloc, WalletState>(
          bloc: walletBloc,
          listener: (context, state) {
            if (state is WithdrawalReasonSuccess) {
              for (var el in state.withdrawalReasonResponse.withdrawalReason!) {
                if (el.status == "ACTIVE") {
                  withdrawalReason!.add(el);
                }
              }
              // withdrawalReason =
              //     state.withdrawalReasonResponse.withdrawalReason;
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
                     
                    ),
                  ),
                ),
              );
            }
            if (state is WithdrawalError) {
              setState(() {
                isLoading.value = false;
              });
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
          },
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
                    "₦ $map",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat"),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                "Withdrawal amount",
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
              AppDropDown(
                  onChanged: (dynamic val) {
                    setState(() {
                      selectbeneficiary = val!;
                    });
                  },
                  dropdownValue: "",
                  hintText: "Select beneficiary account",
                  items: const <dynamic>[
                    {"name": "To Bank"},
                  ]),
              SizedBox(height: 2.h),
              selectbeneficiary == "To Bank"
                  ? DottedBorder(
                      padding: const EdgeInsets.all(20),
                      borderType: BorderType.Rect,
                      radius: const Radius.circular(20),
                      color: gray,
                      strokeWidth: 0.3,
                      dashPattern: const [10, 5, 10, 5, 10, 5],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35.w,
                                child: Text(
                                  manifestUpload != null
                                      ? manifestUpload!.path.split("/").last
                                      : "Upload withdrawal mandate instruction",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "jpg, PDF. 2MB",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 8.sp,
                                  color: gray,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: uploadmanefest,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    color: alto,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Choose File",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 10.sp,
                                    color: gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          )
                        ],
                      ), //optional
                    )
                  : Container(),
              SizedBox(height: 1.h),
              selectbeneficiary == "To Bank"
                  ? Text(
                      "Letter must be on a company’s letter head and also carry bank account details",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 8.sp,
                        color: gray,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Container(),
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
                  hintText: "Seslect reason for withdrawal",
                  items: withdrawalReason),
              SizedBox(height: 2.h),
              selectReason == "Others"
                  ? AppInputField(
                      controller: amount,
                      hintText: "Please provide reason for withdrawal",
                      validator:
                          RequiredValidator(errorText: 'This is required'),
                      maxLines: 4,
                    )
                  : Container(),
              SizedBox(height: 20.h),
              Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, bool val, _) {
                        return Appbutton(
                          onTap: () {
                            walletBloc.add(WithdrawNow(
                                withdrawalRequest: WithdrawalRequest(
                                    bankAccountId: null,
                                    withdrawalAmount: int.parse(amount.text),
                                    withdrawalInstructionImage:
                                        WithdrawalInstructionImage(
                                            encodedUpload: manifestBase64,
                                            name: "mandate"),
                                    withdrawalMandateLetterImage:
                                        WithdrawalMandateLetterImage(
                                            encodedUpload: manifestBase64,
                                            name: "mandate"),
                                    withdrawalReasonId: withdrawalReasonId,
                                    withdrawalReasonOthers: "")));
                          },
                          title: "Submit",
                          buttonState: val
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                          backgroundColor: deepKoamaru,
                          textColor: Colors.white,
                        );
                      }),
                  const SizedBox(height: 20),
                  Appbutton(
                    onTap: (() => Navigator.pop(context)),
                    title: "Cancel",
                    outlineColor: deepKoamaru,
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
