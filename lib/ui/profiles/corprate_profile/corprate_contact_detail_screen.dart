import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/bloc/auth/bank/bank_bloc.dart';
import 'package:rosabon/bloc/auth/companyDocments/company_documents_bloc.dart';
import 'package:rosabon/bloc/auth/companyKyc/company_kyc_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/model/request_model/company_details_update_request.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pin_code.dart';
import 'package:sizer/sizer.dart';

class CorprateContactDetailScreen extends StatefulWidget {
  const CorprateContactDetailScreen({Key? key}) : super(key: key);

  @override
  State<CorprateContactDetailScreen> createState() =>
      _CorprateContactDetailScreenState();
}

class _CorprateContactDetailScreenState
    extends State<CorprateContactDetailScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  late CompanyKycBloc companyKycBloc;
  late UserBloc userBloc;
  var contactKey = GlobalKey<FormState>();
  var mobileNumber = TextEditingController();
  var contactPersonFirstName = TextEditingController();
  var contactPersonLast = TextEditingController();
  var contactPersonEmail = TextEditingController();
  bool enabledText = false;
  String pin = "";
  @override
  void initState() {
    userBloc = UserBloc();
    companyKycBloc = CompanyKycBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserResponse;

    contactPersonFirstName.text = user.company!.contactFirstName ?? "";
    contactPersonLast.text = user.company!.contactLastName ?? "";
    contactPersonEmail.text = user.email ?? "";
    mobileNumber.text = user.phone ?? "";

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
            title: const Text("Contact Person Details",
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
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: contactKey,
            child: ListView(
              children: [
                Text(
                  "Contact Person’s First Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: contactPersonFirstName,
                  hintText: "",
                  validator:
                      RequiredValidator(errorText: 'first name is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Contact Person’s Last Name",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: contactPersonLast,
                  hintText: "",
                  validator:
                      RequiredValidator(errorText: 'Last name is required'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Email Address",
                  style: TextStyle(
                    color: Theme.of(context).dividerColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                IgnorePointer(
                  ignoring: true,
                  child: AppInputField(
                    controller: contactPersonEmail,
                    hintText: "",
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText:
                              'Email is required, please provide a valid email'),
                      EmailValidator(
                          errorText:
                              'Email is invalid, please provide a valid email'),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Phone Number",
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
                  hintText: "",
                  textInputType: TextInputType.phone,
                  validator:
                      RequiredValidator(errorText: 'Phone number is required'),
                ),
                SizedBox(height: 8.h),
                enabledText
                    ? ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, bool val, _) {
                          return Appbutton(
                            onTap: () {
                              companyKycBloc.add(CompanyUpdate(
                                  companyDetailsUpdateequest:
                                      CompanyDetailsUpdateequest(
                                          phone: mobileNumber.text,
                                          contactFirstName:
                                              contactPersonFirstName.text,
                                          contactLastName:
                                              contactPersonLast.text,
                                          email: contactPersonEmail.text)));
                            },
                            buttonState: val
                                ? AppButtonState.loading
                                : AppButtonState.idle,
                            title: user.company!.contactFirstName != null
                                ? "Update"
                                : "Save",
                            textColor: Colors.white,
                            backgroundColor: deepKoamaru,
                          );
                        })
                    : Appbutton(
                        onTap: () {
                          userBloc.add(const GeneralOtp(
                              message: "Edit Contact Details"));
                          pinCode(context, "Enter OTP sent to your email.",
                                  enabledText)
                              .then((value) {
                            setState(() {
                              enabledText = value["enabledText"];
                              pin = value["pin"] ?? "";
                            });
                          });
                        },
                        title: "Edit",
                        textColor: Colors.white,
                        backgroundColor: deepKoamaru),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
