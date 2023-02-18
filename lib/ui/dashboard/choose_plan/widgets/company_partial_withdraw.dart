import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:dotted_border/dotted_border.dart';

class CompanyPartialWithdraw extends StatefulWidget {
  const CompanyPartialWithdraw({Key? key}) : super(key: key);

  @override
  State<CompanyPartialWithdraw> createState() => _CompanyPartialWithdrawState();
}

class _CompanyPartialWithdrawState extends State<CompanyPartialWithdraw> {
  final amount = TextEditingController();
  final reasonforwithdrawal = TextEditingController();

  String selectReason = "others";
  String selectbeneficiary = "Zenith Bank - 2210347577";
  bool partialwithdraw = false;
  bool fullwithdraw = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Withdraw to  Bank"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Available Balance :",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat"),
                    ),
                    Text(
                      "₦ 1,500,000",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat"),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  "Withdrawal amount",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
                const SizedBox(height: 8),
                AppInputField(
                  controller: amount,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: "₦ 0.00",
                  validator: RequiredValidator(errorText: 'This is required'),
                ),
                const SizedBox(height: 20),
                DottedBorder(
                  padding: const EdgeInsets.all(20),
                  color: gray,
                  borderType: BorderType.Rect,
                  dashPattern: const [10, 5, 10, 5, 10, 5],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "Upload withdrawal mandate instruction",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text("jpg, PDF. 2MB")
                        ],
                      ),
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: alto,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Choose File",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 8,
                                color: gray,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      )
                    ],
                  ), //optional
                ),
                const SizedBox(height: 10),
                const Text(
                  "Letter must be on a company’s letter head and also carry bank account details",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 8,
                    color: gray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccess(
                            subTitle: "Withdrawal Requested Successfully",
                            btnTitle: "Ok",
                            callback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(page: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            color: deepKoamaru,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Appbutton(
                      onTap: (() => Navigator.pop(context)),
                      title: "Cancel",
                      outlineColor: deepKoamaru,
                    ),
                    const SizedBox(height: 20),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
