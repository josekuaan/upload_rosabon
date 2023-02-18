import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/changePassword/change_password_bloc.dart';
import 'package:rosabon/model/request_model/forgot_password_request.dart';
import 'package:rosabon/model/request_model/reset_password.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ChangePasswordBloc _changePasswordBloc;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  var resetPasswordKey = GlobalKey<FormState>();
  var password = TextEditingController();
  var cPassword = TextEditingController();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8,
        errorText: 'Password must be at least 8 characters long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Password must meet requirement above')
  ]);
  @override
  void initState() {
    _changePasswordBloc = ChangePasswordBloc();
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
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        bloc: _changePasswordBloc,
        listener: (context, state) {
          if (state is ChangePasswordLoading) {
            isLoading.value = true;
          }
          if (state is ChangePasswordSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(
              context,
              AppRouter.pResetSuccess,
            );
            PopMessage().displayPopup(
                context: context,
                text: "Password Successfully changed",
                type: PopupType.success);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: resetPasswordKey,
            child: ListView(
              children: [
                const Text(
                  "Reset password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 40),
                const Text(
                    "Your password should include at least 8 characters and should include a combination of  Upper-case, Lowercase and special characters .",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat")),
                const SizedBox(height: 35),
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
                  controller: password,
                  hintText: "*********",
                  // onChange: (val) => password = val,
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
                    validator: (val) =>
                        MatchValidator(errorText: 'Passwords do not match')
                            .validateMatch(cPassword.text, password.text),
                    hintText: "********"),
                const SizedBox(height: 70),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (resetPasswordKey.currentState!.validate()) {
                              _changePasswordBloc.add(ResetPassword(
                                  resetPasswordRequest: ResetPasswordRequest(
                                      newPassword: password.text,
                                      email: SessionManager().userEmailVal,
                                      confirmPassword: cPassword.text)));
                            }
                          },
                          buttonState: val
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                          title: "Reset Password",
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
