import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosabon/bloc/auth/bvn/bvn_bloc.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/director/director_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/bvn_request.dart';
import 'package:rosabon/model/request_model/more_detail_request.dart';
import 'package:rosabon/model/response_models/identity_response.dart';

import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/profiles/corprate_profile/corprate_profile_screen.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_dropdown.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/ids_dropdown.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:rosabon/ui/widgets/show_alert_box.dart';
import 'package:sizer/sizer.dart';

class DirectorScreen extends StatefulWidget {
  const DirectorScreen({Key? key}) : super(key: key);

  @override
  State<DirectorScreen> createState() => _DirectorScreenState();
}

class _DirectorScreenState extends State<DirectorScreen> {
  SessionManager sessionManager = SessionManager();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late BvnBloc bvnBloc;
  late DirectorBloc directorBloc;
  late UserBloc userBloc;
  var form = GlobalKey<FormState>();
  List<MoreDetailRequest> director = [];
  List<Ids> ids = [];

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

  String initialval = "Male";
  String? pin;
  bool veryPhone = false;
  bool enabledText = false;
  String? base64Profile;
  File? _pickedImage;
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
    bvnBloc = BvnBloc();
    userBloc = UserBloc();
    directorBloc = DirectorBloc();
    userBloc.add(const IdentificationType());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CorprateProfileScreen(),
                      )),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              leadingWidth: 48.0,
              centerTitle: false,
              titleSpacing: 0,
              title: const Text("More Details",
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
                  setState(() {
                    isLoading.value = false;
                  });
                  PopMessage().displayPopup(
                      context: context,
                      type: PopupType.success,
                      text: "Your director have been saved successfully");

                  lastName.clear();
                  firstName.clear();
                  middleName.clear();
                  bvnNumber.clear();
                  address.clear();
                  email.clear();
                  phoneNumber.clear();
                  idNumber.clear();
                  idTypeId;
                  _pickedImage = null;
                }
                if (state is DirectorError) {
                  setState(() {
                    isLoading.value = false;
                  });
                  PopMessage().displayPopup(
                      context: context,
                      type: PopupType.failure,
                      text: state.error);
                }
              },
            ),
            BlocListener<BvnBloc, BvnState>(
              bloc: bvnBloc,
              listener: (context, state) {
                if (state is BvnLoading) {
                  // isLoading.value = true;
                }
                if (state is BvnSuccess) {
                  setState(() {
                    veryPhone = true;
                  });
                  showAlertBox(context,
                      "${state.bvnResponse.data!.lastName} ${state.bvnResponse.data!.firstName}");
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
                // if (state is FetchLoading) {
                //   setState(() {
                //     loading = true;
                //   });
                // }

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
            child: Column(
              // // shrinkWrap: true,
              // physics: const ScrollPhysics(),
              // addAutomaticKeepAlives: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (form.currentState!.validate()) {
                          director.add(
                            MoreDetailRequest(
                              firstName: firstName.text,
                              lastName: lastName.text,
                              middleName: middleName.text,
                              email: email.text,
                              phone: phoneNumber.text,
                              address: address.text,
                              idTypeId: idTypeId,
                              idNumber: idNumber.text,
                              bvn: bvnNumber.text,
                              idDocumentImage: DocumentImage(
                                  encodedUpload: base64Profile,
                                  name: "Profile Pic"),
                              passportImage: ProfileImage(
                                  encodedUpload: base64Profile,
                                  name: "Profile Pic"),
                            ),
                          );
                          lastName.clear();
                          firstName.clear();
                          middleName.clear();
                          bvnNumber.clear();
                          address.clear();
                          email.clear();
                          phoneNumber.clear();
                          idNumber.clear();
                          idTypeId;
                          _pickedImage = null;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.add_circle_outline_sharp,
                                color: deepKoamaru,
                                size: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Add more",
                                    style: TextStyle(
                                        color: deepKoamaru,
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500)),
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          !enabledText ? sessionManager.otpVal = "" : "";
                          Navigator.pushNamed(context, AppRouter.viewdirector);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("View",
                                    style: TextStyle(
                                        color: deepKoamaru,
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500)),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Form(
                    key: form,
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                          validator: RequiredValidator(
                              errorText: 'This field is required'),
                        ),
                        SizedBox(height: 1.5.h),
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
                          onChange: (val) {},
                          hintText: "Wyne",
                          enabled: enabledText,
                          validator: RequiredValidator(
                              errorText: 'Last name is required'),
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
                          validator: RequiredValidator(
                              errorText: 'Address is required'),
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
                          hintText: "080645493836",
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
                        enabledText
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                    height: 2.h,
                                    child: IgnorePointer(
                                      ignoring: !enabledText,
                                      child: Checkbox(
                                        value: veryPhone,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            veryPhone = value!;
                                          });
                                          bvnBloc.add(BVN(
                                              bvnRequest: BvnRequest(
                                            id: bvnNumber.text,
                                            isSubjectConsent: true,
                                            phoneNumber: phoneNumber.text,
                                            firstName: firstName.text,
                                            lastName: lastName.text,
                                          )));
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    "Verify BVN",
                                    style: TextStyle(
                                        color: Theme.of(context).dividerColor,
                                        fontSize: 10.sp,
                                        fontFamily: "Montserrat"),
                                  ),
                                ],
                              )
                            : Container(),
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
                        IgnorePointer(
                          ignoring: !enabledText,
                          child: IdsDropDown(
                              onChanged: (Ids? val) {
                                setState(() {
                                  idTypeId = val!.id;
                                });
                              },
                              dropdownValue: "",
                              hintText: "",
                              items: ids),
                        ),
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
                                backgroundImage: _pickedImage != null
                                    ? FileImage(_pickedImage!)
                                    : null,
                                radius: 45,
                                child: _pickedImage != null
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                            SizedBox(width: 2.h),
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
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
                enabledText
                    ? Column(children: [
                        veryPhone
                            ? ValueListenableBuilder(
                                valueListenable: isLoading,
                                builder: (context, bool val, _) {
                                  return Appbutton(
                                    onTap: onSave,
                                    buttonState: val
                                        ? AppButtonState.loading
                                        : AppButtonState.idle,
                                    title: "Save",
                                    textColor: Colors.white,
                                    backgroundColor: deepKoamaru,
                                  );
                                })
                            : Appbutton(
                                onTap: () {},
                                title: "Save",
                                backgroundColor: alto,
                                // outlineColor: alto,
                                textColor: gray,
                              ),
                        const SizedBox(height: 20),
                        Appbutton(
                          onTap: () {},

                          // setState(() {
                          //   _customTileExpanded =
                          //       !_customTileExpanded;
                          // }),
                          title: "Cancel",
                          outlineColor: deepKoamaru,
                          textColor: gray,
                        )
                      ])
                    : Appbutton(
                        onTap: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            directorBloc.add(const SendOtpDirector());
                            pinCode(context, "Enter OTP sent to your E-mail",
                                    enabledText)
                                .then((value) {
                              setState(() {
                                // enabledText = value ?? false;
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
                        backgroundColor: deepKoamaru)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSave() async {
    // _MoredetailScreenState
    FocusScope.of(context).requestFocus(FocusNode());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (director.isNotEmpty) {
        try {
          var data = director
              .map((it) => {
                    "firstName": it.firstName,
                    "lastName": it.lastName,
                    "middleName": it.middleName,
                    "email": it.email,
                    "phone": it.phone,
                    "address": it.address,

                    "idTypeId": it.idTypeId,
                    "idNumber": it.idNumber,
                    "bvn": it.bvn,
                    "idDocumentImage": {
                      "encodedUpload": it.idDocumentImage!.encodedUpload,
                      "name": "Profile Pic"
                    },
                    "passportImage": {
                      "encodedUpload": it.passportImage!.encodedUpload,
                      "name": "Profile Pic"
                    }

                    // "phoneNumber": it.chapter!.idType,
                  })
              .toList();

          directorBloc.add(SaveDirector(directorRequest: data));
          director = [];
          sessionManager.otpVal = "";
        } catch (error) {
          setState(() {
            isLoading.value = false;
          });
        }
      } else {
        if (form.currentState!.validate()) {
          try {
            directorBloc.add(SaveDirector(directorRequest: [
              {
                "firstName": firstName.text,
                "lastName": lastName.text,
                "middleName": middleName.text,
                "email": email.text,
                "phone": phoneNumber.text,
                "address": address.text,
                "idTypeId": idTypeId,
                "idNumber": idNumber.text,
                "bvn": bvnNumber.text,
                "idDocumentImage": {
                  "encodedUpload": base64Profile,
                  "name": "Profile Pic"
                },
                "passportImage": {
                  "encodedUpload": base64Profile,
                  "name": "Profile Pic"
                }
              }
            ]));

            sessionManager.otpVal = "";
          } catch (error) {
            setState(() {
              isLoading.value = false;
            });
          }
        }
      }
    } else {
      PopMessage().displayPopup(
          context: context,
          text: "Please check your internet",
          type: PopupType.failure);
    }
  }
}
