import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/employmentDetails/employment_details_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/response_models/country_response.dart';
import 'package:rosabon/model/response_models/state_response.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/country_dropdown.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class PersonalContactDetailScreen extends StatefulWidget {
  const PersonalContactDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalContactDetailScreen> createState() =>
      _PersonalContactDetailScreenState();
}

class _PersonalContactDetailScreenState
    extends State<PersonalContactDetailScreen> {
  final SessionManager _sessionManager = SessionManager();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  var contactKey = GlobalKey<FormState>();
  var mobileNumber = TextEditingController();
  var contactAddress = TextEditingController();
  var contactCity = TextEditingController();
  late EmploymentDetailsBloc employmentDetailsBloc;
  CountryApiBloc countryApiBloc = CountryApiBloc();
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  UserBloc userBloc = UserBloc();
  late BankBloc bankBloc;
  String? country;
  String stateinit = "";
  String pin = "";
  int? countryofResidenceId;
  int? nationalityId;
  int? stateId;
  String natioanlity = "";
  String countryOfres = "";
  List<Country> countries = [];
  List<StateRes> s = [];
  bool veryPhone = false;
  bool enabledText = false;
  @override
  void initState() {
    bankBloc = BankBloc();
    countryApiBloc.add(const Fetch(name: "country"));
    employmentDetailsBloc = EmploymentDetailsBloc();
    // userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;

    mobileNumber.text = user.phone ?? "";
    contactAddress.text = user.individualUser!.address != null
        ? user.individualUser!.address!.houseNoAddress ?? ""
        : "";

    setState(() {
      countryOfres = user.individualUser!.coutryOfResidence != null
          ? user.individualUser!.coutryOfResidence!.name!
          : "";
      country = user.individualUser!.address!.country != null
          ? user.individualUser!.address!.country!
          : "";
      natioanlity = user.individualUser!.address!.country != null
          ? user.individualUser!.address!.country!
          : "";

      stateinit = user.individualUser!.address != null
          ? user.individualUser!.address!.state ?? ""
          : "";
    });

    contactCity.text = user.individualUser!.address != null
        ? user.individualUser!.address!.city ?? ""
        : "";

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(
          title: "Contact Details",
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CountryApiBloc, CountryApiState>(
              bloc: countryApiBloc,
              listener: (context, state) {
                if (state is FetchSuccess) {
                  countries = state.countryResponse.countries!;
                }
                if (state is FetchStateSuccess) {
                  s = state.stateResponse.state!;
                }
              },
            ),
            BlocListener<EmploymentDetailsBloc, EmploymentDetailsState>(
              bloc: employmentDetailsBloc,
              listener: (context, state) {
                if (state is EmploymentLoading) {
                  isLoading.value = true;
                }
                if (state is EmploymentSuccess) {
                  isLoading.value = false;
                  Navigator.pushNamed(context, AppRouter.personalinfo,
                      arguments: _sessionManager.userRoleVal);
                  PopMessage().displayPopup(
                      context: context,
                      text: "Contact details Successfully saved",
                      type: PopupType.success);
                }
              },
            ),
            BlocListener<BankBloc, BankState>(
                bloc: bankBloc,
                listener: (context, state) {
                  if (state is PhoneVerified) {
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
                                                alignment:
                                                    Alignment.bottomRight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                          "Number verified successfully"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Appbutton(
                                        onTap: () {
                                          setState(() {
                                            veryPhone = true;
                                          });
                                          Navigator.pop(context);
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
                })
          ],
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: contactKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text(
                          "Secondary phone number",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        enabledText
                            ? Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                child: InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber number) {},
                                  onInputValidated: (bool value) {},
                                  initialValue: number,
                                  maxLength: 10,
                                  hintText: "7076345642",
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.DROPDOWN,
                                  ),
                                  inputBorder: InputBorder.none,
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle:
                                      const TextStyle(color: Colors.black),
                                  textFieldController: mobileNumber,
                                  formatInput: false,
                                  keyboardType: TextInputType.phone,
                                  inputDecoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15)),
                                  validator: RequiredValidator(
                                      errorText: 'This field is required'),
                                ),
                              )
                            : AppInputField(
                                controller: mobileNumber,
                                hintText: "+2344893836",
                                enabled: enabledText,
                                textInputType: TextInputType.phone,
                                validator: RequiredValidator(
                                    errorText: 'This field is required'),
                              ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Please provide your most active phone number here in case this is different from your primary phone number",
                            style: TextStyle(
                              color: Theme.of(context).dividerColor,
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: enabledText ? 10 : 0),
                        enabledText
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(
                                      value: veryPhone,
                                      onChanged: (bool? value) {
                                        bankBloc.add(ValidatePhone(
                                            personalInformationRequest:
                                                PersonalInformationRequest(
                                                    secondaryPhone:
                                                        mobileNumber.text)));
                                        pinCode(
                                                context,
                                                "Enter OTP sent to your phone number",
                                                enabledText)
                                            .then((value) {
                                          setState(() {
                                            enabledText = value;
                                          });
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Verify Phone Number",
                                    style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat"),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        Text(
                          "Country Of Residence",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        IgnorePointer(
                          ignoring: !enabledText,
                          child: CountryDropDown(
                              onChanged: (Country? val) {
                                setState(() {
                                  country = val!.name;
                                  countryofResidenceId = val.id;
                                  countryApiBloc
                                      .add(Fetch(name: "state", id: val.id));
                                });
                              },
                              dropdownValue: country,
                              hintText: countryOfres,
                              items: countries),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "State",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        IgnorePointer(
                          ignoring: !enabledText,
                          child: StateDropDown(
                              onChanged: (StateRes? val) {
                                setState(() {
                                  stateinit = val!.name!;
                                  stateId = val.id;
                                });
                              },
                              dropdownValue: stateinit,
                              hintText: stateinit,
                              items: s),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "City",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppInputField(
                          controller: contactCity,
                          hintText: "",
                          enabled: enabledText,
                          validator: RequiredValidator(
                              errorText: 'This field is required'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Nationality",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        IgnorePointer(
                          ignoring: !enabledText,
                          child: CountryDropDown(
                              onChanged: (Country? val) {
                                setState(() {
                                  country = val!.name!;
                                  nationalityId = val.id;
                                });
                              },
                              dropdownValue: country,
                              hintText: natioanlity,
                              items: countries),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Address",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppInputField(
                          controller: contactAddress,
                          hintText: "",
                          enabled: enabledText,
                          validator: RequiredValidator(
                              errorText: 'this field is required'),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
                enabledText
                    ? ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Appbutton(
                            onTap: () {
                              if (enabledText) {
                                if (contactKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  employmentDetailsBloc.add(SubmitDetails(
                                    PersonalInformationRequest(
                                      address: ContactAddress(
                                        city: contactCity.text,
                                        country: country,
                                        state: stateinit,
                                        houseNoAddress: contactAddress.text,
                                      ),
                                      countryId: nationalityId,
                                      lgaId: null,
                                      secondaryPhone: mobileNumber.text,
                                      stateId: null,
                                    ),
                                  ));
                                }
                              } else {
                                setState(() {
                                  enabledText = !enabledText;
                                });
                              }
                            },
                            buttonState: val
                                ? AppButtonState.loading
                                : AppButtonState.idle,
                            title: "Save",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru,
                          );
                        })
                    : ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Appbutton(
                              onTap: () {
                                userBloc.add(const GeneralOtp(
                                    message: "Edit Contact Details"));
                                pinCode(
                                        context,
                                        "Enter OTP sent to your email.",
                                        enabledText)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      enabledText =
                                          // value ?? false;
                                          value["enabledText"] ?? false;
                                      SessionManager().otpVal = value["pin"];
                                      pin = value["pin"];
                                    });
                                    bankBloc
                                        .add(ValidateOtp(otp: value["pin"]));
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
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
