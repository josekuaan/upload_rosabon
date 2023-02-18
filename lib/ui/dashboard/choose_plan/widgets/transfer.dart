import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/request_model/transfer_request.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/payment_success.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_input_field.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/app_popup.dart';
import 'package:rosabon/ui/widgets/plan_dropdown.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final form = GlobalKey<FormState>();
  final amount = TextEditingController();
  late CreatePlanBloc createPlanBloc;
  List<Plan> plans = [];
  List<Plan> newPlans3 = [];
  Plan? plan;

  String selectPlan = "Plan 1";
  bool partialrollover = false;
  bool fullrollover = false;
  int? planId;
  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    createPlanBloc.add(const FetchPlan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as Plan;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Transfer"),
      body: BlocListener<CreatePlanBloc, CreatePlanState>(
        bloc: createPlanBloc,
        listener: (context, state) {
          if (state is PlanSuccessful) {
            // setState(() {
            plans = state.planResponse.plans!;
            // });
            List<Plan> newPlans = plans
                .where((a) => a.planStatus!.toUpperCase() == "ACTIVE")
                .toList();
            List<Plan> newPlans1 = newPlans
                .where(
                    (a) => a.interestReceiptOption!.toLowerCase() == "maturity")
                .toList();
            List<Plan> newPlans0 = newPlans1
                .where((a) => a.productPlan!.properties!.allowsTransfer == true)
                .toList();
            List<Plan> newPlans2 = newPlans0
                .where((a) => a.id!=map.id)
                .toList();
            setState(() {
              newPlans3 = newPlans2;
            });
          }
          if (state is PlanCreating) {
            setState(() {
              isLoading.value = true;
            });
          }

          if (state is InitPlanTransferSuccess) {
            setState(() {
              isLoading.value = false;
            });
            print(state.initPlanTransfer.toJson());
            appPopUp(
              context,
              state.initPlanTransfer.planAction!.message!,
              () {
                createPlanBloc.add(CompletePlanTransfer(
                    id: state.initPlanTransfer.planAction!.actionLogId!));
              },
              () => Navigator.pop(context),
            );
          }
          if (state is PlanTransferSuccess) {
            setState(() {
              isLoading.value = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentSuccess(
                  subTitle: "Your transfer was successful",
                  btnTitle: "Go Back to Plan",
                  callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(page: 2),
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is PlanTransferError) {
            setState(() {
              isLoading.value = false;
            });
            PopMessage().displayPopup(
                context: context,
                text: state.error.toString(),
                type: PopupType.failure);
          }
        },
        child: Form(
          key: form,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xfff8f9fb),
                        offset: Offset.fromDirection(2.0),
                        blurRadius: 24.0)
                  ],
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/medium_bg.PNG"))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    map.planName.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    map.planName ?? "",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Text(
                                map.planStatus ?? "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: jungleGreen,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Start Date",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    yMDDate(map.planSummary!.startDate!),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "End Date",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    yMDDate(map.planSummary!.endDate!),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(child: Image.asset("assets/images/line.png")),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Balance",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol} ${MoneyFormatter(amount: map.planSummary!.principal!).output.nonSymbol}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: deepKoamaru,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Select an active plan to transfer into",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PlanDropDown(
                    onChanged: (Plan? val) {
                      setState(() {
                        planId = val!.id!;
                        plan = val;
                      });
                    },
                    dropdownValue: "",
                    hintText: "",
                    items: newPlans3),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Amount to Send",
                  style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontFamily: "Montserrat"),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppInputField(
                  controller: amount,
                  // enabled: enabledText,
                  textInputType: TextInputType.phone,
                  hintText: amount.text,
                  validator: RequiredValidator(errorText: 'This is required'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      "Balance is ${NumberFormat.simpleCurrency(locale: Platform.localeName, name: map.currency!.name).currencySymbol} ${MoneyFormatter(amount: map.planSummary!.principal!).output.nonSymbol}")),
              const SizedBox(height: 60),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
                child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, bool val, _) {
                      return Appbutton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (form.currentState!.validate()) {
                            createPlanBloc.add(PlanTransfer(
                                transferRequest: TransferRequest(
                              amount: int.parse(amount.text),
                              plan: map.id,
                              planToReceive: planId,
                              planAction: "TRANSFER",
                              paymentType: null,
                              completed: true,
                            )));
                          }
                        },
                        buttonState:
                            val ? AppButtonState.loading : AppButtonState.idle,
                        title: "Submit",
                        backgroundColor: deepKoamaru,
                        textColor: Colors.white,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
