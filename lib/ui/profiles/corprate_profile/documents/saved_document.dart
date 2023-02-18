import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/countryApi/countri_api_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/company_document_requestion.dart';
import 'package:rosabon/model/response_models/identity_response.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/view_images.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/ids_dropdown.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class SavedCompanyDocument extends StatefulWidget {
  const SavedCompanyDocument({Key? key}) : super(key: key);

  @override
  State<SavedCompanyDocument> createState() => _SavedCompanyDocumentState();
}

class _SavedCompanyDocumentState extends State<SavedCompanyDocument> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool loading = false;
  int? idTypeId;
  String? pin;
  String? idType = "";
  final idNumber = TextEditingController();
  var docs = GlobalKey<FormState>();
  List idTypeObj = [
    {"name": "National ID card", "type": "NATIONAL_ID_CARD"},
    {"name": "Driver’s License", "type": "DRIVERS_LICENSE"},
    {"name": "International Passport", "type": "INTERNATIONAL_PASSPORT"},
    {"name": "Voter’s Card", "type": "VOTERS_CARD"}
  ];

  late CompanyDocumentsBloc companyDocumentsBloc;
  late UserBloc userBloc;

  bool enabledText = false;
  bool viewImage = false;
  String? base64UtilityBill,
      base64IdCard,
      base64CertOfIcoImage,
      base64CacImage,
      base64personIdImage,
      base64PersonImage,
      base64MoaImage;
  File? _moa;
  File? _personImage;
  File? _personIdImage;
  File? _certOfIco;
  File? _cacImage;

  File? _utitlyImage;
  List<File> listOfImage = [];
  List<String> images = [];
  List<Ids> ids = [];
  bool base64MoaError = false;
  bool base64CertError = false;
  bool base64ContactPersonError = false;
  bool base64PersonIdError = false;
  bool base64CertOfIcoError = false;
  bool base64CacError = false;
  bool base64IdError = false;
  bool base64UtilityBillError = false;
  String? error;
  _moaImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _moa = File(pickedFile!.path);
        base64MoaImage = base64Encode(_moa!.readAsBytesSync());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  _personPhoto() async {
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

  _pickCacImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _cacImage = File(pickedFile!.path);
        base64CacImage = base64Encode(_cacImage!.readAsBytesSync());
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
    userBloc = UserBloc();
    companyDocumentsBloc.add(const FetchCompanyDocument());
    userBloc.add(const IdentificationType());
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
                    text: "Your details have been updated successfully",
                    type: PopupType.success,
                  );
                  setState(() {
                    viewImage = true;
                  });
                  listOfImage.add(_certOfIco!);
                  listOfImage.add(_personIdImage!);
                  listOfImage.add(_utitlyImage!);
                  listOfImage.add(_personImage!);
                  listOfImage.add(_cacImage!);
                  listOfImage.add(_moa!);
                  // Navigator.pushNamed(context, AppRouter.corprateinfo,
                  //     arguments: SessionManager().userRoleVal);
                }
                if (state is DocumentFetched) {
                  // String val = state.saveDocsResponse.idType ?? "";

                  setState(() {
                    loading = false;
                    viewImage = !viewImage;
                    idNumber.text = state.saveDocsResponse.idNumber!;
                    idType = state.saveDocsResponse.idType!.name;
                    // idType = val == "NATIONAL_ID_CARD"
                    //     ? "National ID card"
                    //     : val == "DRIVERS_LICENSE"
                    //         ? "Driver’s License"
                    //         : val == "INTERNATIONAL_PASSPORT"
                    //             ? "International Passport"
                    //             : "Voter’s Card";
                  });

                  images.add(
                      state.saveDocsResponse.certificateOfIncoImage!.imageUrl!);
                  images.add(state.saveDocsResponse
                      .contactPersonPhotographImage!.imageUrl!);
                  images
                      .add(state.saveDocsResponse.utilityBillImage!.imageUrl!);
                  images.add(
                      state.saveDocsResponse.contactPersonIdImage!.imageUrl!);
                  images.add(state.saveDocsResponse.moaImage!.imageUrl!);
                  images.add(state.saveDocsResponse.cacImage!.imageUrl!);
                }
                if (state is CompanyDocsError) {
                  isLoading.value = false;
                  PopMessage().displayPopup(
                    context: context,
                    text: state.error,
                    type: PopupType.failure,
                  );
                }
              }),
          BlocListener<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
              if (state is FetchLoading) {
                setState(() {
                  loading = true;
                });
              }

              if (state is IdentificationSuccess) {
                setState(() {
                  loading = false;
                  ids = state.identityReponse.ids!;
                });

                // userResponse = state.userResponse;
              }
            },
          ),
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
                              "Company CAC Form CO2 & CO7",
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
                                          onTap: _pickCacImage,
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
                                                _cacImage != null
                                                    ? _cacImage!.path
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
                              "Company Memorandum of Association",
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
                                          onTap: _moaImage,
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
                                                _moa != null
                                                    ? _moa!.path.split("/").last
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
                                          onTap: _personPhoto,
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
                              "ID Type",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            IgnorePointer(
                              ignoring: !enabledText,
                              child: IdsDropDown(
                                  onChanged: (Ids? val) {
                                    idTypeId = val!.id;
                                  },
                                  dropdownValue: "",
                                  hintText: idType!,
                                  items: ids),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "ID Number",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            AppInputField(
                              controller: idNumber,
                              hintText: "Enter ID Number",
                              enabled: enabledText,
                              validator: RequiredValidator(
                                  errorText: "Please add Id number"),
                            ),
                            SizedBox(height: 2.h),
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
                                          if (base64MoaImage == null) {
                                            setState(() {
                                              base64MoaError = true;
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
                                          if (base64personIdImage == null) {
                                            setState(() {
                                              base64PersonIdError = true;
                                            });
                                          }
                                          if (base64CacImage == null) {
                                            setState(() {
                                              base64CacError = true;
                                            });
                                          }
                                          var connectivityResult =
                                              await (Connectivity()
                                                  .checkConnectivity());
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            companyDocumentsBloc.add(CompanyDocuments(
                                                companyDocumentRequest: CompanyDocumentRequest(
                                                    cacImage: CacImage(
                                                        encodedUpload:
                                                            base64PersonImage),
                                                    idTypeId: idTypeId,
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
                                                            base64MoaImage,
                                                        name: "moaImage"),
                                                    utilityBillImage:
                                                        UtilityBillImage(
                                                            encodedUpload:
                                                                base64UtilityBill,
                                                            name:
                                                                "base64UtilityBill"),
                                                    contactPersonPhotographImage:
                                                        ContactPersonPhotographImage(
                                                            encodedUpload:
                                                                base64PersonImage,
                                                            name:
                                                                "base64PersonImage"))));
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
                              enabledText = true;

                              pinCode(context, "Enter OTP sent to your email.",
                                      enabledText)
                                  .then((value) {
                                setState(() {
                                  enabledText = value["enabledText"] ?? false;
                                  pin = value["pin"] ?? "";
                                  images = [];
                                  viewImage = false;
                                });
                              });
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
}
