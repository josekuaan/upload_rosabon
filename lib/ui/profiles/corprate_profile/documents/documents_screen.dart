import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/company_document_requestion.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/saved_document.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/view_images.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class CompanyDocumentScreen extends StatefulWidget {
  const CompanyDocumentScreen({Key? key}) : super(key: key);

  @override
  State<CompanyDocumentScreen> createState() => _CompanyDocumentScreenState();
}

class _CompanyDocumentScreenState extends State<CompanyDocumentScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool loading = false;
  var docs = GlobalKey<FormState>();
  late CompanyDocumentsBloc companyDocumentsBloc;

  UserBloc userBloc = UserBloc();
  UserResponse? userResponse;
  String idType = "";
  String pin = "otp";
  final idNumber = TextEditingController();

  bool enabledText = false;
  bool viewImage = false;
  String? base64UtilityBill,
      base64IdCard,
      base64CertOfIcoImage,
      base64personIdImage,
      base64PersonImage;
  File? _personImage;
  File? _personIdImage;
  File? _certOfIco;
  File? _idImage;
  File? _utitlyImage;
  List<File> listOfImage = [];
  List<String> images = [];
  bool base64CertError = false;
  bool base64ContactPersonError = false;
  // bool base64CertOfIcoError = false;
  bool base64UtilityBillError = false;
  String? error;
  _contactPersonImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _personImage = File(pickedFile!.path);
        base64PersonImage = base64Encode(_personImage!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  _contactPersonIdImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _personIdImage = File(pickedFile!.path);
        base64personIdImage = base64Encode(_personIdImage!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  _certicateOfIco() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _certOfIco = File(pickedFile!.path);
        base64CertOfIcoImage = base64Encode(_certOfIco!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  _uploadUtitlity() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _utitlyImage = File(pickedFile!.path);
        base64UtilityBill = base64Encode(_utitlyImage!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  void initState() {
    companyDocumentsBloc = CompanyDocumentsBloc();
    companyDocumentsBloc.add(const FetchCompanyDocument());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text("Company Document",
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
          BlocListener<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
              if (state is FetchLoading) {
                setState(() {
                  loading = true;
                });
              }

              if (state is FetchUserSuccess) {
                setState(() {
                  loading = false;
                });
                userResponse = state.userResponse;
              }
            },
          ),
          BlocListener<CompanyDocumentsBloc, CompanyDocumentsState>(
              bloc: companyDocumentsBloc,
              listener: (context, state) {
                if (state is FetchingDocument) {
                  setState(() {
                    loading = true;
                  });
                }
                if (state is CompanyDocumentsLoading) {
                  isLoading.value = true;
                }
                if (state is CompanyDocumentsSuccess) {
                  isLoading.value = false;
                  PopMessage().displayPopup(
                      context: context,
                      type: PopupType.success,
                      text: "Your details have been updated successfully");
                  setState(() {
                    viewImage = !viewImage;
                  });
                  listOfImage.add(_certOfIco!);
                  listOfImage.add(_personIdImage!);
                  listOfImage.add(_utitlyImage!);
                  listOfImage.add(_personImage!);
                }

                if (state is DocumentFetched) {
                  setState(() {
                    loading = false;
                    viewImage = !viewImage;
                  });
                  images.add(
                      state.saveDocsResponse.certificateOfIncoImage!.imageUrl!);
                  images.add(state.saveDocsResponse
                      .contactPersonPhotographImage!.imageUrl!);
                  images
                      .add(state.saveDocsResponse.utilityBillImage!.imageUrl!);
                  images.add(
                      state.saveDocsResponse.contactPersonIdImage!.imageUrl!);
                }
              })
        ],
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: docs,
                        child: ListView(
                          children: [
                            SizedBox(height: 2.h),
                            Text(
                              "Company Certificate of Incorporation",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: !enabledText,
                                        child: InkWell(
                                          onTap: _certicateOfIco,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                border: base64CertError
                                                    ? Border.all(
                                                        width: 1,
                                                        color: Colors.red)
                                                    : Border.all(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                _certOfIco != null
                                                    ? _certOfIco!.path
                                                        .split("/")
                                                        .last
                                                    : "Choose File",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: gray,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      viewImage
                                          ? const Icon(Icons.check_circle,
                                              color: jungleGreen)
                                          : Container(),
                                    ],
                                  ),
                                  viewImage
                                      ? InkWell(
                                          onTap: () {
                                            if (images.isNotEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage(),
                                                      settings: RouteSettings(
                                                          arguments: images)));
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRouter.previewImage,
                                                  arguments: listOfImage);
                                            }
                                          },
                                          child: const Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: deepKoamaru,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Company Contact Person Photograph",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: !enabledText,
                                        child: InkWell(
                                          onTap: _contactPersonImage,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                border: base64ContactPersonError
                                                    ? Border.all(
                                                        width: 1,
                                                        color: Colors.red)
                                                    : Border.all(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                _personImage != null
                                                    ? _personImage!.path
                                                        .split("/")
                                                        .last
                                                    : "Choose File",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: gray,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      viewImage
                                          ? const Icon(Icons.check_circle,
                                              color: jungleGreen)
                                          : Container(),
                                    ],
                                  ),
                                  viewImage
                                      ? InkWell(
                                          onTap: () {
                                            if (images.isNotEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage(),
                                                      settings: RouteSettings(
                                                          arguments: images)));
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRouter.previewImage,
                                                  arguments: listOfImage);
                                            }
                                          },
                                          child: const Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: deepKoamaru,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Upload Utility Bill",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: !enabledText,
                                        child: InkWell(
                                          onTap: _uploadUtitlity,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                _utitlyImage != null
                                                    ? _utitlyImage!.path
                                                        .split("/")
                                                        .last
                                                    : "Choose File",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: gray,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      viewImage
                                          ? const Icon(Icons.check_circle,
                                              color: jungleGreen)
                                          : Container(),
                                    ],
                                  ),
                                  viewImage
                                      ? InkWell(
                                          onTap: () {
                                            if (images.isNotEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage(),
                                                      settings: RouteSettings(
                                                          arguments: images)));
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRouter.previewImage,
                                                  arguments: listOfImage);
                                            }
                                          },
                                          child: const Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: deepKoamaru,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Contact Person Identification (Front)",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: !enabledText,
                                        child: InkWell(
                                          onTap: _contactPersonIdImage,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                _personIdImage != null
                                                    ? _personIdImage!.path
                                                        .split("/")
                                                        .last
                                                    : "Choose File",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: gray,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      viewImage
                                          ? const Icon(Icons.check_circle,
                                              color: jungleGreen)
                                          : Container(),
                                    ],
                                  ),
                                  viewImage
                                      ? InkWell(
                                          onTap: () {
                                            if (images.isNotEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage(),
                                                      settings: RouteSettings(
                                                          arguments: images)));
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRouter.previewImage,
                                                  arguments: listOfImage);
                                            }
                                          },
                                          child: const Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: deepKoamaru,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Contact Person Identification (Back)",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: enabledText,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Text(
                                              "Choose File",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: gray,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      viewImage
                                          ? const Icon(Icons.check_circle,
                                              color: jungleGreen)
                                          : Container(),
                                    ],
                                  ),
                                  viewImage
                                      ? InkWell(
                                          onTap: () {
                                            if (images.isNotEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage(),
                                                      settings: RouteSettings(
                                                          arguments: images)));
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRouter.previewImage,
                                                  arguments: listOfImage);
                                            }
                                          },
                                          child: const Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: deepKoamaru,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    enabledText
                        ? Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, bool val, _) {
                                    return Appbutton(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        if (docs.currentState!.validate()) {
                                          if (base64PersonImage == null) {
                                            setState(() {
                                              base64ContactPersonError = true;
                                            });
                                          }
                                          if (base64CertOfIcoImage == null) {
                                            setState(() {
                                              base64CertError = true;
                                            });
                                          }
                                          if (base64UtilityBill == null) {
                                            setState(() {
                                              base64UtilityBillError = true;
                                            });
                                          }
                                          var connectivityResult =
                                              await (Connectivity()
                                                  .checkConnectivity());
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            companyDocumentsBloc.add(
                                                CompanyDocuments(
                                                    companyDocumentRequest:
                                                        CompanyDocumentRequest(
                                              cacImage: CacImage(
                                                  encodedUpload:
                                                      base64PersonImage),
                                              idTypeId: 2,
                                              contactPersonIdNumber:
                                                  idNumber.text,
                                              certificateOfIncoImage:
                                                  CertificateOfIncoImage(
                                                      encodedUpload:
                                                          base64CertOfIcoImage,
                                                      name:
                                                          "base64CertOfIcoImage"),
                                              contactPersonIdentityImage:
                                                  ContactPersonIdentityImage(
                                                      encodedUpload:
                                                          base64personIdImage,
                                                      name:
                                                          "base64personIdImage"),
                                              otp: pin,
                                              moaImage: MoaImage(
                                                  encodedUpload:
                                                      base64UtilityBill,
                                                  name: "base64UtilityBill"),
                                              utilityBillImage:
                                                  UtilityBillImage(
                                                      encodedUpload:
                                                          base64UtilityBill,
                                                      name:
                                                          "base64UtilityBill"),
                                            )));
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
                                      title: "Save",
                                      textColor: Colors.white,
                                      backgroundColor: deepKoamaru,
                                    );
                                  }),
                              const SizedBox(height: 20),
                              Appbutton(
                                onTap: () => setState(() {
                                  enabledText = false;
                                }),
                                title: "Cancel",
                                outlineColor: deepKoamaru,
                                textColor: gray,
                              )
                            ],
                          )
                        : Appbutton(
                            onTap: () {
                              companyDocumentsBloc.add(const CompanyOtp());
                              pinCode(context, "Enter OTP sent to your email.",
                                      enabledText)
                                  .then((value) {
                                setState(() {
                                  // enabledText = value ?? false;
                                          value["enabledText"] ?? false;

                                  pin = value["pin"] ?? "";
                                  images = [];
                                  viewImage = false;
                                });
                              });
                                    // bankBloc.add(ValidateOtp(otp: pin));
                              
                            },
                            title: "Edit",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
      ),
    );
  }

  dynamic saved() {
    setState(() {
      enabledText = false;
    });
    Navigator.pop(context);
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SavedCompanyDocument()));
  }
}
