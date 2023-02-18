import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rosabon/bloc/auth/companyKyc/company_kyc_bloc.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/kyc_request.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/date_picker.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class CompanyUpdate extends StatefulWidget {
  const CompanyUpdate({Key? key}) : super(key: key);

  @override
  State<CompanyUpdate> createState() => _CompanyUpdateState();
}

class _CompanyUpdateState extends State<CompanyUpdate>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isLoading1 = ValueNotifier(false);
  ValueNotifier<bool> isLoading2 = ValueNotifier(false);
  final SessionManager _sessionManager = SessionManager();
  var form1key = GlobalKey<FormState>();
  var form2key = GlobalKey<FormState>();
  var companyName = TextEditingController();
  var companyRCNumber = TextEditingController();

  var companyAddress = TextEditingController();

  var companyBusinessType = TextEditingController();
  var contactPersonFirstName = TextEditingController();
  var contactPersonLastName = TextEditingController();
  var contactPersonEmail = TextEditingController();
  var contactPersonMobileNumber = TextEditingController();
  var date = TextEditingController();
  late TabController _tabcontroller;
  late CompanyKycBloc companyKycBloc;
  UserBloc userBloc = UserBloc();

  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final List _list = [
    {"name": "Sole proprietorship", "id": "1"},
    {"name": "Partnership", "id": "2"},
    {"name": "Corporate Limited", "id": "3"},
  ];

  String companyType = "";
  String? phone;
  String? page;
  CountryApiBloc countryApiBloc = CountryApiBloc();
  @override
  void initState() {
    companyName = TextEditingController(text: _sessionManager.companyNameVal);

    _tabcontroller = TabController(vsync: this, length: 2);
    companyKycBloc = CompanyKycBloc();
    // userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: deepKoamaru,
            elevation: 0,

            leading: Container(),
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.arrow_back_ios,
            //       color: Colors.black,
            //     )),
            leadingWidth: 25.0,
            centerTitle: false,
            titleSpacing: 0,
            title: const Text("Update KYC",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CompanyKycBloc, CompanyKycState>(
              bloc: companyKycBloc,
              listener: (context, state) {
                if (page == "dashboard") {
                  if (state is CompanyKycLoading) {
                    isLoading1.value = true;
                  }
                  if (state is CompanyKycSuccess) {
                    isLoading1.value = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(page: 1),
                        settings: RouteSettings(arguments: _sessionManager),
                      ),
                    );
                  }
                } else {
                  if (state is CompanyKycLoading) {
                    isLoading2.value = true;
                  }

                  if (state is CompanyKycSuccess) {
                    isLoading2.value = false;
                    Navigator.pushNamed(context, AppRouter.corprateinfo,
                        arguments: _sessionManager);
                  }
                }
                if (state is CompanyKycError) {
                  isLoading1.value = false;
                  isLoading2.value = false;
                  PopMessage().displayPopup(
                      context: context,
                      text: state.error,
                      type: PopupType.failure);
                }
              }),
        ],
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              const Text(
                "Kindly update your profile, it will only take a few minutes",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 20,
                width: 350,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: alto),
                  ),
                ),
                child: IgnorePointer(
                  child: TabBar(
                    controller: _tabcontroller,
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.5, color: mineShaft),
                        insets: EdgeInsets.only(right: 30.0, top: 20)),
                    labelColor: alto,
                    indicatorWeight: 4.0,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    onTap: (val) {},
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Tab(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Company Details",
                              style: TextStyle(
                                  color: mineShaft,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Tab(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Contact Person Details",
                              style: TextStyle(
                                  color: mineShaft,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabcontroller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Form(
                        key: form1key,
                        child: ListView(
                          children: [
                            Text(
                              "Company Name",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: companyName,
                              enabled: false,
                              hintText: _sessionManager.userFullNameVal,
                              // "Optisoft Technologies",
                              // validator: RequiredValidator(
                              //     errorText: 'This field is required'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Company RC Number",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: companyRCNumber,
                              hintText: "RC 01234-5678",
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Company Registration Date",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DatePicker(
                                controller: date,
                                hintText: "DD/MM/YYY",
                                validator: RequiredValidator(
                                    errorText:
                                        "Please Pick your Date of Birth")),
                            const SizedBox(height: 20),
                            Text(
                              "Company Address",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: companyAddress,
                              hintText: "10, Marina Lagos irland",
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Nature Of Business",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: companyBusinessType,
                              hintText: "",
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Company Type",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppDropDown(
                                onChanged: (dynamic val) {
                                  setState(() {
                                    companyType = val;
                                  });
                                },
                                dropdownValue: "",
                                hintText: '',
                                items: _list),
                            const SizedBox(height: 40),
                            Appbutton(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (form1key.currentState!.validate()) {
                                  setState(() {
                                    _tabcontroller.index = 1;
                                  });
                                }
                              },
                              title: "Next",
                              textColor: Colors.white,
                              backgroundColor: deepKoamaru,
                            ),
                            SizedBox(height: 2.h)
                          ],
                        ),
                      ),
                      Form(
                        key: form2key,
                        child: ListView(
                          children: [
                            Text(
                              "Contact Person First Name",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontFamily: "Montserrat"),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: contactPersonFirstName,
                              hintText: "John",
                              validator: RequiredValidator(
                                  errorText: 'First name is required'),
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
                              controller: contactPersonLastName,
                              hintText: "Doe",
                              validator: RequiredValidator(
                                  errorText: 'Last name is required'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Contact Person Email Address",
                              style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppInputField(
                              controller: contactPersonEmail,
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
                              "Contact Person Number",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontFamily: "Montserrat"),
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
                                onInputChanged: (PhoneNumber number) {
                                  phone = number.phoneNumber;
                                },
                                onInputValidated: (bool value) {},
                                hintText: "07076345642",
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DROPDOWN,
                                ),
                                inputBorder: InputBorder.none,
                                ignoreBlank: false,
                                maxLength: 10,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: contactPersonMobileNumber,
                                formatInput: false,
                                keyboardType: TextInputType.phone,
                                inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 15)),
                                validator: RequiredValidator(
                                    errorText: 'This field is required'),
                              ),
                            ),
                            const SizedBox(height: 40),
                            ValueListenableBuilder(
                                valueListenable: isLoading1,
                                builder: (context, bool val, _) {
                                  return Appbutton(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      if (form2key.currentState!.validate()) {
                                        page = "dashboard";
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        if (connectivityResult ==
                                                ConnectivityResult.mobile ||
                                            connectivityResult ==
                                                ConnectivityResult.wifi) {
                                          companyKycBloc.add(
                                            CompanyKyc(
                                              kycRequest: KycRequest(
                                                isAssited:
                                                    _sessionManager.assistedVal,
                                                isKyc: true,
                                                isNewsLetters: _sessionManager
                                                    .newsletterVal,
                                                phone: phone,
                                                role:
                                                    _sessionManager.userRoleVal,
                                                // source: _sessionManager.sourceVal,
                                                status: "ACTIVE",
                                                usage: "TREASURY",
                                                // sourceOthers: _sessionManager
                                                //     .sourceOthersVal,
                                                individualUser: null,
                                                company: Company(
                                                    contactFirstName:
                                                        contactPersonFirstName
                                                            .text,
                                                    contactLastName:
                                                        contactPersonLastName
                                                            .text,
                                                    contactMiddleName: "",
                                                    name: _sessionManager.userFullNameVal,
                                                    dateOfInco: date.text,
                                                    businessType: companyType ==
                                                            "Sole proprietorship"
                                                        ? "SOLE_PROPRIETORSHIP"
                                                        : companyType ==
                                                                "Corporate Limited"
                                                            ? "CORPORATE_LIMITED"
                                                            : "PARTNERSHIP",
                                                    natureOfBusiness:
                                                        companyBusinessType
                                                            .text,
                                                    rcNumber:
                                                        companyRCNumber.text,
                                                    companyAddress:
                                                        companyAddress.text),
                                              ),
                                            ),
                                          );
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
                                    title: "Save and invest now",
                                    backgroundColor: deepKoamaru,
                                    textColor: Colors.white,
                                  );
                                }),
                            // Appbutton(
                            //   onTap: () => Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Dashboard(page: 1),
                            //           settings: RouteSettings(
                            //               arguments: _sessionManager))),
                            //   title: "Save and invest now",
                            //   backgroundColor: deepKoamaru,
                            //   textColor: Colors.white,
                            // ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder(
                                valueListenable: isLoading2,
                                builder: (context, bool val, _) {
                                  return Appbutton(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      if (form2key.currentState!.validate()) {
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        if (connectivityResult ==
                                                ConnectivityResult.mobile ||
                                            connectivityResult ==
                                                ConnectivityResult.wifi) {
                                          companyKycBloc.add(
                                            CompanyKyc(
                                              kycRequest: KycRequest(
                                                isAssited:
                                                    _sessionManager.assistedVal,
                                                isKyc: true,
                                                isNewsLetters: _sessionManager
                                                    .newsletterVal,
                                                phone: phone,
                                                role:
                                                    _sessionManager.userRoleVal,
                                                // source: _sessionManager.sourceVal,
                                                status: "ACTIVE",
                                                usage: "TREASURY",
                                                // sourceOthers: _sessionManager
                                                //     .sourceOthersVal,
                                                individualUser: null,
                                                company: Company(
                                                    contactFirstName:
                                                        contactPersonFirstName
                                                            .text,
                                                    contactLastName:
                                                        contactPersonLastName
                                                            .text,
                                                    contactMiddleName: "",
                                                    name: companyName.text,
                                                    dateOfInco: date.text,
                                                    businessType: companyType,
                                                    natureOfBusiness:
                                                        companyBusinessType
                                                            .text,
                                                    rcNumber:
                                                        companyRCNumber.text,
                                                    companyAddress:
                                                        companyAddress.text),
                                              ),
                                            ),
                                          );
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
                                    title: "Save and Continue",
                                    outlineColor: deepKoamaru,
                                    textColor: deepKoamaru,
                                  );
                                }),
                            SizedBox(height: 2.h)
                          ],
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
