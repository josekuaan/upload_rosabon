import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/plan_history_response.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/model/response_models/transaction_response.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/repository/wallet_repository.dart';
import 'package:rosabon/ui/dashboard/statement/widget/pdf_document_api.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/date_picker.dart';
import 'package:rosabon/ui/widgets/plan_dropdown.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rosabon/ui/widgets/pop_message.dart';

class Statement extends StatefulWidget {
  const Statement({Key? key}) : super(key: key);

  @override
  State<Statement> createState() => _StatementState();
}

class _StatementState extends State<Statement> with TickerProviderStateMixin {
  final tab1 = GlobalKey<FormState>();
  final tab2 = GlobalKey<FormState>();
  late TabController _tabcontroller;
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final walletstartDate = TextEditingController();
  final walletendDate = TextEditingController();
  late CreatePlanBloc createPlanBloc;
  late WalletBloc walletBloc;
  Plan? plan;
  int? tabNumber = 0;
  String currency = "";
  final pdf = pw.Document();
  List<Plan> plans = [];
  List<History> history = [];
  List<Transaction> transaction = [];

  @override
  void initState() {
    _tabcontroller = TabController(vsync: this, length: 2);
    walletBloc = WalletBloc();
    createPlanBloc = CreatePlanBloc();
    createPlanBloc.add(const FetchPlan());

    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        title: "Statement",
      ),
      body: BlocListener(
          bloc: createPlanBloc,
          listener: (context, state) {
            if (state is FetchHistory) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()));
            }
            if (state is PlanHistorySuccess) {
              Navigator.pop(context);
              // setState(() {
              history = state.planHistoryResponse.history!;
              // });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose a timeframe for your statement",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 20,
                      width: 180,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: alto),
                        ),
                      ),
                      child: TabBar(
                        controller: _tabcontroller,
                        // unselectedLabelColor: Colors.red,
                        // isScrollable: true,
                        // indicatorSize: TabBarIndicatorSize.label,
                        onTap: (int val) {
                          tabNumber = val;
                        },
                        indicator: const UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 2.5, color: mineShaft),
                            insets: EdgeInsets.only(right: 40.0, top: 20)),
                        labelColor: alto,
                        indicatorWeight: 4.0,
                        // indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                        labelPadding: EdgeInsets.zero,
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.0),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Plan",
                                  style: TextStyle(
                                      color: mineShaft,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.0),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Wallet",
                                  style: TextStyle(
                                      color: mineShaft,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: TabBarView(
                        controller: _tabcontroller,
                        children: [
                          Form(
                            key: tab1,
                            child: FutureBuilder<PlanResponse>(
                                future: ProductRepository().getPlan(),
                                builder: (context, snapShot) {
                                  if (snapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapShot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapShot.hasError) {
                                      return const Center(
                                          child: Text("Has error"));
                                    } else if (snapShot.hasData) {
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              children: [
                                                PlanDropDown(
                                                    onChanged: (Plan? val) {
                                                      plan = val;
                                                      currency =
                                                          val!.currency!.name!;

                                                      createPlanBloc.add(
                                                          FetchPlanHistory(
                                                              id: val.id!));
                                                    },
                                                    dropdownValue: "",
                                                    hintText: "",
                                                    items: plans =
                                                        snapShot.data!.plans!),
                                                const SizedBox(height: 20),
                                                Text(
                                                  "Start Date",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                DatePicker(
                                                    controller: startDate,
                                                    hintText: "DD/MM/YYY",
                                                    validator: RequiredValidator(
                                                        errorText:
                                                            "Please Pick your Date of Birth")),
                                                const SizedBox(height: 20),
                                                Text(
                                                  "End Date",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                DatePicker(
                                                    controller: endDate,
                                                    hintText: "DD/MM/YYY",
                                                    validator: RequiredValidator(
                                                        errorText:
                                                            "Please Pick your Date of Birth")),
                                              ],
                                            ),
                                          ),
                                          Appbutton(
                                            onTap: () async {
                                              if (tab1.currentState!
                                                  .validate()) {
                                                if (history.isEmpty) {
                                                  PopMessage().displayPopup(
                                                      context: context,
                                                      text:
                                                          "You do no have history for this plan",
                                                      type: PopupType.failure);
                                                }
                                                var dt1 =
                                                    DateFormat("dd-MM-yyyy")
                                                        .parse(startDate.text);
                                                var dt2 =
                                                    DateFormat("dd-MM-yyyy")
                                                        .parse(endDate.text);

                                                // DateTime dt2 =
                                                //     inputFormat.parse(endDate.text);
                                                List<History> planHistory = [];
                                                for (var el in history) {
                                                  if ((dt1.compareTo(el
                                                              .dateOfTransaction!) ==
                                                          0 ||
                                                      dt1.isBefore(el
                                                              .dateOfTransaction!) &&
                                                          dt2.compareTo(el
                                                                  .dateOfTransaction!) ==
                                                              0 ||
                                                      dt2.isAfter(el
                                                          .dateOfTransaction!))) {
                                                    planHistory.add(el);
                                                  }
                                                }

                                                final pdfFile =
                                                    await PdfducumentApi
                                                        .generatePlanPdf(
                                                            history, currency);

                                                await OpenFile.open(
                                                    pdfFile.path);
                                              }
                                            },
                                            title: "Download PDF",
                                            backgroundColor: deepKoamaru,
                                            textColor: Colors.white,
                                          )
                                        ],
                                      );
                                    }
                                  }
                                  return Container();
                                }),
                          ),
                          Form(
                              key: tab2,
                              child: FutureBuilder<TransactionResponse>(
                                future: WalletRepository()
                                    .fetchWalletTransactions(),
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const SizedBox(
                                          child:
                                              Center(child: Text("An Error")));
                                    } else if (snapshot.hasData) {
                                      List<Transaction> transaction =
                                          snapshot.data!.transaction!;

                                      return Column(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              children: [
                                                Text(
                                                  "Start Date",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                DatePicker(
                                                    controller: walletstartDate,
                                                    hintText: "DD/MM/YYY",
                                                    validator: RequiredValidator(
                                                        errorText:
                                                            "Please Pick your Date of Birth")),
                                                const SizedBox(height: 20),
                                                Text(
                                                  "End Date",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                DatePicker(
                                                    controller: walletendDate,
                                                    hintText: "DD/MM/YYY",
                                                    validator: RequiredValidator(
                                                        errorText:
                                                            "Please Pick your Date of Birth")),
                                              ],
                                            ),
                                          ),
                                          Appbutton(
                                            onTap: () async {
                                              if (transaction.isEmpty) {
                                                PopMessage().displayPopup(
                                                    context: context,
                                                    text:
                                                        "You are yet to perform any action.",
                                                    type: PopupType.failure);
                                              }
                                              if (tab2.currentState!
                                                  .validate()) {
                                                var dt1 = DateFormat(
                                                        "dd-MM-yyyy")
                                                    .parse(
                                                        walletstartDate.text);
                                                var dt2 = DateFormat(
                                                        "dd-MM-yyyy")
                                                    .parse(walletendDate.text);
                                                List<Transaction> statement =
                                                    [];

                                                for (var el in transaction) {
                                                  if ((dt1.compareTo(DateFormat(
                                                                  "dd-MM-yyyy")
                                                              .parse(el
                                                                  .transactionDate!)) ==
                                                          0 ||
                                                      dt1.isBefore(DateFormat("dd-MM-yyyy")
                                                              .parse(el
                                                                  .transactionDate!)) &&
                                                          dt2.compareTo(DateFormat("dd-MM-yyyy").parse(el.transactionDate!)) ==
                                                              0 ||
                                                      dt2.isAfter(DateFormat("dd-MM-yyyy")
                                                          .parse(el.transactionDate!)))) {
                                                    statement.add(el);
                                                  }
                                                }
                                                print(dt2);
                                                final pdfFile =
                                                    await PdfducumentApi
                                                        .generate(statement);
                                                await OpenFile.open(
                                                    pdfFile.path);
                                              }
                                            },
                                            title: "Download PDF",
                                            backgroundColor: deepKoamaru,
                                            textColor: Colors.white,
                                          )
                                        ],
                                      );
                                    }
                                  }
                                  return Container();
                                }),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<File> savePdf() async {
    // final pdf = pw.Document();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/${DateTime.now().toIso8601String()}.pdf");
    List<int> bytes = await pdf.save();
    file.writeAsBytesSync(bytes);
    await OpenFile.open(file.path);
    return file;
  }
}
