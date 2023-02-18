import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/director/director_bloc.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';

Future<dynamic> pinCode(
  BuildContext context,
  String text,
  bool enabledText,
) {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  String pin = "";
  String Cpin = "";
  String isError = "";
  bool resending = false;
  var pinCotroller = TextEditingController();

  BankBloc bankBloc = BankBloc();
  late DirectorBloc directorBloc = DirectorBloc();
  return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiBlocListener(
            listeners: [
              BlocListener<BankBloc, BankState>(
                bloc: bankBloc,
                listener: (context, state) {
                  if (state is OtpLoading) {
                    setState(() {
                      isLoading.value = true;
                      resending = true;
                    });
                  }
                  if (state is OtpSuccess) {
                    setState(() {
                      isLoading.value = false;
                      resending = false;
                    });
                    Navigator.pop(context, {"enabledText": true, "pin": pin});
                  }
                  if (state is OtpError) {
                    setState(() {
                      isLoading.value = false;
                      resending = false;
                    });
                    isError = state.error;
                  }
                },
              ),
              // BlocListener<DirectorBloc, DirectorState>(
              //   bloc: directorBloc,
              //   listener: (context, state) {
              //     if (state is OtpLoading) {
              //       setState(() {
              //         isLoading.value = true;
              //         resending = true;
              //       });
              //     }
              //     if (state is OtpRecieved) {
              //       setState(() {
              //         isLoading.value = false;
              //         resending = false;
              //         Cpin = state.baseResponse.message;
              //       });
              //       Navigator.pop(context, {"enabledText": true, "pin": pin});
              //     }
              //     if (state is DirectorError) {
              //       setState(() {
              //         isLoading.value = false;
              //         resending = false;
              //       });
              //       isError = state.error;
              //     }
              //   },
              // )
            ],
            child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close,
                            color: deepKoamaru, size: 30))),
                titlePadding: EdgeInsets.zero,
                content: SizedBox(
                  height: 310,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.info,
                        color: deepKoamaru,
                        size: 50,
                      ),
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
                              height: 30,
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
                        width: 300,
                        child: Center(
                          child: Text(
                            text,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      PinCodeTextField(
                        appContext: context,
                        controller: pinCotroller,
                        length: 5,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        pinTheme: PinTheme.defaults(
                            fieldWidth: 50,
                            inactiveColor: alto,
                            activeColor: alto,
                            borderRadius: BorderRadius.circular(5),
                            shape: PinCodeFieldShape.box),
                        keyboardType: TextInputType.phone,
                        validator: RequiredValidator(
                            errorText: "Enter your One Time Password"),
                        onChanged: (String val) {
                          setState(() {
                            pin = val;
                          });
                        },
                        textStyle: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        isError,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn’t get an OTP? ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat"),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                resending = true;
                                // enabledText = false;
                              });

                              // bankBloc.add(const Otp());
                            },
                            child: Text(
                              resending ? "Resending" : "Resend",
                              style: const TextStyle(
                                  color: deepKoamaru,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, bool val, _) {
                            return Appbutton(
                              onTap: () {
                                if (pin.isEmpty || pin.length < 5) {
                                  setState(() {
                                    isError = "Enter your One Time Password";
                                  });
                                } else {
                                  if (SessionManager().otpVal != pin) {
                                    setState(() {
                                      isError = "Please enter a valid otp";
                                    });
                                  } else {
                                    setState(() {
                                      enabledText = true;
                                    });
                                    isError = "";
                                    // otpbloc:
                                    // otpBloc;
                                    bankBloc.add(ValidateOtp(otp: pin));
                                  }
                                }
                              },
                              buttonState: val
                                  ? AppButtonState.loading
                                  : AppButtonState.idle,
                              title: "Ok",
                              textColor: Colors.white,
                              backgroundColor: deepKoamaru,
                            );
                          })
                    ],
                  ),
                )),
          );
        });
      });
}
