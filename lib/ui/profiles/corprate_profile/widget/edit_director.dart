import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/director/director_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/response_models/director_response.dart';
import 'package:rosabon/model/response_models/identity_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/profiles/corprate_profile/director_screen.dart';
import 'package:rosabon/ui/profiles/corprate_profile/widget/view_director.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/ids_dropdown.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class EditDirector extends StatefulWidget {
  const EditDirector({Key? key}) : super(key: key);

  @override
  State<EditDirector> createState() => _EditDirectorState();
}

class _EditDirectorState extends State<EditDirector> {
  SessionManager sessionManager = SessionManager();
  late CompanyDocumentsBloc companyDocumentsBloc;
  var formKey = GlobalKey<FormState>();
  late DirectorBloc directorBloc;
  late UserBloc userBloc;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var middleName = TextEditingController();
  var address = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var idNumber = TextEditingController();
  var bvnNumber = TextEditingController();
  var customerId = TextEditingController();
  var date = TextEditingController();
  int? idTypeId;
  List<Ids> ids = [];

  String initialval = "Male";
  String? pin;
  bool veryPhone = false;
  bool enabledText = false;
  String? base64Profile;
  File? _pickedImage;
  String? url;
  int? directorId;
  String? idtype;
  _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _pickedImage = File(pickedFile!.path);
        base64Profile = base64Encode(_pickedImage!.readAsBytesSync());
        // widget.chapter!.base64Profile = base64Profile;
      });
    } catch (e) {
      print(e);
      setState(() {
        // error = e.toString();
      });
    }
  }

  @override
  void initState() {
    companyDocumentsBloc = CompanyDocumentsBloc();
    directorBloc = DirectorBloc();
    userBloc = UserBloc();
    userBloc.add(const IdentificationType());
    enabledText = sessionManager.otpVal.isNotEmpty ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as DirectorDetails;
    firstName.text = map.firstName!;
    lastName.text = map.lastName!;
    middleName.text = map.middleName!;
    address.text = map.address!;
    phoneNumber.text = map.phone!;
    email.text = map.email!;
    directorId = map.id;
    bvnNumber.text = map.bvn!;
    idNumber.text = map.idNumber!;
    idtype = map.idType!.name;
    idTypeId = map.idType!.id;
    url = map.passportImage!.imageUrl ?? "";

    return Scaffold(
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DirectorScreen(),
                    )),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            leadingWidth: 48.0,
            centerTitle: false,
            titleSpacing: 0,
            title: const Text("Edit Director",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DirectorBloc, DirectorState>(
            bloc: directorBloc,
            listener: (context, state) {
              if (state is DirectorLoading) {
                setState(() {
                  isLoading.value = true;
                });
              }

              if (state is DirectorSuccess) {
                isLoading.value = false;
                setState(() {});
                PopMessage().displayPopup(
                    context: context,
                    type: PopupType.success,
                    text: "Director successfully updated");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewDirector(),
                    ));
              }
              if (state is DirectorError) {
                isLoading.value = false;
                setState(() {});
                PopMessage().displayPopup(
                    context: context,
                    type: PopupType.failure,
                    text: state.error);
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
              if (state is IdentificationSuccess) {
                setState(() {
                  ids = state.identityReponse.ids!;
                });

                // userResponse = state.userResponse;
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: ListView(
            children: [
              Form(
                // key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      onChange: (val) {},
                      hintText: "Susan",
                      enabled: enabledText,
                      validator: RequiredValidator(
                          errorText: 'First name is required'),
                    ),
                    SizedBox(height: 1.5.h),
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
                      onChange: (val) {},
                      enabled: enabledText,
                      hintText: "Micheal",
                      // validator: RequiredValidator(
                      //     errorText: 'this field is required'),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "Last Name",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 1.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: lastName,
                      onChange: (val) {},
                      hintText: "Wyne",
                      enabled: enabledText,
                      validator:
                          RequiredValidator(errorText: 'Last name is required'),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "Address",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: address,
                      onChange: (val) {},
                      hintText: "",
                      enabled: enabledText,
                      validator:
                          RequiredValidator(errorText: 'Address is required'),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "Email Address",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: email,
                      hintText: "hr@gmail.com",
                      enabled: enabledText,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText:
                                'Email is required, please provide a valid email'),
                        EmailValidator(
                            errorText:
                                'Email is invalid, please provide a valid email'),
                      ]),
                      onChange: (val) {},
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      onChange: (val) {},
                      controller: phoneNumber,
                      hintText: "+2344893836",
                      enabled: enabledText,
                      textInputType: TextInputType.phone,
                      validator: RequiredValidator(
                          errorText: 'Phone number is required'),
                    ),
                    Text(
                      "Please provide the phone number tied to your BVN",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "BVN",
                      style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat"),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: bvnNumber,
                      onChange: (val) {},
                      hintText: "22244893836",
                      enabled: enabledText,
                      textInputType: TextInputType.phone,
                      validator: RequiredValidator(
                          errorText: 'This field is required'),
                    ),
                    SizedBox(height: 1.h),
                    // enabledText
                    //     ? Row(
                    //         children: [
                    //           SizedBox(
                    //             width: 5.w,
                    //             height: 2.h,
                    //             child: IgnorePointer(
                    //               ignoring: !enabledText,
                    //               child: Checkbox(
                    //                 value: veryPhone,
                    //                 onChanged: (bool? value) {
                    //                   setState(() {
                    //                     veryPhone = value!;
                    //                   });
                    //                   bvnBloc.add(BVN(
                    //                       bvnRequest: BvnRequest(
                    //                           id: bvnNumber.text,
                    //                           isSubjectConsent: true)));
                    //                 },
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(4)),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 3.w),
                    //           Text(
                    //             "Verify BVN",
                    //             style: TextStyle(
                    //                 color: Theme.of(context).dividerColor,
                    //                 fontSize: 10.sp,
                    //                 fontFamily: "Montserrat"),
                    //           ),
                    //         ],
                    //       )
                    //     : Container(),
                    SizedBox(height: 1.5.h),
                    Text(
                      "ID Type",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    // IgnorePointer(
                    //   ignoring: enabledText,
                    // child:
                    IdsDropDown(
                        onChanged: (Ids? val) {
                          setState(() {
                            idTypeId = val!.id;
                          });
                        },
                        dropdownValue: "",
                        hintText: idtype!,
                        items: ids),
                    // ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "ID Number",
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    AppInputField(
                      controller: idNumber,
                      onChange: (val) {},
                      hintText: "",
                      enabled: enabledText,
                      validator: RequiredValidator(
                          errorText: 'This field is required'),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        IgnorePointer(
                          // ignoring: enabledText,
                          child: CircleAvatar(
                            backgroundColor: concreteLight,
                            backgroundImage: url != null
                                ? NetworkImage(url!)
                                : _pickedImage == null
                                    ? null
                                    : FileImage(_pickedImage!) as ImageProvider,
                            radius: 45,
                            child: _pickedImage != null || url != null
                                ? Container()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset("assets/images/user.png",
                                          scale: 0.7),
                                      const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          Image.asset(
                                              "assets/images/semi_circle.png"),
                                          const Positioned(
                                            top: 3,
                                            left: 30,
                                            right: 80,
                                            child: Icon(
                                              Icons.photo_camera_outlined,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // SizedBox(height: 2)
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                                color: concreteBold,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Upload Photo",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: gray,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    sessionManager.otpVal.isNotEmpty
                        ? Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, bool val, _) {
                                    return Appbutton(
                                      onTap: onSave,
                                      buttonState: val
                                          ? AppButtonState.loading
                                          : AppButtonState.idle,
                                      title: "Update",
                                      textColor: Colors.white,
                                      backgroundColor: deepKoamaru,
                                    );
                                  }),
                              const SizedBox(height: 20),
                              Appbutton(
                                onTap: () => Navigator.pop(context),
                                title: "Cancel",
                                outlineColor: deepKoamaru,
                                textColor: gray,
                              )
                            ],
                          )
                        : Appbutton(
                            onTap: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                directorBloc.add(const SendOtpDirector());
                                // enabledText:
                                // true;
                                pinCode(
                                        context,
                                        "Enter OTP sent to your E-mail",
                                        enabledText)
                                    .then((value) {
                                  setState(() {
                                    enabledText = value["enabledText"] ?? false;
                                    sessionManager.otpVal = value["pin"];
                                    pin = value["pin"] ?? "";
                                  });
                                });
                              } else {
                                PopMessage().displayPopup(
                                    context: context,
                                    text: "Please check your internet",
                                    type: PopupType.failure);
                              }
                            },
                            title: "Edit",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        directorBloc.add(SaveDirector(directorRequest: [
          {
            "firstName": firstName.text,
            "lastName": lastName.text,
            "middleName": middleName.text,
            "email": email.text,
            "phone": phoneNumber.text,
            "address": address.text,
            "id": directorId,
            "idTypeId": idTypeId,
            "idNumber": idNumber.text,
            "bvn": bvnNumber.text,
            "idDocumentImage": base64Profile != null
                ? {"encodedUpload": base64Profile, "name": "Profile Pic"}
                : null,
            "passportImage": base64Profile != null
                ? {"encodedUpload": base64Profile, "name": "Profile Pic"}
                : null
          }
        ]));
      } catch (error) {
        setState(() {
          isLoading.value = true;
          // isLoading.value = false;
        });
      }
    } else {
      PopMessage().displayPopup(
          context: context,
          text: "Please check your internet",
          type: PopupType.failure);
    }
  }
}
