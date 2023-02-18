import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rosabon/bloc/auth/bvn/bvn_bloc.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/kyc/kyc_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/bvn_request.dart';
import 'package:rosabon/model/request_model/kyc_request.dart';
import 'package:rosabon/model/request_model/updateBvnName.dart';
import 'package:rosabon/model/response_models/country_response.dart';
import 'package:rosabon/model/response_models/gender_response.dart';
import 'package:rosabon/model/response_models/state_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/country_dropdown.dart';
import 'package:rosabon/ui/widgets/date_picker.dart';
import 'package:rosabon/ui/widgets/gender_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/success.dart';
import 'package:sizer/sizer.dart';

class KycUpdate extends StatefulWidget {
  const KycUpdate({Key? key}) : super(key: key);

  @override
  State<KycUpdate> createState() => _KycUpdateState();
}

class _KycUpdateState extends State<KycUpdate>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isLoading1 = ValueNotifier(false);
  ValueNotifier<bool> isLoading2 = ValueNotifier(false);
  final SessionManager _sessionManager = SessionManager();
  var kyc1 = GlobalKey<FormState>();
  var kyc2 = GlobalKey<FormState>();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var middleName = TextEditingController();
  var address = TextEditingController();
  var city = TextEditingController();
  var email = TextEditingController();
  var mobileNumber = TextEditingController();
  var bvnNumber = TextEditingController();
  var date = TextEditingController();
  late KycBloc kycBloc;
  CountryApiBloc countryApiBloc = CountryApiBloc();
  UserBloc userBloc = UserBloc();
  late BvnBloc bvnBloc;
  List<Country> countries = [];
  List<StateRes> s = [];

  late TabController _tabcontroller;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  List<Gender> gender = [];
  String next = "";
  int? genderId;
  String countryofResidence = "";
  String state = "";
  String nationality = "";
  int? countryofResidenceId;
  int? nationalityId;
  int? stateId;
  bool enabledText = false;
  bool initLoad = false;
  @override
  void initState() {
    bvnBloc = BvnBloc();
    kycBloc = KycBloc();

    _tabcontroller = TabController(vsync: this, length: 2);
    kycBloc.add(const FetchGender());
    userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
    countryApiBloc.add(const Fetch(name: "country"));
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: concreteLight,
                  offset: Offset(0, 2.0),
                  blurRadius: 24.0)
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
            BlocListener<KycBloc, KycState>(
              bloc: kycBloc,
              listener: (context, state) {
                if (next == "dashboard") {
                  if (state is KycLoading) {
                    isLoading1.value = true;
                  }
                  if (state is KycSuccess) {
                    isLoading1.value = false;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(page: 1),
                        settings: RouteSettings(
                            arguments: _sessionManager.userRoleVal),
                      ),
                    );
                  }
                } else {
                  if (state is KycLoading) {
                    isLoading2.value = true;
                  }
                  if (state is KycSuccess) {
                    isLoading2.value = false;
                    Navigator.pushNamed(context, AppRouter.personalinfo,
                        arguments: _sessionManager.userRoleVal);
                  }
                }
                if (state is GenderSuccess) {
                  setState((() {
                    gender = state.genderResponse.gender!;
                  }));
                }
                if (state is KycError) {
                  isLoading.value = false;
                  PopMessage().displayPopup(
                      context: context,
                      text: state.error,
                      type: PopupType.failure);
                }
              },
            ),
            BlocListener<CountryApiBloc, CountryApiState>(
              bloc: countryApiBloc,
              listener: (context, state) {
                if (state is FetchSuccess) {
                  setState(() {
                    countries = state.countryResponse.countries!;
                  });
                }
                if (state is FetchStateSuccess) {
                  setState(() {
                    s = state.stateResponse.state!;
                  });
                }
              },
            ),
            BlocListener<BvnBloc, BvnState>(
              bloc: bvnBloc,
              listener: (context, state) {
                if (state is BvnLoading) {
                  isLoading.value = true;
                }
                if (state is BvnSuccess) {
                  showAlertBox(context,
                      "${state.bvnResponse.data!.lastName} ${state.bvnResponse.data!.firstName}");
                  if (_sessionManager.firstNameVal !=
                          state.bvnResponse.data!.firstName ||
                      _sessionManager.lastNameVal !=
                          state.bvnResponse.data!.lastName) {
                    setState(() {
                      lastName.text = state.bvnResponse.data!.lastName!;
                      firstName.text = state.bvnResponse.data!.firstName!;
                      _sessionManager.firstNameVal =
                          state.bvnResponse.data!.firstName!;
                      _sessionManager.lastNameVal =
                          state.bvnResponse.data!.lastName!;
                    });

                    isLoading.value = false;
                  }
                }
                // setState(() {
                //   _tabcontroller.index = 1;
                // });
                if (state is BvnError) {
                  PopMessage().displayPopup(
                      context: context,
                      text: state.error,
                      type: PopupType.failure);
                  isLoading.value = false;
                }
              },
            ),
            BlocListener<UserBloc, UserState>(
                bloc: userBloc,
                listener: (context, state) {
                  print(state);
                  if (state is UserLoading) {
                    setState(() {
                      initLoad = true;
                    });
                  }
                  if (state is FetchUserSuccess) {
                    setState(() {
                      initLoad = false;
                      firstName.text = _sessionManager.firstNameVal;
                      lastName.text = _sessionManager.lastNameVal;
                      email.text = _sessionManager.userEmailVal;
                      mobileNumber.text =
                          "0${_sessionManager.phoneVal.split("234")[1]}";
                    });
                  }
                })
          ],
          child: initLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    right: 24,
                    left: 24,
                    top: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Kindly update your profile, it will only take a few minutes",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.7.h,
                        width: 90.w,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: alto),
                          ),
                        ),
                        child: IgnorePointer(
                          child: TabBar(
                            controller: _tabcontroller,
                            // unselectedLabelColor: Colors.red,
                            // isScrollable: true,
                            // indicatorSize: TabBarIndicatorSize.label,
                            indicator: const UnderlineTabIndicator(
                                borderSide:
                                    BorderSide(width: 2.5, color: mineShaft),
                                insets: EdgeInsets.only(right: 40.0, top: 20)),
                            labelColor: alto,
                            indicatorWeight: 4.0,
                            // indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1.0),
                                child: Tab(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Personal  Details",
                                      style: TextStyle(
                                          color: mineShaft,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1.0),
                                child: Tab(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Contact Details",
                                      style: TextStyle(
                                          color: mineShaft,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: TabBarView(
                            controller: _tabcontroller,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Form(
                                key: kyc1,
                                child: ListView(
                                  children: [
                                    Text(
                                      "First Name",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AppInputField(
                                      controller: firstName,
                                      enabled: enabledText,
                                      hintText: "Enter First Name",
                                      // validator: RequiredValidator(
                                      //     errorText: 'First name is required'),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Middle Name",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AppInputField(
                                      controller: middleName,
                                      hintText: "Enter Middle Name",
                                      // validator: RequiredValidator(
                                      //     errorText: 'this field is required'),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Last Name",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AppInputField(
                                      controller: lastName,
                                      enabled: enabledText,
                                      hintText: "Enter Last Name",
                                      // validator: RequiredValidator(
                                      //     errorText: 'Last name is required'),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    GenderDropDown(
                                        onChanged: (val) {
                                          setState(() {
                                            genderId = val!.id!;
                                          });
                                        },
                                        dropdownValue: "",
                                        hintText: 'Select Your Gender',
                                        items: gender),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Date of Birth",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    DatePicker(
                                        controller: date,
                                        hintText: "DD-MM-YYY",
                                        validator: RequiredValidator(
                                            errorText:
                                                "Please Pick your Date of Birth")),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Primary phone number",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    AppInputField(
                                      controller: mobileNumber,
                                      hintText: "",
                                      textInputType: TextInputType.phone,
                                      maxLength: 11,
                                      validator: RequiredValidator(
                                          errorText:
                                              'Phone number is required'),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      "Please provide the phone number tied to your BVN",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "BVN",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Montserrat"),
                                    ),
                                    SizedBox(height: 1.h),
                                    AppInputField(
                                      controller: bvnNumber,
                                      hintText: "22244893836",
                                      maxLength: 11,
                                      textInputType: TextInputType.phone,
                                      validator: RequiredValidator(
                                          errorText: 'BVN is Required'),
                                    ),
                                    SizedBox(height: 4.h),
                                    ValueListenableBuilder(
                                        valueListenable: isLoading,
                                        builder: (context, bool val, _) {
                                          return Appbutton(
                                            onTap: () async {
                                              var connectivityResult =
                                                  await (Connectivity()
                                                      .checkConnectivity());
                                              if (kyc1.currentState!
                                                  .validate()) {
                                                if (connectivityResult ==
                                                        ConnectivityResult
                                                            .mobile ||
                                                    connectivityResult ==
                                                        ConnectivityResult
                                                            .wifi) {
                                                  bvnBloc.add(BVN(
                                                      bvnRequest: BvnRequest(
                                                          id: bvnNumber.text,
                                                          firstName:
                                                              firstName.text,
                                                          lastName:
                                                              lastName.text,
                                                          phoneNumber:
                                                              mobileNumber.text,
                                                          dateOfBirth: date.text
                                                              .split("-")
                                                              .reversed
                                                              .join("-"),
                                                          isSubjectConsent:
                                                              true)));
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
                                            title: "Verify BVN",
                                            textColor: Colors.white,
                                            backgroundColor: deepKoamaru,
                                          );
                                        }),
                                    SizedBox(height: 1.h),
                                  ],
                                ),
                              ),
                              Form(
                                key: kyc2,
                                child: ListView(
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    AppInputField(
                                      controller: email,
                                      enabled: enabledText,
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
                                      "Country of Residence",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    CountryDropDown(
                                        onChanged: (Country? val) {
                                          setState(() {
                                            countryofResidence = val!.name!;
                                            countryofResidenceId = val.id;
                                            countryApiBloc.add(const Fetch(
                                                name: "state", id: 1));
                                          });
                                        },
                                        dropdownValue: "",
                                        hintText: '',
                                        items: countries),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Contact Address",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppInputField(
                                      controller: address,
                                      // enabled: enabledText,
                                      hintText: "10,Victor bamiro Street",
                                      validator: RequiredValidator(
                                          errorText:
                                              'Contact address is required'),
                                    ),
                                    countryofResidence == "Nigeria"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  "State",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .dividerColor,
                                                      fontFamily: "Montserrat"),
                                                ),
                                                const SizedBox(height: 8),
                                                StateDropDown(
                                                    onChanged: (StateRes? val) {
                                                      setState(() {
                                                        state = val!.name!;
                                                        stateId = val.id;
                                                      });
                                                    },
                                                    dropdownValue: "",
                                                    hintText: '',
                                                    items: s),
                                              ])
                                        : Container(),
                                    const SizedBox(height: 20),
                                    Text(
                                      "City",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    AppInputField(
                                      controller: city,
                                      hintText: "Yaba",
                                      validator: RequiredValidator(
                                          errorText: 'City is required'),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Nationality",
                                      style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontFamily: "Montserrat"),
                                    ),
                                    const SizedBox(height: 8),
                                    CountryDropDown(
                                        onChanged: (Country? val) {
                                          setState(() {
                                            nationality = val!.name!;
                                            nationalityId = val.id;
                                          });
                                        },
                                        dropdownValue: "",
                                        hintText: '',
                                        items: countries),
                                    const SizedBox(height: 40),
                                    ValueListenableBuilder(
                                        valueListenable: isLoading1,
                                        builder: (context, bool val, _) {
                                          return Appbutton(
                                            onTap: () async {
                                              next = "dashboard";
                                              if (kyc2.currentState!
                                                  .validate()) {
                                                DateTime currentDate =
                                                    DateTime.now();
                                                DateTime dob =
                                                    DateFormat("dd-MM-yyyy")
                                                        .parse(date.text);

                                                if ((currentDate.year -
                                                        dob.year) <
                                                    18) {
                                                  PopMessage().displayPopup(
                                                      context: context,
                                                      text:
                                                          "Only 18 years and above can use this app.",
                                                      type: PopupType.failure);
                                                  return;
                                                }
                                                var connectivityResult =
                                                    await (Connectivity()
                                                        .checkConnectivity());
                                                if (connectivityResult ==
                                                        ConnectivityResult
                                                            .mobile ||
                                                    connectivityResult ==
                                                        ConnectivityResult
                                                            .wifi) {
                                                  kycBloc.add(
                                                    Kyc(
                                                      kycRequest: KycRequest(
                                                          isAssited:
                                                              _sessionManager
                                                                  .assistedVal,
                                                          isKyc: true,
                                                          isNewsLetters:
                                                              _sessionManager
                                                                  .newsletterVal,
                                                          phone:
                                                              mobileNumber.text,
                                                          role: _sessionManager
                                                              .userRoleVal,
                                                          // source:
                                                          //     _sessionManager.sourceVal,
                                                          status:
                                                              _sessionManager
                                                                  .statusVal,
                                                          usage: "TREASURY",
                                                          // sourceOthers: _sessionManager
                                                          //     .sourceOthersVal,
                                                          individualUser:
                                                              IndividualUser(
                                                            genderId: genderId,
                                                            firstName:
                                                                firstName.text,
                                                            lastName:
                                                                lastName.text,
                                                            middleName:
                                                                middleName.text,
                                                            dateOfBirth:
                                                                date.text,
                                                            coutryOfResidence:
                                                                CoutryOfResidence(
                                                                    name:
                                                                        countryofResidence,
                                                                    id: countryofResidenceId),
                                                            contactAddress: Address(
                                                                country:
                                                                    countryofResidence,
                                                                state: state,
                                                                id: 0,
                                                                city: city.text,
                                                                houseNoAddress:
                                                                    address
                                                                        .text,
                                                                postCode: ""),
                                                            bvn: bvnNumber.text,
                                                          ),
                                                          company: null),
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
                                            title: "Save and invest now",
                                            backgroundColor: deepKoamaru,
                                            textColor: Colors.white,
                                          );
                                        }),
                                    const SizedBox(height: 20),
                                    ValueListenableBuilder(
                                        valueListenable: isLoading2,
                                        builder: (context, bool val, _) {
                                          return Appbutton(
                                            onTap: () async {
                                              if (kyc2.currentState!
                                                  .validate()) {
                                                DateTime currentDate =
                                                    DateTime.now();
                                                DateTime dob =
                                                    DateFormat("dd-MM-yyyy")
                                                        .parse(date.text);

                                                if ((currentDate.year -
                                                        dob.year) <
                                                    18) {
                                                  PopMessage().displayPopup(
                                                      context: context,
                                                      text:
                                                          "Only 18 years and above can use this app.",
                                                      type: PopupType.failure);
                                                  return;
                                                }
                                                var connectivityResult =
                                                    await (Connectivity()
                                                        .checkConnectivity());
                                                if (connectivityResult ==
                                                        ConnectivityResult
                                                            .mobile ||
                                                    connectivityResult ==
                                                        ConnectivityResult
                                                            .wifi) {
                                                  kycBloc.add(
                                                    Kyc(
                                                      kycRequest: KycRequest(
                                                          isAssited:
                                                              _sessionManager
                                                                  .loggedInVal,
                                                          isKyc: true,
                                                          isNewsLetters:
                                                              _sessionManager
                                                                  .loggedInVal,
                                                          phone:
                                                              mobileNumber.text,
                                                          role: _sessionManager
                                                              .userRoleVal,
                                                          source: _sessionManager
                                                              .sourceVal,
                                                          status: "ACTIVE",
                                                          usage: "TREASURY",
                                                          sourceOthers:
                                                              _sessionManager
                                                                  .sourceOthersVal,
                                                          individualUser:
                                                              IndividualUser(
                                                            genderId: genderId,
                                                            firstName:
                                                                _sessionManager
                                                                    .firstNameVal,
                                                            lastName:
                                                                _sessionManager
                                                                    .lastNameVal,
                                                            middleName:
                                                                middleName.text,
                                                            dateOfBirth:
                                                                date.text,
                                                            coutryOfResidence:
                                                                CoutryOfResidence(
                                                                    name:
                                                                        countryofResidence,
                                                                    id: countryofResidenceId),
                                                            contactAddress: Address(
                                                                city: city.text,
                                                                country:
                                                                    countryofResidence,
                                                                state: state,
                                                                id: 0,
                                                                houseNoAddress:
                                                                    address
                                                                        .text,
                                                                postCode: ""),
                                                            bvn: bvnNumber.text,
                                                          ),
                                                          company: null),
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
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              )
                            ]),
                      ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<dynamic> showAlertBox(BuildContext context, String? name) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 12),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                height: 270,
                child: Column(
                  children: [
                    const Icon(Icons.info, color: deepKoamaru, size: 50),
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
                            height: 70,
                            width: 70,
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
                    const Text(
                      "Your name on our system will be updated",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat"),
                    ),
                    Row(children: [
                      const Text("with ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat")),
                      Text(name ?? "",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat")),
                      const Text(" to reflect exactly as",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat")),
                    ]),
                    const Text(" it appears on your BVN",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat")),
                    const SizedBox(
                      height: 30,
                    ),
                    Appbutton(
                      onTap: () {
                        Navigator.pop(context);
                        // bvnBloc.add(UpdateBvnName(
                        //     updateBvnNameRequest: UpdateBvnNameRequest(
                        //       firstName: firstName,lastName: lastName
                        //     )));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => Success(
                              title: "SUCCESS",
                              subTitle: "BVN validation successful",
                              btnTitle: "Continue",
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            _tabcontroller.index = 1;
                          });
                        });
                      },
                      title: "Ok",
                      textColor: Colors.white,
                      backgroundColor: deepKoamaru,
                    )
                  ],
                ),
              ));
        });
  }
}
// 22270745423