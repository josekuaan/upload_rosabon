import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/forgotPassword/forgot_password_bloc.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late ForgotPasswordBloc forgotPasswordBloc;
  var forgotpasswordKey = GlobalKey<FormState>();
  var email = TextEditingController();
  @override
  void initState() {
    forgotPasswordBloc = ForgotPasswordBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          bloc: forgotPasswordBloc,
          listener: (context, state) {
            if (state is ForgotPasswordLoading) {
              isLoading.value = true;
            }
            if (state is ForgotPasswordSuccess) {
              isLoading.value = false;

              PopMessage().displayPopup(
                  context: context,
                  text: state.forgotPasswordResponse.message,
                  type: PopupType.success);
              Navigator.pushNamed(
                context,
                AppRouter.pResetSuccess,
              );
              // Future.delayed(
              //     const Duration(seconds: 3),
              //     () => Navigator.pushNamed(
              //           context,
              //           AppRouter.resetPassword,
              //         ));
            }
            if (state is ForgotPasswordError) {
              isLoading.value = false;
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
          },
          child: Form(
            key: forgotpasswordKey,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat"),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Please, enter your email address. You will receive a link to create a new password via email.",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  "Email Address",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: email,
                  hintText: "hr@gmail.com",
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText:
                            'Email is required, please provide a valid email'),
                    EmailValidator(errorText: 'Not a valid email address'),
                  ]),
                ),
                const SizedBox(height: 70),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (forgotpasswordKey.currentState!.validate()) {
                              forgotPasswordBloc.add(
                                ForgotPassword(
                                  forgotPasswordRequest:
                                      ForgotPasswordRequest(email: email.text.trim()),
                                ),
                              );
                              
                            }
                            email.text = "";
                          },
                          buttonState: val
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                          title: "Send",
                          textColor: Colors.white,
                          backgroundColor: deepKoamaru);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
