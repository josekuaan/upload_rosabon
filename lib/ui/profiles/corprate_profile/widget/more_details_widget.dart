// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rosabon/bloc/auth/bvn/bvn_bloc.dart';
// import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
// import 'package:rosabon/bloc/auth/director/director_bloc.dart';
// import 'package:rosabon/model/request_model/bvn_request.dart';
// import 'package:rosabon/model/request_model/more_detail_request.dart';
// import 'package:rosabon/session_manager/session_manager.dart';
// import 'package:rosabon/ui/views/shared/app_colors.dart';
// import 'package:rosabon/ui/widgets/app_button.dart';
// import 'package:rosabon/ui/widgets/app_dropdown.dart';
// import 'package:rosabon/ui/widgets/app_input_field.dart';
// import 'package:rosabon/ui/widgets/app_num.dart';
// import 'package:rosabon/ui/widgets/pin_code.dart';
// import 'package:rosabon/ui/widgets/pop_message.dart';
// import 'package:sizer/sizer.dart';

// class MoreDetailsWidget extends StatefulWidget {
//   final String? title;
//   final MoreDetailRequest? chapter;
//   final List<dynamic>? director;
//   final state = _MoreDetailsWidgetState();
//   int? finalvalue;
//   int? intvalue;
//   bool? errorvalue;
//   Function()? onDelete;
//   Function()? onSave;

//   MoreDetailsWidget(
//       {Key? key,
//       this.chapter,
//       this.title,
//       this.errorvalue,
//       this.director,
//       this.intvalue,
//       this.onDelete,
//       this.onSave,
//       this.finalvalue})
//       : super(key: key);
//   @override
//   State<MoreDetailsWidget> createState() => state;
//   bool isValid() => state.validate();
//   bool errortemp() => state.errortemp();
// }

// class _MoreDetailsWidgetState extends State<MoreDetailsWidget> {
//   ValueNotifier<bool> isLoading = ValueNotifier(false);
//   late BvnBloc bvnBloc;
//   late CompanyDocumentsBloc companyDocumentsBloc;
//   late DirectorBloc directorBloc;
//   final form = GlobalKey<FormState>();
//   var bvnNumber = TextEditingController();
//   String IdType = "National ID Card";
//   bool _customTileExpanded = false;
//   String initialval = "Male";
//   String? pin;
//   bool veryPhone = false;
//   bool enabledText = false;
//   String? base64Profile;
//   File? _pickedImage;
//   bool validate() {
//     var valid = form.currentState!.validate();
//     if (valid) form.currentState!.save();
//     return valid;
//   }

//   bool errortemp() {
//     bool? valid = widget.errorvalue;
//     return valid!;
//   }

//   @override
//   void initState() {
//     bvnBloc = BvnBloc();
//     companyDocumentsBloc = CompanyDocumentsBloc();
//     directorBloc = DirectorBloc();
//     super.initState();
//   }

