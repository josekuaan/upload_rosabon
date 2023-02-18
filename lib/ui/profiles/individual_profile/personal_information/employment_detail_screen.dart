import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/employmentDetails/employment_details_bloc.dart';
import 'package:rosabon/model/request_model/personal_information_request.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({Key? key}) : super(key: key);

  @override
  State<EmploymentDetails> createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  var employmentKey = GlobalKey<FormState>();
  var occupation = TextEditingController();
  var employeeName = TextEditingController();
  var employeeAddress = TextEditingController();
  late EmploymentDetailsBloc employmentDetailsBloc;

  bool enabledText = false;

  @override
  void initState() {
    employmentDetailsBloc = EmploymentDetailsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;

    occupation.text =
     user.individualUser!.employmentDetail==null ? "":  user.individualUser!.employmentDetail!.occupation! ;
    employeeName.text =
        user.individualUser!.employmentDetail==null ? "": user.individualUser!.employmentDetail!.employerName!;
    employeeAddress.text =
        user.individualUser!.employmentDetail ==null ? "":  user.individualUser!.employmentDetail!.employerAddress!;

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
            title: const Text("Employment Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: BlocListener<EmploymentDetailsBloc, EmploymentDetailsState>(
        bloc: employmentDetailsBloc,
        listener: (context, state) {
          print(state);
          if (state is EmploymentLoading) {
            isLoading.value = true;
          }
          if (state is EmploymentSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(context, AppRouter.personalinfo,
                arguments: SessionManager().userRoleVal);
            PopMessage().displayPopup(
                context: context,
                text: "Employment details Successfully saved",
                type: PopupType.success);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: employmentKey,
            child: ListView(
              children: [
                Text(
                  "Occupation",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: occupation,
                  hintText: "",
                  enabled: enabledText,
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Employer’s Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: employeeName,
                  hintText: '',
                  // user.individualUser!.employmentDetail!.employerName,
                  enabled: enabledText,
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Employer’s Address",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: employeeAddress,
                  hintText: "",
                  enabled: enabledText,
                  validator:
                      RequiredValidator(errorText: 'this field is required'),
                ),
                const SizedBox(height: 100),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                        onTap: () async {
                          if (enabledText) {
                            if (employmentKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                employmentDetailsBloc.add(SubmitDetails(
                                  PersonalInformationRequest(
                                    address: null,
                                    countryId: null,
                                    lgaId: null,
                                    secondaryPhone: null,
                                    stateId: null,
                                    employmentDetail: EpDetail(
                                      employerName: employeeName.text,
                                      occupation: occupation.text,
                                      employerAddress: employeeAddress.text,
                                    ),
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
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
