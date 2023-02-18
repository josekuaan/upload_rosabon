import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/date_picker.dart';

class PersonalInfoDetailScreen extends StatefulWidget {
  const PersonalInfoDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoDetailScreen> createState() =>
      _PersonalInfoDetailScreenState();
}

class _PersonalInfoDetailScreenState extends State<PersonalInfoDetailScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  // final SessionManager _sessionManager = SessionManager();
  var personalKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var middleName = TextEditingController();
  var address = TextEditingController();
  var email = TextEditingController();
  var mobileNumber = TextEditingController();
  var bvnNumber = TextEditingController();
  var customerId = TextEditingController();
  var date = TextEditingController();
  UserBloc userBloc = UserBloc();
  final genderGroup = <dynamic>[
    {"name": "Male"},
    {"name": "Female"}
  ];
  String initialval = "";
  bool enableText = false;

  @override
  void initState() {
    // userBloc.add(FetchUser(name: _sessionManager.userEmailVal));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;
    isLoading.value = false;
    // user = state.userResponse;
    firstName.text =
        user.individualUser != null ? user.individualUser!.firstName! : '';
    lastName.text =
        user.individualUser != null ? user.individualUser!.lastName! : '';
    middleName.text = user.individualUser != null
        ? user.individualUser!.middleName.toString()
        : "";
    setState(() {
      initialval = user.individualUser!.gender!.gender ?? "";
    });
    date.text = user.individualUser!.dateOfBirth ?? "";
    mobileNumber.text = user.phone ?? "";
    email.text = user.email ?? "";
    bvnNumber.text = user.individualUser!.bvn ?? "";
    customerId.text = user.individualUser!.id.toString();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
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
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              leadingWidth: 48.0,
              centerTitle: false,
              titleSpacing: 0,
              title: const Text("Personal Details",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: personalKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  "First Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: firstName,
                  enabled: enableText,
                  hintText: "Ifeanyi",
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Middle Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: middleName,
                  enabled: enableText,
                  hintText: "",
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Last Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: lastName,
                  enabled: enableText,
                  hintText: "Ukachukwu",
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Gender",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                IgnorePointer(
                  ignoring: !enableText,
                  child: AppDropDown(
                      onChanged: (dynamic val) {
                        setState(() {
                          initialval = user.individualUser!.gender!.gender!;
                          // val["name"]
                          ;
                        });
                      },
                      dropdownValue: initialval == "MALE"
                          ? "Male"
                          : initialval == "FEMALE"
                              ? "Female"
                              : "",
                      hintText: initialval,
                      items: genderGroup),
                ),
                const SizedBox(height: 20),
                Text(
                  "Date of Birth",
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
                    enableText: enableText,
                    hintText: "DD/MM/YYY",
                    validator: RequiredValidator(
                        errorText: "Please Pick your Date of Birth")),
                const SizedBox(height: 20),
                Text(
                  "Primary phone number",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: mobileNumber,
                  enabled: enableText,
                  hintText: "+2344893836",
                  textInputType: TextInputType.phone,
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
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
                  enabled: enableText,
                  hintText: "hr@gmail.com",
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "BVN",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: bvnNumber,
                  enabled: enableText,
                  hintText: "22244893836",
                  textInputType: TextInputType.phone,
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Customer ID Number",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: customerId,
                  enabled: enableText,
                  hintText: "",
                  validator:
                      RequiredValidator(errorText: 'This field is required'),
                ),
              ],
            ),
          ),
        ));
  }
}
