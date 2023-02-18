import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/login/login_bloc.dart';
import 'package:rosabon/bloc/auth/signup/signup_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/login_request.dart';
import 'package:rosabon/model/request_model/register_token_request.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SessionManager _sessionManager = SessionManager();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late LoginBloc loginBloc;
  late SignupBloc signupBloc;
  UserBloc userBloc = UserBloc();
  var loginKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8,
        errorText: 'Password must be at least 8 characters long'),
    PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])$',
        errorText:
            'Passwords must have at least one  special \n character, one upper case and one lowercase')
  ]);

  @override
  void initState() {
    loginBloc = LoginBloc();
    signupBloc = SignupBloc();
    super.initState();
  }

  bool staySignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(),

        // IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocListener<LoginBloc, LoginState>(
          bloc: loginBloc,
          listener: (context, state) {
            if (state is Loginloading) {
              isLoading.value = true;
            }
            if (state is LoginError) {
              isLoading.value = false;

              password.text = "";
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
            if (state is LoginSuccess) {
              isLoading.value = false;
              userBloc.add(FetchUser(name: email.text));
              FirebaseMessaging.instance.getToken().then((token) {
                signupBloc.add(RequesterTokn(
                    registerTokenRequest: RegisterTokenRequest(
                        device: SessionManager().userDeviceVal,
                        token: token,
                        userId: SessionManager().userIdVal)));
              });

              email.text = "";
              password.text = "";
              if (_sessionManager.userRoleVal == "INDIVIDUAL_USER") {
                if (_sessionManager.isKycVal) {
                  if (state.loginResponse.resetPassword == false &&
                      state.loginResponse.creationSource == "BACKEND") {
                    Navigator.pushNamed(context, AppRouter.resetPassword);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRouter.dashboard, (context) => false);
                  }
                  // Navigator.pushNamed(context, AppRouter.personalKyc);

                } else {
                  Navigator.pushNamed(context, AppRouter.personalKyc);
                }
              } else {
                if (_sessionManager.isKycVal) {
                  if (state.loginResponse.resetPassword == false &&
                      state.loginResponse.creationSource == "BACKEND") {
                    Navigator.pushNamed(context, AppRouter.resetPassword);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRouter.dashboard, (context) => false);
                  }
                } else {
                  Navigator.pushNamed(context, AppRouter.companyKyc);
                }
              }
              PopMessage().displayPopup(
                  context: context,
                  text: "Login Successful",
                  type: PopupType.success);
            }
          },
          child: Form(
            key: loginKey,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat"),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Email Address",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: email,
                  hintText: "hr@gmail.com",
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText:
                            'Email is required, please provide a valid email'),
                    EmailValidator(
                        errorText:
                            'Email is invalid, please provide a valid email'),
                  ]),
                ),
                const SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppPasswordInputField(
                  controller: password,
                  hintText: "*********",
                  validator:
                      RequiredValidator(errorText: 'Password is required'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: staySignedIn,
                              onChanged: (bool? value) {
                                setState(() {
                                  staySignedIn = value!;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Stay signed in",
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRouter.forgotPassword),
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 12,
                              color: deepKoamaru,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (loginKey.currentState!.validate()) {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                loginBloc.add(
                                  Login(
                                    loginrequest: Loginrequest(
                                        email: email.text.toString().trim(),
                                        password: password.text,
                                        platformType: "MOBILE",
                                        platform: "TREASURY"),
                                  ),
                                );
                              } else {
                                PopMessage().displayPopup(
                                    context: context,
                                    text: "Please check your internet",
                                    type: PopupType.failure);
                              }
                            }
                          },
                          buttonState: val
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                          title: "Login",
                          textColor: Colors.white,
                          backgroundColor: deepKoamaru);
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat"),
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.onboarding),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: deepKoamaru,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
