// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:rosabon/bloc/auth/companyKyc/company_kyc_bloc.dart';
// import 'package:rosabon/model/request_model/company_details_update_request.dart';
// import 'package:rosabon/model/response_models/user_response.dart';
// import 'package:rosabon/session_manager/session_manager.dart';
// import 'package:rosabon/ui/views/shared/app_colors.dart';
// import 'package:rosabon/ui/views/shared/app_routes.dart';
// import 'package:rosabon/ui/widgets/app_button.dart';
// import 'package:rosabon/ui/widgets/app_dropdown.dart';
// import 'package:rosabon/ui/widgets/app_input_field.dart';
// import 'package:rosabon/ui/widgets/app_num.dart';
// import 'package:rosabon/ui/widgets/date_picker.dart';
// import 'package:rosabon/ui/widgets/pop_message.dart';

// class CorprateInfoDetailScreen extends StatefulWidget {
//   const CorprateInfoDetailScreen({Key? key}) : super(key: key);

//   @override
//   State<CorprateInfoDetailScreen> createState() =>
//       _CorprateInfoDetailScreenState();
// }

// class _CorprateInfoDetailScreenState extends State<CorprateInfoDetailScreen> {
//   final ValueNotifier<bool> isLoading = ValueNotifier(false);
//   var companyKey = GlobalKey<FormState>();
//   var companyName = TextEditingController();
//   var companyRCNumber = TextEditingController();
//   var businessType = TextEditingController();
//   var companyAddress = TextEditingController();
//   var companyId = TextEditingController();
//   var date = TextEditingController();
//   var companytype = TextEditingController();
//   late CompanyKycBloc companyKycBloc;
//   String initialval = "";
//   // String? companytype ;
//   List group = <dynamic>[
//     {"name": "Sole propreitorship"},
//     {"name": "Partnership"},
//     {"name": "Corporate Limited"},
//   ];
//   @override
//   void initState() {
//     companyKycBloc = CompanyKycBloc();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var user = ModalRoute.of(context)!.settings.arguments as UserResponse;
//     // isLoading.value = false;
//     // user = state.userResponse; PARTNERSHIP

//     companyName.text = user.company!.name ?? "";
//     companyRCNumber.text = user.company!.rcNumber ?? "";
//     businessType.text = user.company!.natureOfBusiness ?? "";
//     setState(() {
//       initialval = user.company!.companyType == "SOLE_PROPRIETORSHIP"
//           ? "Sole proprietorship"
//           : user.company!.companyType == "CORPORATE_LIMITED"
//               ? "Corporate Limited"
//               : "Partnership";
//     });
//     companyId.text = user.company!.rcNumber ?? "";
//     companyAddress.text = user.company!.companyAddress ?? "";
//     date.text = user.company!.dateOfInco ?? "";

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80.0),
//         child: Container(
//           decoration: const BoxDecoration(boxShadow: [
//             BoxShadow(
//                 color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
//           ]),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             shadowColor: deepKoamaru,
//             elevation: 0,
//             leading: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.black,
//                 )),
//             leadingWidth: 48.0,
//             centerTitle: false,
//             titleSpacing: 0,
//             title: const Text("Company Details",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black)),
//           ),
//         ),
//       ),
//       body: BlocListener<CompanyKycBloc, CompanyKycState>(
//         bloc: companyKycBloc,
//         listener: (context, state) {
//           if (state is CompanyKycLoading) {
//             isLoading.value = true;
//           }
//           if (state is CompanyUpdateSuccess) {
//             isLoading.value = false;
//             Navigator.pushNamed(context, AppRouter.personalinfo,
//                 arguments: SessionManager().userRoleVal);
//             PopMessage().displayPopup(
//                 context: context,
//                 text: "Company details Successfully update",
//                 type: PopupType.success);
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//           child: Form(
//             key: companyKey,
//             child: ListView(
//               children: [
//                 Text(
//                   "Company Name",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 AppInputField(
//                   controller: companyName,
//                   hintText: "",
//                   enabled: false,
//                   validator:
//                       RequiredValidator(errorText: 'Company name is required'),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Company RC Number",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 AppInputField(
//                   controller: companyRCNumber,
//                   hintText: "",
//                   enabled: false,
//                   validator:
//                       RequiredValidator(errorText: 'company RC is required'),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Company Registration Date",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 DatePicker(
//                     controller: date,
//                     hintText: "DD/MM/YYY",
//                     enableText: false,
//                     validator: RequiredValidator(
//                         errorText: "Please Pick your Date of Birth")),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Customer ID Number",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 AppInputField(
//                   controller: companyId,
//                   hintText: "",
//                   validator:
//                       RequiredValidator(errorText: 'Company ID is required'),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Company Address",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 AppInputField(
//                   controller: companyAddress,
//                   hintText: "1,victor,street",
//                   validator: RequiredValidator(
//                       errorText: 'Company address is required'),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Nature of Business",
//                   style: TextStyle(
//                       color: Theme.of(context).dividerColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: "Montserrat"),
//                 ),
//                 const SizedBox(height: 8),
//                 AppInputField(
//                   controller: businessType,
//                   hintText: "",
//                   validator:
//                       RequiredValidator(errorText: 'Business type is required'),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Company Type",
//                   style: TextStyle(
//                     color: Theme.of(context).dividerColor,
//                     fontFamily: "Montserrat",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 AppDropDown(
//                     onChanged: (dynamic val) {
//                       setState(() {
//                         initialval = val["name"];
//                       });
//                         // companytype.text = initialval;

