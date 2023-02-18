import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rosabon/bloc/auth/nextOfKin/nextofkin_bloc.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class NextofKinDetails extends StatefulWidget {
  const NextofKinDetails({Key? key}) : super(key: key);

  @override
  State<NextofKinDetails> createState() => _NextofKinDetailsState();
}

class _NextofKinDetailsState extends State<NextofKinDetails> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  var nextKey = GlobalKey<FormState>();
  var mobileNumber = TextEditingController();
  var nextofKinName = TextEditingController();
  var nextofKinAddresss = TextEditingController();
  var nextofKinEmail = TextEditingController();
  late NextofkinBloc nextofkinBloc;
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final emailValidator = MultiValidator([
    RequiredValidator(
        errorText: 'Email is required, please provide a valid email'),
    EmailValidator(errorText: 'Email is invalid, please enter a valid email')
  ]);
  bool enabledText = false;
  @override
  void initState() {
    nextofkinBloc = NextofkinBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;

    mobileNumber.text = user.individualUser!.nokDetail == null
        ? ""
        : user.individualUser!.nokDetail!.phone!;
    nextofKinName.text = (user.individualUser!.nokDetail == null
        ? ""
        : user.individualUser!.nokDetail!.name)!;
    nextofKinAddresss.text = user.individualUser!.nokDetail != null
        ? user.individualUser!.nokDetail!.address.toString() != null.toString()
            ? user.individualUser!.nokDetail!.address!
            : ""
        : "";
    nextofKinEmail.text = (user.individualUser!.nokDetail == null
        ? ""
        : user.individualUser!.nokDetail!.email)!;
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
            title: const Text("Next of Kin Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: BlocListener<NextofkinBloc, NextofkinState>(
        bloc: nextofkinBloc,
        listener: (context, state) {
          if (state is NextOfKinLoading) {
            isLoading.value = true;
          }
          if (state is FetchNextOfKinSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(context, AppRouter.personalinfo,
                arguments: SessionManager().userRoleVal);
            PopMessage().displayPopup(
                context: context,
                text: "Next of kin's details Successfully saved",
                type: PopupType.success);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: nextKey,
                  child: ListView(
                    children: [
                      Text(
                        "Next of Kin’s Name",
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppInputField(
                        controller: nextofKinName,
                        hintText: "",
                        enabled: enabledText,
                        validator: RequiredValidator(
                            errorText: 'Next of kin name is required'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Next of Kin’s Address",
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppInputField(
                        controller: nextofKinAddresss,
                        hintText: "",
                        enabled: enabledText,
                        validator: RequiredValidator(
                            errorText: 'Next of kin address is required'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Next of Kin’s Email",
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppInputField(
                          controller: nextofKinEmail,
                          hintText: "",
                          enabled: enabledText,
                          validator: emailValidator),
                      SizedBox(height: 2.h),
                      Text(
                        "Next of Kin’s Phone Number",
                        style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(5)),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {},
                          isEnabled: enabledText,
                          hintText: "07076345642",
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                          ),
                          inputBorder: InputBorder.none,

                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: mobileNumber,
                          formatInput: false,
                          keyboardType: TextInputType.phone,
                          initialValue: number,
                          inputDecoration: const InputDecoration(
                              // enabled: enabledText,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15)),
                          // onSaved: (PhoneNumber number) {
                          //   print('On Saved: $number');
                          // },

                          validator: RequiredValidator(
                              errorText: 'Phone number is required'),
                        ),
                      ),
                      SizedBox(height: 2.h),
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
                        if (enabledText) {
                          if (nextKey.currentState!.validate()) {
                            // FocusScope.of(context).unfocus();
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              nextofkinBloc.add(NextOfKin(
                                PersonalInformationRequest(
                                  address: null,
                                  countryId: null,
                                  employmentDetail: null,
                                  lgaId: null,
                                  secondaryPhone: null,
                                  stateId: null,
                                  nokDetail: NokDetail(
                                      nokAddress: nextofKinAddresss.text,
                                      email: nextofKinEmail.text,
                                      name: nextofKinName.text,
                                      phone: mobileNumber.text),
                                ),
                              ));
                            } else {
                              PopMessage().displayPopup(
                                  context: context,
                                  text: "Please check your internet",
                                  type: PopupType.failure);
                            }
                          }
                        } else {
                          setState(() {
                            enabledText = !enabledText;
                          });
                        }
                      },
                      buttonState:
                          val ? AppButtonState.loading : AppButtonState.idle,
                      title: enabledText ? "Save" : "Edit",
                      textColor: Colors.white,
                      backgroundColor: deepKoamaru,
                    );
                  }),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
