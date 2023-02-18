// import 'package:flutter/material.dart';
// import 'package:rosabon/bloc/auth/bvn/bvn_bloc.dart';
// import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
// import 'package:rosabon/bloc/auth/director/director_bloc.dart';
// import 'package:rosabon/model/request_model/director_resquest.dart';
// import 'package:rosabon/model/request_model/more_detail_request.dart';
// import 'package:rosabon/session_manager/session_manager.dart';
// import 'package:rosabon/ui/profiles/corprate_profile/widget/more_details_widget.dart';
// import 'package:rosabon/ui/views/shared/app_colors.dart';
// import 'package:rosabon/ui/widgets/app_button.dart';
// import 'package:rosabon/ui/widgets/pin_code.dart';
// import 'package:sizer/sizer.dart';

// class MoredetailScreen extends StatefulWidget {
//   const MoredetailScreen({Key? key}) : super(key: key);

//   @override
//   State<MoredetailScreen> createState() => _MoredetailScreenState();
// }

// class _MoredetailScreenState extends State<MoredetailScreen> {
//   ValueNotifier<bool> isLoading = ValueNotifier(false);
//   late BvnBloc bvnBloc;
//   late CompanyDocumentsBloc companyDocumentsBloc;
//   late DirectorBloc directorBloc;
//   // var personalKey = GlobalKey<FormState>();

//   // var firstName = TextEditingController();
//   // var lastName = TextEditingController();
//   // var middleName = TextEditingController();
//   // var address = TextEditingController();
//   // var email = TextEditingController();
//   // var mobileNumber = TextEditingController();
//   // var bvnNumber = TextEditingController();
//   // var customerId = TextEditingController();

//   // var date = TextEditingController();

//   List<MoreDetailsWidget> director = [];
//   @override
//   void initState() {
//     directorForm();
//     bvnBloc = BvnBloc();
//     companyDocumentsBloc = CompanyDocumentsBloc();
//     directorBloc = DirectorBloc();
//     super.initState();
//   }

//   void directorForm() {
//     setState(() {
//       int i = director.length + 1;
//       int v = director.length;
//       bool error = false;

//       var chapter = MoreDetailRequest();

//       director.add(MoreDetailsWidget(
//         chapter: chapter,
//         title: "Director $i",
//         errorvalue: error,
//         intvalue: i,
//         director: director,
//         finalvalue: v,
//         onSave: () => onSave(),
//         onDelete: () => onDelete(chapter),
//       ));
//     });
//   }

//   void addForm() {
//     setState(() {
//       setState(() {
//         int i = director.length + 1;
//         int v = director.length;
//         bool error = false;

//         var chapter = MoreDetailRequest();

//         director.add(MoreDetailsWidget(
//           chapter: chapter,
//           title: "Director $i",
//           errorvalue: error,
//           intvalue: i,
//           finalvalue: v,
//           onSave: () => onSave(),
//           onDelete: () => onDelete(chapter),
//         ));
//       });
//     });
//   }

//   void onDelete(MoreDetailRequest chapter) {
//     setState(() {
//       int i = director.length - 1;
//       var find = director.firstWhere((it) => it.chapter == chapter);
//       print(find);
//       if (find != null) director.removeAt(director.indexOf(find));
//     });
//   }

//   void onSave() async {
//     // _MoredetailScreenState
//     FocusScope.of(context).requestFocus(FocusNode());
//     print(director);
//     if (director.isNotEmpty) {
//       var allValid = true;
//       director.forEach((form) => allValid = allValid && form.isValid()
//           // form.errorvalue()
//           );
//       if (allValid) {
//         var data = director
//             .map((it) => {
//                   "firstName": it.chapter!.firstName,
//                   "lastName": it.chapter!.lastName,
//                   "middleName": it.chapter!.middleName,
//                   "email": it.chapter!.email,
//                   "phone": it.chapter!.phone,
//                   "address": it.chapter!.address,

//                   "idType": it.chapter!.idType == "Driver’s License"
//                       ? "DRIVER_LICENSE"
//                       : it.chapter!.idType == "National ID Card"
//                           ? "NATIONAL_IDENTITY_CARD"
//                           : it.chapter!.idType == "International Passport"
//                               ? "INTERNATIONAL_PASSPORT"
//                               : "VOTER_CARD",
//                   "idNumber": it.chapter!.idNumber,
//                   "bvn": it.chapter!.bvn,
//                   "idDocumentImage": {
//                     "encodedUpload": it.chapter!.idDocumentImage!.encodedUpload,
//                     "name": "Profile Pic"
//                   },
//                   "passportImage": {
//                     "encodedUpload": it.chapter!.passportImage!.encodedUpload,
//                     "name": "Profile Pic"
//                   }

//                   // "phoneNumber": it.chapter!.idType,
//                 })
//             .toList();

//         try {
//           directorBloc.add(SaveDirector(directorRequest: data));
//         } catch (error) {}
//       } else {
//         setState(() {
//           isLoading.value = false;
//         });
//       }
//     }
//     setState(() {
//       isLoading.value = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(80.0),
//           child: Container(
//             decoration: const BoxDecoration(boxShadow: [
//               BoxShadow(
//                   color: concreteLight,
//                   offset: Offset(0, 2.0),
//                   blurRadius: 24.0)
//             ]),
//             child: AppBar(
//               backgroundColor: Colors.white,
//               shadowColor: deepKoamaru,
//               elevation: 0,
//               leading: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.black,
//                   )),
//               leadingWidth: 48.0,
//               centerTitle: false,
//               titleSpacing: 0,
//               title: const Text("More Details",
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(top: 20.0),
//           child: ListView(
//             // // shrinkWrap: true,
//             // physics: const ScrollPhysics(),
//             // addAutomaticKeepAlives: true,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: InkWell(
//                   onTap: addForm,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: const [
//                         Icon(
//                           Icons.add_circle_outline_sharp,
//                           color: deepKoamaru,
//                         ),
//                         Text("Add More",
//                             style: TextStyle(
//                                 color: deepKoamaru,
//                                 fontSize: 12,
//                                 fontFamily: "Montserrat",
//                                 fontWeight: FontWeight.w500))
//                       ]),
//                 ),
//               ),
//               ListView.builder(
//                 itemCount: director.length,
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 addAutomaticKeepAlives: true,
//                 itemBuilder: (context, index) => director[index],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