//                     },
//                     dropdownValue: 'initialval',
//                     hintText: 'initialval',
//                     items: group),
//                 const SizedBox(height: 40),
//                 ValueListenableBuilder(
//                     valueListenable: isLoading,
//                     builder: (context, bool val, _) {
//                       return Appbutton(
//                         onTap: () async {
//                           var connectivityResult =
//                               await (Connectivity().checkConnectivity());
//                           if (connectivityResult == ConnectivityResult.mobile ||
//                               connectivityResult == ConnectivityResult.wifi) {
//                             companyKycBloc.add(
//                               CompanyUpdate(
//                                 companyDetailsUpdateequest:
//                                     CompanyDetailsUpdateequest(
//                                   name: companyName.text,
//                                   rcNumber: companyRCNumber.text,
//                                   companyType: initialval,
//                                   companyAddress: companyAddress.text,
//                                   dateOfInco: date.text,
//                                   natureOfBusiness: businessType.text,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             PopMessage().displayPopup(
//                                 context: context,
//                                 text: "Please check your internet",
//                                 type: PopupType.failure);
//                           }
//                         },
//                         buttonState:
//                             val ? AppButtonState.loading : AppButtonState.idle,
//                         title: "Save",
//                         textColor: Colors.white,
//                         backgroundColor: deepKoamaru,
//                       );
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/companyKyc/company_kyc_bloc.dart';
import 'package:rosabon/model/request_model/company_details_update_request.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/date_picker.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class CorprateInfoDetailScreen extends StatefulWidget {
  const CorprateInfoDetailScreen({Key? key}) : super(key: key);

  @override
  State<CorprateInfoDetailScreen> createState() =>
      _CorprateInfoDetailScreenState();
}