//   _pickImage() async {
//     print("object");
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 25,
//       );
//       setState(() {
//         _pickedImage = File(pickedFile!.path);
//         base64Profile = base64Encode(_pickedImage!.readAsBytesSync());
//         widget.chapter!.base64Profile = base64Profile;
//       });
//     } catch (e) {
//       print(e);
//       setState(() {
//         // error = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.finalvalue!);
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<DirectorBloc, DirectorState>(
//           bloc: directorBloc,
//           listener: (context, state) {
//             print(state);
//             if (state is DirectorLoading) {
//               print("=================");
//               setState(() {
//                 isLoading.value = true;
//               });
//             }

//             if (state is DirectorSuccess) {
//               isLoading.value = false;
//               setState(() {});
//             }
//           },
//         ),
//         BlocListener<BvnBloc, BvnState>(
//           bloc: bvnBloc,
//           listener: (context, state) {
//             if (state is BvnLoading) {
//               isLoading.value = true;
//             }
//             if (state is BvnSuccess) {
//               isLoading.value = false;
//               showDialog(
//                   context: context,
//                   builder: (_) {
//                     return AlertDialog(
//                         insetPadding:
//                             const EdgeInsets.symmetric(horizontal: 25),
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 18),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         title: const Icon(
//                           Icons.info,
//                           color: deepKoamaru,
//                           size: 50,
//                         ),
//                         content: SizedBox(
//                           height: 25.h,
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 width: 250,
//                                 child: Stack(
//                                   children: [
//                                     Positioned(
//                                       // top: 70,
//                                       right: 20,
//                                       child: Image.asset(
//                                         "assets/images/box.png",
//                                         color: Colors.blue,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     const SizedBox(
//                                       height: 50,
//                                       width: 50,
//                                       // color: Colors.black,
//                                     ),
//                                     Positioned(
//                                       top: 25,
//                                       left: 20,
//                                       child: Image.asset(
//                                         "assets/images/polygon3.png",
//                                         color: Colors.blue,
//                                         alignment: Alignment.bottomRight,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Text(
//                                 "Your Bank Details  have been updated",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: "Montserrat"),
//                               ),
//                               const Text(
//                                 "successfully",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: "Montserrat"),
//                               ),
//                               const SizedBox(height: 20),
//                               Appbutton(
//                                 onTap: () => Navigator.pop(context),
//                                 title: "Ok",
//                                 textColor: Colors.white,
//                                 backgroundColor: deepKoamaru,
//                               )
//                             ],
//                           ),
//                         ));
//                   });
//             }
//             // setState(() {
//             //   _tabcontroller.index = 1;
//             // });
//             if (state is BvnError) {
//               PopMessage().displayPopup(
//                   context: context, text: state.error, type: PopupType.failure);
//               isLoading.value = false;
//             }
//           },
//         )
//       ],
//       child: Column(
//         children: [
//           Theme(
//             data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//             child: ExpansionTile(
//               title: Text(widget.title!,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontFamily: "Montserrat",
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   )),
//               trailing: _customTileExpanded
//                   ? const Icon(Icons.keyboard_arrow_down_rounded,
//                       size: 25, color: Colors.black)
//                   : const Icon(Icons.arrow_forward_ios,
//                       size: 15, color: Colors.black),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Form(
//                     key: form,
//                     child: SizedBox(
//                       height: widget.chapter!.enabledText! ? 150.h : 130.h,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "First Name",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.firstName = val,
//                             hintText: "Susan",
//                             enabled: widget.chapter!.enabledText,
//                             validator: RequiredValidator(
//                                 errorText: 'First name is required'),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "Middle Name",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.middleName = val,
//                             enabled: widget.chapter!.enabledText,
//                             hintText: "Micheal",
//                             // validator: RequiredValidator(
//                             //     errorText: 'this field is required'),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "Last Name",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 1.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.lastName = val,
//                             hintText: "Wyne",
//                             enabled: widget.chapter!.enabledText,
//                             validator: RequiredValidator(
//                                 errorText: 'Last name is required'),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "Address",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.address = val,
//                             hintText: "",
//                             enabled: widget.chapter!.enabledText,
//                             validator: RequiredValidator(
//                                 errorText: 'Address is required'),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "Email Address",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             hintText: "hr@gmail.com",
//                             enabled: widget.chapter!.enabledText,
//                             validator: MultiValidator([
//                               RequiredValidator(
//                                   errorText:
//                                       'Email is required, please provide a valid email'),
//                               EmailValidator(
//                                   errorText:
//                                       'Email is invalid, please provide a valid email'),
//                             ]),
//                             onSave: (val) => widget.chapter!.email = val,
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "Phone Number",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.phoneNumber = val,
//                             hintText: "+2344893836",
//                             enabled: widget.chapter!.enabledText,
//                             textInputType: TextInputType.phone,
//                             validator: RequiredValidator(
//                                 errorText: 'Phone number is required'),
//                           ),
//                           Text(
//                             "Please provide the phone number tied to your BVN",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "BVN",
//                             style: TextStyle(
//                                 color: Theme.of(context).dividerColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Montserrat"),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             controller: bvnNumber,
//                             onSave: (val) => widget.chapter!.bvn = val,
//                             hintText: "22244893836",
//                             enabled: widget.chapter!.enabledText,
//                             textInputType: TextInputType.phone,
//                             validator: RequiredValidator(
//                                 errorText: 'This field is required'),
//                           ),
//                           SizedBox(height: 1.h),
//                           enabledText
//                               ? Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 5.w,
//                                       height: 2.h,
//                                       child: IgnorePointer(
//                                         ignoring: !enabledText,
//                                         child: Checkbox(
//                                           value: veryPhone,
//                                           onChanged: (bool? value) {
//                                             setState(() {
//                                               veryPhone = value!;
//                                             });
//                                             bvnBloc.add(BVN(
//                                                 bvnRequest: BvnRequest(
//                                                     id: bvnNumber.text,
//                                                     isSubjectConsent: true)));
//                                           },
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4)),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 3.w),
//                                     Text(
//                                       "Verify BVN",
//                                       style: TextStyle(
//                                           color: Theme.of(context).dividerColor,
//                                           fontSize: 10.sp,
//                                           fontFamily: "Montserrat"),
//                                     ),
//                                   ],
//                                 )
//                               : Container(),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "ID Type",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           IgnorePointer(
//                             ignoring: !widget.chapter!.enabledText!,
//                             child: AppDropDown(
//                                 onChanged: (dynamic val) {
//                                   setState(() {
//                                     IdType = val;
//                                     widget.chapter!.idType = val;
//                                   });
//                                 },
//                                 dropdownValue: "",
//                                 hintText: "",
//                                 items: const <dynamic>[
//                                   {"name": "National ID Card"},
//                                   {"name": "Driver’s License"},
//                                   {"name": "International Passport"},
//                                   {"name": "Voter’s Card"}
//                                 ]),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Text(
//                             "ID Number",
//                             style: TextStyle(
//                               color: Theme.of(context).dividerColor,
//                               fontFamily: "Montserrat",
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           AppInputField(
//                             onSave: (val) => widget.chapter!.idNumber = val,
//                             hintText: "",
//                             enabled: widget.chapter!.enabledText,
//                             validator: RequiredValidator(
//                                 errorText: 'This field is required'),
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Row(
//                             children: [
//                               IgnorePointer(
//                                 // ignoring: enabledText,
//                                 child: CircleAvatar(
//                                   backgroundColor: concreteLight,
//                                   backgroundImage: _pickedImage != null
//                                       ? FileImage(_pickedImage!)
//                                       : null,
//                                   radius: 45,
//                                   child: _pickedImage != null
//                                       ? Container()
//                                       : Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Image.asset(
//                                                 "assets/images/user.png",
//                                                 scale: 0.7),
//                                             const SizedBox(height: 10),
//                                             Stack(
//                                               children: [
//                                                 Image.asset(
//                                                     "assets/images/semi_circle.png"),
//                                                 const Positioned(
//                                                   top: 3,
//                                                   left: 30,
//                                                   right: 80,
//                                                   child: Icon(
//                                                     Icons.photo_camera_outlined,
//                                                     size: 18,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),

//                                             // SizedBox(height: 2)
//                                           ],
//                                         ),
//                                 ),
//                               ),
//                               SizedBox(height: 1.5.h),
//                               InkWell(
//                                 onTap: _pickImage,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 20),
//                                   decoration: BoxDecoration(
//                                       color: concreteBold,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Text(
//                                     "Upload Photo",
//                                     style: TextStyle(
//                                         fontSize: 14.sp,
//                                         color: gray,
//                                         fontFamily: "Montserrat",
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 4.h),
//                           widget.finalvalue! > 0
//                               ? widget.chapter!.enabledText!
//                                   ? Column(children: [
//                                       ValueListenableBuilder(
//                                           valueListenable: isLoading,
//                                           builder: (context, bool val, _) {
//                                             print("000000000000000000");
//                                             return Appbutton(
//                                               onTap: widget.onSave
//                                               // print(widget.onSave);

//                                               // setState(() {
//                                               //   enabledText = !enabledText;
//                                               // });
//                                               ,
//                                               buttonState: val
//                                                   ? AppButtonState.loading
//                                                   : AppButtonState.idle,
//                                               title: "Save",
//                                               textColor: Colors.white,
//                                               backgroundColor: deepKoamaru,
//                                             );
//                                           }),
//                                       const SizedBox(height: 20),
//                                       Appbutton(
//                                         onTap: () {
//                                           print(widget.onDelete);
//                                           widget.onDelete;
//                                         },

//                                         // setState(() {
//                                         //   _customTileExpanded =
//                                         //       !_customTileExpanded;
//                                         // }),
//                                         title: "Delete Director",
//                                         outlineColor: deepKoamaru,
//                                         textColor: gray,
//                                       )
//                                     ])
//                                   : Appbutton(
//                                       onTap: () {
//                                         setState(() {
//                                           widget.chapter!.enabledText =
//                                               !widget.chapter!.enabledText!;
//                                         });
//                                       },
//                                       title: "Edit",
//                                       textColor: Colors.white,
//                                       backgroundColor: deepKoamaru)
//                               : !widget.chapter!.enabledText!
//                                   ? Appbutton(
//                                       onTap: () {
//                                         print(!widget.chapter!.enabledText!);
//                                         if (widget.chapter!.enabledText !=
//                                             true) {
//                                           companyDocumentsBloc
//                                               .add(const CompanyOtp());
//                                           pinCode(
//                                                   context,
//                                                   "Enter OTP sent to your E-mail",
//                                                   enabledText)
//                                               .then((value) {
//                                             setState(() {
//                                               widget.chapter!.enabledText =
//                                                   value["enabledText"] ?? false;
//                                               SessionManager().otpVal =
//                                                   value["pin"];
//                                               pin = value["pin"] ?? "";
//                                             });
//                                           });
//                                         } else {
//                                           widget.chapter!.enabledText =
//                                               !widget.chapter!.enabledText!;
//                                           setState(() {
//                                             enabledText = !enabledText;
//                                           });
//                                         }
//                                       },
//                                       title: "Edit",
//                                       textColor: Colors.white,
//                                       backgroundColor: deepKoamaru)
//                                   : Column(children: [
//                                       Appbutton(
//                                         onTap: widget.onSave,
//                                         // () {
//                                         //   print(widget.onSave);
//                                         //   widget.onSave!();
//                                         // },
//                                         // setState(() {
//                                         //   enabledText = !enabledText;
//                                         // });

//                                         title: "Save",
//                                         textColor: Colors.white,
//                                         backgroundColor: deepKoamaru,
//                                       ),
//                                       const SizedBox(height: 20),
//                                       Appbutton(
//                                         onTap: () => Navigator.pop(context),
//                                         // setState(() {
//                                         //   _customTileExpanded =
//                                         //       !_customTileExpanded;
//                                         // }),
//                                         title: "Cancel",
//                                         outlineColor: deepKoamaru,
//                                         textColor: gray,
//                                       )
//                                     ])
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//               onExpansionChanged: (bool expanded) {
//                 setState(() => _customTileExpanded = expanded);
//               },
//             ),
//           ),
//           const Divider(height: 1, color: alto)
//         ],
//       ),
//     );
//   }
// }
