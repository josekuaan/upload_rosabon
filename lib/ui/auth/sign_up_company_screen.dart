import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rosabon/bloc/auth/signup/signup_bloc.dart';
import 'package:rosabon/model/request_model/register_token_request.dart';
import 'package:rosabon/model/request_model/sign_up_request.dart';
import 'package:rosabon/model/response_models/source_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/source_dropdown.dart';
import 'package:sizer/sizer.dart';

class SignUpCompanyScreen extends StatefulWidget {
  const SignUpCompanyScreen({Key? key}) : super(key: key);

  @override
  State<SignUpCompanyScreen> createState() => _SignUpCompanyScreenState();
}

class _SignUpCompanyScreenState extends State<SignUpCompanyScreen> {
  late SignupBloc signupBloc;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> terms = ValueNotifier(false);
  final ValueNotifier<bool> isError = ValueNotifier(false);
  var signupKey = GlobalKey<FormState>();
  var companyName = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();

  var password = TextEditingController();
  var cPassword = TextEditingController();
  var referalCode = TextEditingController();
  var sourceName = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8,
        errorText:
            'Your password must contain at least one \nuppercase, one lowercase, a special character, \nand must be at least 8 characters'),
    PatternValidator(r'^(?=.*[A-Z])(?=.*[a-z])',
        errorText:
            'Your password must contain at least one \nuppercase, one lowercase, a special character, \nand must be at least 8 characters'),
    PatternValidator(r'^(?=.*?[#?!@$%^&*-])',
        errorText:
            'Your password must contain at least one \nuppercase, one lowercase, a special character, \nand must be at least 8 characters'),
  ]);
  final emailValidator = MultiValidator([
    RequiredValidator(
        errorText: 'Email is required, please provide a valid email'),
    EmailValidator(errorText: 'Email is invalid, please enter a valid email')
  ]);
  final companyValidator = RequiredValidator(
      errorText: 'Company name is required,please provide company name');

  final List<dynamic> referal = [
    {"name": "Another user"},
    {"name": "Rosabon sales executive"},
    {"name": "Others"}
  ];
  List<Source> source = [];
  String initialval = "Another user";
  String mobileNumber = "";
  bool isNewsLetters = false;
  bool termAndAgreement = false;
  bool check = true;
  bool isAssisted = false;
  String error = "";
  int? sourceOthersId;
  @override
  void initState() {
    signupBloc = SignupBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          child: BlocListener<SignupBloc, SignupState>(
            bloc: signupBloc,
            listener: (context, state) {
              if (state is SignupLoading) {
                isLoading.value = true;
              }
              if (state is SignupSuccess) {
                isLoading.value = false;
                FirebaseMessaging.instance.getToken().then((token) {
                  signupBloc.add(RequesterTokn(
                      registerTokenRequest: RegisterTokenRequest(
                          device: SessionManager().userDeviceVal,
                          token: token,
                          userId: state.signUpReponse.id)));
                });
                Navigator.pushNamed(context, AppRouter.regSuccess);
              }

              if (state is SourceSuccess) {
                setState(() {
                  source = state.sourceResponse.sources!;
                });
              }
              if (state is SignupError) {
                isLoading.value = false;
                PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure);
              }
            },
            child: Form(
              key: signupKey,
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Company Name",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 8),
                  AppInputField(
                      controller: companyName,
                      hintText: "Optisoft Tchnologies",
                      validator: companyValidator),
                  const SizedBox(height: 20),
                  Text(
                    "Contact Person First Name",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 8),
                  AppInputField(
                    controller: firstName,
                    hintText: "Enter First Name",
                    validator: RequiredValidator(
                        errorText:
                            'First name is required, please provide first name'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Contact Person Last Name",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 8),
                  AppInputField(
                    controller: lastName,
                    hintText: "Enter First Name",
                    validator: RequiredValidator(
                        errorText:
                            'Last name is required, please provide last name'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Contact Person Email Address",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 8),
                  AppInputField(
                      controller: email,
                      hintText: "youremail@gmail.com",
                      validator: emailValidator),
                  const SizedBox(height: 20),
                  Text(
                    "Phone Number",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: error.isEmpty
                                ? Theme.of(context).dividerColor
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(5)),
                    child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          mobileNumber = number.phoneNumber!;
                        },
                        hintText: "07076345642",
                        maxLength: 11,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN,
                        ),
                        inputBorder: InputBorder.none,
                        keyboardType: TextInputType.phone,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        // textFieldController: mobileNumber,
                        formatInput: false,
                        inputDecoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 15)),
                        validator: (val) {
                          if (mobileNumber.isEmpty) {
                            setState(() {
                              error = 'Please Enter your phone number';
                            });
                            return;
                          }
                          if (val!.length != 11) {
                            setState(() {
                              error = 'Phone Number is not complete';
                            });
                          }
                          return null;
                        }),
                  ),
                  SizedBox(height: 1.w),
                  Text(
                    "Enter your mobile number without the first zero",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        fontFamily: "Montserrat"),
                  ),
                  SizedBox(height: 1.w),
                  ValueListenableBuilder(
                      valueListenable: isError,
                      builder: (context, bool val, _) {
                        return Visibility(
                            visible: val,
                            child: Text(
                              error,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontFamily: "Montserrat",
                                  overflow: TextOverflow.ellipsis),
                            ));
                      }),
                  SizedBox(height: 2.h),
                  Text(
                    "Password",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  SizedBox(height: 1.h),
                  AppPasswordInputField(
                    controller: password,
                    hintText: "*********",
                    // onChange: (val) => password.text = val,
                    validator: passwordValidator,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  SizedBox(height: 1.h),
                  AppPasswordInputField(
                      controller: cPassword,
                      validator: (val) =>
                          MatchValidator(errorText: 'Passwords do not match')
                              .validateMatch(cPassword.text, password.text),
                      hintText: "********"),
                  SizedBox(height: 2.h),
                  Text(
                    "How did you hear about us",
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat"),
                  ),
                  SizedBox(height: 1.h),
                  AppDropDown(
                      onChanged: (val) {
                        setState(() {
                          if (val! == "Rosabon sales executive") {
                            initialval = "ROSABON_SALES";
                          }
                          if (val == "Another user") {
                            initialval = "ANOTHER_USER";
                          }
                          if (val == "Others") {
                            signupBloc.add(const FetchSource());
                            initialval = "OTHER";
                          }
                        });
                      },
                      dropdownValue: "",
                      hintText: "",
                      items: referal),
                  SizedBox(height: 2.h),
                  initialval == "OTHER"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Source Name",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontFamily: "Montserrat"),
                            ),
                            const SizedBox(height: 8),
                            SourceDropDown(
                                onChanged: (val) {
                                  setState(() {
                                    sourceOthersId = val!.id!;
                                  });
                                },
                                dropdownValue: "",
                                hintText: "Enter Source Name",
                                items: source),
                          ],
                        )
                      // validator: RequiredValidator(
                      //             errorText:
                      //                 'Source Name is required,please input source name'),

                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: referalCode,
                              validator: RequiredValidator(
                                  errorText: 'Referral code is required'),
                              onChanged: (String val) {},
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Input referral code",
                                prefix: const Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                hintStyle: const TextStyle(
                                    color: silverChalic,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 15),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: 2.h),
                  sourceOthersId == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Source Name",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontFamily: "Montserrat"),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: sourceName,
                              validator: RequiredValidator(
                                  errorText:
                                      'Source name is required, please input source name'),
                              onChanged: (String val) {},
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Source Name",
                                // prefix: const Text(
                                //   "*",
                                //   style: TextStyle(color: Colors.red),
                                // ),
                                hintStyle: const TextStyle(
                                    color: silverChalic,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).dividerColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 15),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: isNewsLetters,
                            onChanged: (bool? value) {
                              setState(() {
                                isNewsLetters = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            "Yes, I want to receive newsletters of Promos and Offers",
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: termAndAgreement,
                            onChanged: (bool? value) {
                              setState(() {
                                termAndAgreement = value!;
                                check = value;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        SizedBox(
                          width: 80.w,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).dividerColor,
                                    fontFamily: "Montserrat")),
                            TextSpan(
                              text: 'Terms',
                              style: TextStyle(
                                  color: deepKoamaru,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            TextSpan(
                              text: ' and',
                              style: TextStyle(
                                  color: dustyGray,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            TextSpan(
                              text: ' Privacy Policy',
                              style: TextStyle(
                                  color: deepKoamaru,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                          ])),
                        ),
                      ],
                    ),
                  ),
                  check
                      ? Container()
                      : const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Kindly agree to the terms before you continue",
                            style: TextStyle(
                              color: redOrange,
                              fontFamily: "Montserrat",
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                  SizedBox(height: 2.h),
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, bool val, _) {
                        return Appbutton(
                            onTap: () async {
                              FocusScope.of(context).unfocus();

                              if (error.isNotEmpty || mobileNumber.isEmpty) {
                                setState(() {
                                  isError.value = true;
                                  error = "";
                                });
                              }
                              if (signupKey.currentState!.validate()) {
                                if (!termAndAgreement) {
                                  check = !check;
                                  return;
                                }
                                // if (mobileNumber.length < 8) {
                                //   setState(() {
                                //     isError.value = true;
                                //     error =
                                //         ' Please provide a correct phone number ';
                                //   });
                                //   return;
                                // }
                                setState(() {
                                  isError.value = false;
                                  error = "";
                                  if (check && termAndAgreement) {
                                  } else {
                                    check = false;
                                    termAndAgreement = true;
                                  }
                                });
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  signupBloc.add(
                                    SignuUp(
                                      signUpRequest: SignUpRequest(
                                        password: password.text,
                                        phone: mobileNumber.split("+")[1],
                                        role: "COMPANY",
                                        source: initialval,
                                        sourceOthersId: sourceOthersId == 0
                                            ? null
                                            : sourceOthersId,
                                        sourceNotInTheList: sourceOthersId == 0
                                            ? sourceName.text
                                            : null,
                                        refferedBy: initialval != "OTHER"
                                            ? referalCode.text
                                            : "",
                                        email: email.text,
                                        usage: "TREASURY",
                                        isAssited: isAssisted,
                                        isNewsLetters: isNewsLetters,
                                        company: Company(
                                          contactFirstName: firstName.text,
                                          contactLastName: lastName.text,
                                          contactMiddleName: "",
                                          name: companyName.text,
                                        ),
                                      ),
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
                            title: "Sign up",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru);
                      }),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Montserrat"),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRouter.login,
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