class _CorprateInfoDetailScreenState extends State<CorprateInfoDetailScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  var companyKey = GlobalKey<FormState>();
  var companyName = TextEditingController();
  var companyRCNumber = TextEditingController();
  var businessType = TextEditingController();
  var companyAddress = TextEditingController();
  var companyId = TextEditingController();
  var date = TextEditingController();
  late CompanyKycBloc companyKycBloc;
  String initialval = "";
  String conpanyCat = "";
  List group = <dynamic>[
    {"name": "Sole_propreitorship"},
    {"name": "Partnership"},
    {"name": "Corporate_Limited"},
  ];
  String company = '';
  @override
  void initState() {
    companyKycBloc = CompanyKycBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;
    // isLoading.value = false;
    // user = state.userResponse; PARTNERSHIP

    companyName.text = user.company!.name ?? "";
    companyRCNumber.text = user.company!.rcNumber ?? "";
    businessType.text = user.company!.natureOfBusiness ?? "";
    setState(() {
      initialval = user.company!.companyType == "SOLE_PROPRIETORSHIP"
          ? "Sole_proprietorship"
          : user.company!.companyType == "CORPORATE_LIMITED"
              ? "Corporate_Limited"
              : "Partnership";
    });
    companyId.text = user.company!.rcNumber ?? "";
    companyAddress.text = user.company!.companyAddress ?? "";
    date.text = user.company!.dateOfInco ?? "";

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
            title: const Text("Company Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: BlocListener<CompanyKycBloc, CompanyKycState>(
        bloc: companyKycBloc,
        listener: (context, state) {
          if (state is CompanyKycLoading) {
            isLoading.value = true;
          }
          if (state is CompanyUpdateSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(context, AppRouter.corprateinfo,
                arguments: SessionManager().userRoleVal);
            PopMessage().displayPopup(
                context: context,
                text: "Company details Successfully update",
                type: PopupType.success);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: companyKey,
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
                  hintText: "",
                  enabled: false,
                  validator:
                      RequiredValidator(errorText: 'Company name is required'),
                ),
                const SizedBox(height: 20),
                IgnorePointer(
                  ignoring: true,
                  child: Text(
                    "Company RC Number",
                    style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: companyRCNumber,
                  hintText: "",
                  enabled: false,
                  validator:
                      RequiredValidator(errorText: 'company RC is required'),
                ),
                const SizedBox(height: 20),
                IgnorePointer(
                  ignoring: true,
                  child: Text(
                    "Company Registration Date",
                    style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DatePicker(
                    controller: date,
                    hintText: "DD/MM/YYY",
                    enableText: false,
                    validator: RequiredValidator(
                        errorText: "Please Pick your Date of Birth")),
                const SizedBox(height: 20),
                IgnorePointer(
                  ignoring: true,
                  child: Text(
                    "Customer ID Number",
                    style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                IgnorePointer(
                  ignoring: true,
                  child: AppInputField(
                    controller: companyId,
                    hintText: "",
                    validator:
                        RequiredValidator(errorText: 'Company ID is required'),
                  ),
                ),
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
                  hintText: "1,victor,street",
                  validator: RequiredValidator(
                      errorText: 'Company address is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Nature of Business",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: businessType,
                  hintText: "",
                  validator:
                      RequiredValidator(errorText: 'Business type is required'),
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
                      print(val);
                      setState(() {
                        conpanyCat = val;
                      });
                      // initialval = val["name"];
                    },
                    dropdownValue: "",
                    hintText: initialval,
                    items: group),
                const SizedBox(height: 40),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                        onTap: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            companyKycBloc.add(
                              CompanyUpdate(
                                companyDetailsUpdateequest:
                                    CompanyDetailsUpdateequest(
                                  name: companyName.text,
                                  // rcNumber: companyRCNumber.text,
                                  companyType: conpanyCat,
                                  companyAddress: companyAddress.text,
                                  // dateOfInco: date.text,
                                  natureOfBusiness: businessType.text,
                                ),
                              ),
                            );
                          } else {
                            PopMessage().displayPopup(
                                context: context,
                                text: "Please check your internet",
                                type: PopupType.failure);
                          }
                        },
                        buttonState:
                            val ? AppButtonState.loading : AppButtonState.idle,
                        title:
                            user.company!.rcNumber != null ? "Update" : "Save",
                        textColor: Colors.white,
                        backgroundColor: deepKoamaru,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
