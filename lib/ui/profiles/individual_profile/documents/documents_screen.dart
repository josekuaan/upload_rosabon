import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/documents/documents_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/document_request.dart';
import 'package:rosabon/model/response_models/identity_response.dart';
import 'package:rosabon/ui/profiles/corprate_profile/documents/view_images.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/custome_dopdown.dart';
import 'package:rosabon/ui/widgets/ids_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool loading = false;
  var docs = GlobalKey<FormState>();
  final idNumber = TextEditingController();
  late DocsBloc documentsBloc;
  late UserBloc userBloc;

  bool enabledText = false;
  bool viewImage = false;
  String? base64UtilityBill, base64IdCard, base64Profile;
  File? _pickedImage;
  File? _idImage;
  File? _utitlyImage;
  List<File> listOfImage = [];
  List<String> images = [];
  List<Ids> ids = [];
  bool base64IdCardError = false;
  bool base64UtilityBillError = false;
  String? error;
  int? idTypeId;
  String idType = "Select ID Type";
  String passportPhotographImage = "";

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
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  _uploadIdType() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );
      setState(() {
        _idImage = File(pickedFile!.path);
        base64IdCard = base64Encode(_idImage!.readAsBytesSync());
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
    documentsBloc = DocsBloc();
    userBloc = UserBloc();
    documentsBloc.add(const FetchDocument());
    userBloc.add(const IdentificationType());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: deepKoamaru,
            elevation: 0.5,
            bottomOpacity: 0.8,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            leadingWidth: 48.0,
            centerTitle: false,
            titleSpacing: 0,
            title: const Text("My Documents",
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
          BlocListener<DocsBloc, DocumentsState>(
              bloc: documentsBloc,
              listener: (context, state) {
                if (state is DocumentsFetching) {
                  setState(() {
                    loading = true;
                  });
                }
                if (state is DocumentsLoading) {
                  isLoading.value = true;
                }
                if (state is DocumentsSuccess) {
                  isLoading.value = false;
                  listOfImage.add(_idImage!);
                  listOfImage.add(_pickedImage!);
                  listOfImage.add(_utitlyImage!);
                  setState(() {
                    viewImage = !viewImage;
                    enabledText = !enabledText;
                  });
                }
                if (state is DocumentError) {
                  isLoading.value = false;
                  PopMessage().displayPopup(
                      context: context,
                      text: state.error,
                      type: PopupType.failure);
                }
                if (state is DocumentLoaded) {
                  setState(() {
                    loading = false;
                    viewImage = !viewImage;
                  });
                  idType = state.documentResponse.idType!.name;
                  idNumber.text = state.documentResponse.idNumber!;
                  images.add(state.documentResponse.idDocumentImage!.imageUrl!);
                  passportPhotographImage =
                      state.documentResponse.passportPhotographImage!.imageUrl!;
                  images
                      .add(state.documentResponse.utilityBillImage!.imageUrl!);
                  images.add(state
                      .documentResponse.passportPhotographImage!.imageUrl!);
                }
              }),
          BlocListener<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
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
                            Row(
                              children: [
                                passportPhotographImage.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundColor: concreteLight,
                                        backgroundImage: NetworkImage(
                                            passportPhotographImage),
                                        radius: 45,
                                      )
                                    : IgnorePointer(
                                        ignoring: !enabledText,
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
                                                    Image.asset(
                                                        "assets/images/user.png",
                                                        scale: 0.7),
                                                    SizedBox(height: 1.h),
                                                    Stack(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/semi_circle.png"),
                                                        const Positioned(
                                                          top: 3,
                                                          left: 30,
                                                          right: 80,
                                                          child: Icon(
                                                            Icons
                                                                .photo_camera_outlined,
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
                                IgnorePointer(
                                  ignoring: !enabledText,
                                  child: InkWell(
                                    onTap: _pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: concreteBold,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Upload Photo",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: gray,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                                  hintText: idType,
                                  items: ids),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Upload ID",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 40.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        ignoring: !enabledText,
                                        child: InkWell(
                                          onTap: _uploadIdType,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: alto,
                                                border: base64IdCardError
                                                    ? Border.all(
                                                        width: 1,
                                                        color: Colors.red)
                                                    : Border.all(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              width: 25.w,
                                              child: Text(
                                                _idImage != null
                                                    ? _idImage!.path
                                                        .split("/")
                                                        .last
                                                    : "Choose File",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: base64IdCardError
                                                        ? Colors.red
                                                        : gray,
                                                    fontFamily: "Montserrat",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4.h),
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
                                                  arguments: listOfImage[1]);
                                            }
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11.sp,
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
                            Text(
                              "Upload Utility Bill",
                              style: TextStyle(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat"),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 40.w,
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
                                                border: base64UtilityBillError
                                                    ? Border.all(
                                                        width: 1,
                                                        color: Colors.red)
                                                    : Border.all(width: 0),
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
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color:
                                                        base64UtilityBillError
                                                            ? Colors.red
                                                            : gray,
                                                    fontFamily: "Montserrat",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4.h),
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
                                                  arguments: listOfImage[2]);
                                            }
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11.sp,
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
                                        if (docs.currentState!.validate()) {
                                          if (base64IdCard == null) {
                                            setState(() {
                                              base64IdCardError = true;
                                            });
                                          }
                                          var connectivityResult =
                                              await (Connectivity()
                                                  .checkConnectivity());
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            documentsBloc.add(
                                              SaveDocument(
                                                documentRequest: DocumentRequest(
                                                    idDocumentImage: base64IdCard !=
                                                            null
                                                        ? DocumentImage(
                                                            encodedUpload:
                                                                base64IdCard,
                                                            name:
                                                                "Document Image")
                                                        : null,
                                                    idTypeId: idTypeId,
                                                    idNumber: idNumber.text,
                                                    passportPhotographImage:
                                                        base64Profile != null
                                                            ? ProfileImage(
                                                                encodedUpload:
                                                                    base64Profile,
                                                                name:
                                                                    "profile image")
                                                            : null,
                                                    utilityBillImage:
                                                        base64UtilityBill !=
                                                                null
                                                            ? UtilityBillImage(
                                                                encodedUpload:
                                                                    base64UtilityBill,
                                                                name:
                                                                    "Utitity Image")
                                                            : null),
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
                                      title: "Save",
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
                            onTap: () => setState(() {
                                  enabledText = true;
                                  images = [];
                                  viewImage = false;
                                }),
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
