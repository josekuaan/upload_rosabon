import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/changePassword/change_password_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordBloc changePasswordBloc;
  late UserBloc userBloc;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final resetPasswordKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  final cPassword = TextEditingController();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  @override
  void initState() {
    changePasswordBloc = ChangePasswordBloc();
    userBloc = UserBloc();
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
            title: const Text("Change Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        bloc: changePasswordBloc,
        listener: (context, state) {
          if (state is ChangePasswordLoading) {
            isLoading.value = true;
          }
          if (state is ChangePasswordSuccess) {
            isLoading.value = false;
            // Navigator.pop(context);
            showDialog(
                context: context,
                builder: (_) {
                  return Center(
                      child: Stack(children: [
                    AlertDialog(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: const Icon(
                          Icons.info,
                          color: deepKoamaru,
                          size: 50,
                        ),
                        content: SizedBox(
                          height: 180,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 30,
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
                                      top: 35,
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
                              const Text("Your Password has been updated"),
                              const Text("successfully."),
                              const SizedBox(
                                height: 20,
                              ),
                              Appbutton(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRouter.login, (route) => false);
                                  // Navigator.pop(context);
                                  // Navigator.pop(context);
                                },
                                title: "Continue",
                                textColor: Colors.white,
                                backgroundColor: deepKoamaru,
                              )
                            ],
                          ),
                        )),
                  ]));
                });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: resetPasswordKey,
                  child: ListView(
                    children: [
                      Text(
                        "Current Password",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat"),
                      ),
                      const SizedBox(height: 8),
                      AppPasswordInputField(
                        controller: currentPassword,
                        hintText: "*********",
                        // onChange: (val) => currentPassword = val,
                        validator: RequiredValidator(
                            errorText: 'Current password is required'),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "New Password",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat"),
                      ),
                      const SizedBox(height: 8),
                      AppPasswordInputField(
                        controller: newPassword,
                        hintText: "*********",
                        onChange: (val) => newPassword = val,
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat"),
                      ),
                      const SizedBox(height: 8),
                      AppPasswordInputField(
                          controller: cPassword,
                          validator: (val) => MatchValidator(
                                  errorText: 'Passwords do not match')
                              .validateMatch(cPassword.text, newPassword.text),
                          hintText: "********"),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, bool val, _) {
                    return Appbutton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (resetPasswordKey.currentState!.validate()) {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              userBloc.add(const GeneralOtp(
                                  message: "Password Change request"));
                              pinCode(context, "Enter OTP sent to your E-mail",
                                      true)
                                  .then((value) {
                                changePasswordBloc.add(
                                  ChangePassword(
                                    changePasswordRequest:
                                        ChangePasswordRequest(
                                            newPassword: newPassword.text,
                                            oldPassword: currentPassword.text,
                                            otp: value["pin"]),
                                  ),
                                );
                              });
                            } else {
                              PopMessage().displayPopup(
                                  context: context,
                                  text: "Please check your internet",
                                  type: PopupType.failure);
                            }
                          }
                        },
                        buttonState:
                            val ? AppButtonState.loading : AppButtonState.idle,
                        title: "Save",
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
