import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/model/response_models/plan_response.dart';
import 'package:rosabon/repository/product_repository.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/pay_with_card.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/plan_history.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/rollover.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/view_account_details.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rosabon/ui/widgets/app_drawer.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  final SessionManager _sessionManager = SessionManager();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late CreatePlanBloc createPlanBloc;
  List<Plan> plans = [];
  List<Plan> sortPlan = [];
  List<String> productCategory = [];
  String category = "";
  String startDate = "Start Date";
  String endDate = "End Date";
  String itemSelected = "";
  bool isSwitched = false;
  bool show = false;
  int limit = 2;
  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    createPlanBloc.add(const FetchPlan());
    super.initState();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, type) async {
    DateFormat formatter =
        DateFormat('yyyy-MM-dd'); //specifies day/month/year format
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (type == "Start Date") {
          startDate = formatter.format(picked);
          if (startDate.toLowerCase().toString() != "start date" &&
              endDate.toLowerCase().toString() != "end date") {
            filteByDate();
          }
        } else {
          endDate = formatter.format(picked);
          if (startDate.toLowerCase().toString() != "start date" &&
              endDate.toLowerCase().toString() != "end date") {
            filteByDate();
          }
        }
      });
    }
  }

  filter(String val) {
    setState(() {
      plans.sort((a, b) =>
          a.productCategory!.name!.toLowerCase().compareTo(val.toLowerCase()));
    });
    setState(() {});
  }

  filteByDate() {
    var dt2 = DateTime.parse(startDate);
    var dt1 = DateTime.parse(endDate);
    var tempPlan = [...sortPlan];
    List<Plan> temp = [];
    List<Plan> temp2 = [];

    for (var el in tempPlan) {
      if ((dt1.compareTo(el.planSummary!.startDate!) == 0 ||
          dt1.isBefore(el.planSummary!.startDate!) &&
              dt2.compareTo(el.planSummary!.endDate!) == 0 ||
          dt2.isAfter(el.planSummary!.endDate!))) {
        temp.add(el);
      } else {
        // temp.add(el);
      }
    }

    plans = temp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: deepKoamaru,
          elevation: 0,
          leading: InkWell(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Image.asset("assets/images/hamburgar.PNG")),
          leadingWidth: 50.0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        drawer: AppDrawer(map: _sessionManager.userRoleVal),
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () async {
            endDate = "End Date";
            startDate = "Start Date";
            createPlanBloc.add(const FetchPlan());
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const Text(
                          "Here are your Investments at a glance",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(page: 1))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.add_circle_outline_outlined,
                            color: deepKoamaru,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Add Plan",
                            style: TextStyle(
                              color: deepKoamaru,
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: softpeach,
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonFormField2<String>(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            )),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        "Choose Investment Category",
                        style: TextStyle(fontSize: 14),
                      ),
                      iconSize: 30,
                      buttonHeight: 55,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: productCategory
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) =>
                          value == null ? 'Field cannot be empty!' : null,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: const [
                            VerticalDivider(width: 1),
                            SizedBox(width: 20),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                      onChanged: (String? val) {
                        category = val!;

                        filter(val);
                      },
                      value: category.isNotEmpty ? category : null,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          color: softpeach,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const SizedBox(width: 3),
                            Text(endDate),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // const SizedBox(width: 5),
                                  const VerticalDivider(
                                      thickness: 2, color: alto),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    onPressed: () =>
                                        _selectDate(context, "End Date"),
                                    icon: const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 20),
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          color: softpeach,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const SizedBox(width: 3),
                            Text(startDate),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // const SizedBox(width: 5),
                                  const VerticalDivider(
                                      thickness: 2, color: alto),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    onPressed: () =>
                                        _selectDate(context, "Start Date"),
                                    icon: const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 20),
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: BlocConsumer<CreatePlanBloc, CreatePlanState>(
                    bloc: createPlanBloc,
                    builder: (context, state) {
                      if (state is Fetching) {
                        // show = true;
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is PlanSuccessful) {
                        show = false;
                        plans = state.planResponse.plans!;
                        sortPlan = state.planResponse.plans!;

                        if (plans.isNotEmpty) {
                          return SizedBox(
                            child: Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    addAutomaticKeepAlives: true,
                                    itemCount: plans.length,
                                    itemBuilder: (context, index) {
                                      // indexNo = index;
                                      if (index <= limit) {
                                        if (plans[index].planStatus ==
                                            "ACTIVE") {
                                          return InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, AppRouter.plandetail,
                                                arguments: state.planResponse
                                                    .plans![index]),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: const Color(
                                                          0xfff8f9fb),
                                                      offset:
                                                          Offset.fromDirection(
                                                              2.0),
                                                      blurRadius: 30.0)
                                                ],
                                              ),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            "assets/images/medium_bg.PNG"))),
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                  height: 15),
                                                              Container(
                                                                // width: MediaQuery.of(context).size.width*0.9,

                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.5,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            // width: MediaQuery.of(context).size.width*0.4,
                                                                            child:
                                                                                Text(
                                                                              state.planResponse.plans![index].planName ?? "",
                                                                              style: const TextStyle(fontSize: 14, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            state.planResponse.plans![index].planName ??
                                                                                "",
                                                                            style: const TextStyle(
                                                                                fontSize: 11,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.15,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            state.planResponse.plans![index].planStatus ??
                                                                                "",
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.green,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                          if (state.planResponse.plans![index].toppingUp ==
                                                                              true)
                                                                            const Text(
                                                                              'Topping up',
                                                                              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8, color: Colors.blue, fontFamily: "Montserrat", fontWeight: FontWeight.w500),
                                                                            ),
                                                                          if (state.planResponse.plans![index].planSummary!.withdrawalInProgress ==
                                                                              true)
                                                                            const Text(
                                                                              'Withdrawal in progress',
                                                                              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 6, color: Colors.blue, fontFamily: "Montserrat", fontWeight: FontWeight.w500),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        "Start Date",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        yMDDate(state
                                                                            .planResponse
                                                                            .plans![index]
                                                                            .planSummary!
                                                                            .startDate!),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      const Text(
                                                                        "End Date",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        yMDDate(state.planResponse.plans![index].planSummary!.endDate!)
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Center(
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/images/line.png")),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        "Balance",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      Text(
                                                                        "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: state.planResponse.plans![index].currency!.name).currencySymbol} ${MoneyFormatter(amount: state.planResponse.plans![index].planSummary!.principal!).output.nonSymbol}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                deepKoamaru,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      PopupMenuButton(
                                                                        itemBuilder:
                                                                            (context) {
                                                                          return <
                                                                              PopupMenuEntry>[
                                                                            PopupMenuItem<String>(
                                                                                value: '1',
                                                                                child: Column(
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Top Up',
                                                                                          style: TextStyle(
                                                                                            color: state.planResponse.plans![index].interestReceiptOption == "MATURITY" && state.planResponse.plans![index].productPlan!.properties!.allowsTopUp == true ? Colors.black : Colors.grey,
                                                                                            fontFamily: "Montserrat",
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        const Divider(color: alto),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                            PopupMenuItem<String>(
                                                                                value: '2',
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Transfer',
                                                                                      style: TextStyle(
                                                                                        color: state.planResponse.plans![index].allowsLiquidation == true ? Colors.black : Colors.grey,
                                                                                        fontFamily: "Montserrat",
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                    const Divider(color: alto),
                                                                                  ],
                                                                                )),
                                                                            PopupMenuItem<String>(
                                                                                value: '3',
                                                                                child: Column(
                                                                                  children: [
                                                                                    // if (state.planResponse.plans![index].allowsLiquidation == true)
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Withdraw',
                                                                                          style: TextStyle(
                                                                                            color: state.planResponse.plans![index].allowsLiquidation == true ? Colors.black : Colors.grey,
                                                                                            fontFamily: "Montserrat",
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        const Divider(color: alto),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                            PopupMenuItem<String>(
                                                                                value: '4',
                                                                                onTap: () => setState(() {
                                                                                      isSwitched = !isSwitched;
                                                                                    }),
                                                                                child: StatefulBuilder(builder: (context, state) {
                                                                                  return Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Auto rollover',
                                                                                            style: TextStyle(
                                                                                              fontFamily: "Montserrat",
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            // height: 0,
                                                                                            child: FlutterSwitch(
                                                                                              width: 60.0,
                                                                                              height: 30.0,
                                                                                              valueFontSize: 20.0,
                                                                                              toggleSize: 30.0,
                                                                                              value: isSwitched,
                                                                                              borderRadius: 15.0,
                                                                                              inactiveColor: alto,
                                                                                              padding: 2.0,
                                                                                              onToggle: (val) {
                                                                                                ProductRepository().autoRollover({
                                                                                                  "plan": plans[index].id,
                                                                                                  "planAction": "AUTO_ROLLOVER"
                                                                                                });
                                                                                                state(() {
                                                                                                  isSwitched = val;
                                                                                                });
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      const Divider(color: alto),
                                                                                    ],
                                                                                  );
                                                                                })),
                                                                            const PopupMenuItem<String>(
                                                                                value: '5',
                                                                                child: Text(
                                                                                  'History',
                                                                                  style: TextStyle(
                                                                                    fontFamily: "Montserrat",
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                )),
                                                                          ];
                                                                        },
                                                                        onSelected:
                                                                            (val) {
                                                                          if (val ==
                                                                              null)
                                                                            return;

                                                                          if (val ==
                                                                              "1") {
                                                                            Navigator.pushNamed(context,
                                                                                AppRouter.topup,
                                                                                arguments: state.planResponse.plans![index]);
                                                                          } else if (val ==
                                                                              "2") {
                                                                            if (state.planResponse.plans![index].allowsLiquidation ==
                                                                                true) {
                                                                              Navigator.pushNamed(context, AppRouter.transfer, arguments: state.planResponse.plans![index]);
                                                                            }
                                                                            //code here
                                                                          } else if (val ==
                                                                              "3") {
                                                                            if (state.planResponse.plans![index].allowsLiquidation ==
                                                                                true) {
                                                                              Navigator.pushNamed(context, AppRouter.withdraw, arguments: {
                                                                                "role": _sessionManager.userRoleVal,
                                                                                "plan": state.planResponse.plans![index]
                                                                              });
                                                                            }
                                                                            //code here
                                                                          }
                                                                          if (val ==
                                                                              "5") {
                                                                            if (state.planResponse.plans![index].interestReceiptOption == "MATURITY" &&
                                                                                state.planResponse.plans![index].productPlan!.properties!.allowsTopUp == true) {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => PlanHistory(id: state.planResponse.plans![index].id!, currency: state.planResponse.plans![index].currency!.name!),
                                                                                ),
                                                                              );
                                                                            }
                                                                            //code here
                                                                          } else {}
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "...",
                                                                          style: TextStyle(
                                                                              fontSize: 30,
                                                                              color: deepKoamaru,
                                                                              letterSpacing: 3,
                                                                              fontFamily: "Montserrat",
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else if (plans[index].planStatus ==
                                            "MATURED") {
                                          return InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, AppRouter.plandetail,
                                                arguments: state.planResponse
                                                    .plans![index]),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: const Color(
                                                          0xfff8f9fb),
                                                      offset:
                                                          Offset.fromDirection(
                                                              2.0),
                                                      blurRadius: 30.0)
                                                ],
                                              ),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            "assets/images/medium_bg.PNG"))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 15),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.5,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        state.planResponse.plans![index].planName ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Text(
                                                                        state.planResponse.plans![index].productPlan!.productName ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Text(
                                                                  state
                                                                          .planResponse
                                                                          .plans![
                                                                              index]
                                                                          .planStatus ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .blue,
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Start Date",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      yMDDate(state
                                                                          .planResponse
                                                                          .plans![
                                                                              index]
                                                                          .planSummary!
                                                                          .startDate!),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Text(
                                                                      "End Date",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      yMDDate(state
                                                                          .planResponse
                                                                          .plans![
                                                                              index]
                                                                          .planSummary!
                                                                          .endDate!),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Center(
                                                                child: Image.asset(
                                                                    "assets/images/line.png")),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Balance",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    Text(
                                                                      state
                                                                          .planResponse
                                                                          .plans![
                                                                              index]
                                                                          .planSummary!
                                                                          .principal
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              deepKoamaru,
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    PopupMenuButton(
                                                                      itemBuilder:
                                                                          (context) =>
                                                                              listpopup,
                                                                      onSelected:
                                                                          (val) {
                                                                        if (val ==
                                                                            null)
                                                                          return;

                                                                        if (val ==
                                                                            "1") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => RollOver(role: _sessionManager.userRoleVal, plan: state.planResponse.plans![index])));
                                                                        } else if (val ==
                                                                            "2") {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              AppRouter.transfer,
                                                                              arguments: state.planResponse.plans![index]);
                                                                        } else if (val ==
                                                                            "3") {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              AppRouter.withdraw,
                                                                              arguments: {
                                                                                "role": _sessionManager.userRoleVal,
                                                                                "plan": state.planResponse.plans![index]
                                                                              });
                                                                        }
                                                                        if (val ==
                                                                            "4") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => PlanHistory(id: state.planResponse.plans![index].id!, currency: state.planResponse.plans![index].currency!.name!)));
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "...",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                30,
                                                                            color:
                                                                                deepKoamaru,
                                                                            letterSpacing:
                                                                                3,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () => Navigator.pushNamed(
                                                context, AppRouter.plandetail,
                                                arguments: state.planResponse
                                                    .plans![index]),
                                            child: Column(
                                              children: [
                                                if (state
                                                        .planResponse
                                                        .plans![index]
                                                        .planStatus ==
                                                    "PENDING")
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: const Color(
                                                                0xfff8f9fb),
                                                            offset: Offset
                                                                .fromDirection(
                                                                    2.0),
                                                            blurRadius: 30.0)
                                                      ],
                                                    ),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  "assets/images/medium_bg.PNG"))),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            state.planResponse.plans![index].planName ??
                                                                                "",
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                          Text(
                                                                            state.planResponse.plans![index].planName ??
                                                                                "",
                                                                            style: const TextStyle(
                                                                                fontSize: 11,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        state.planResponse.plans![index].planStatus ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Colors
                                                                                .orange,
                                                                            fontFamily:
                                                                                "Montserrat",
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Text(
                                                                            "Start Date",
                                                                            style: TextStyle(
                                                                                fontSize: 11,
                                                                                color: deepKoamaru,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 5),
                                                                          Text(
                                                                            yMDDate(state.planResponse.plans![index].planSummary!.startDate!),
                                                                            style: const TextStyle(
                                                                                fontSize: 11,
                                                                                color: deepKoamaru,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          const Text(
                                                                            "End Date",
                                                                            style: TextStyle(
                                                                                fontSize: 11,
                                                                                color: deepKoamaru,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 5),
                                                                          Text(
                                                                            yMDDate(state.planResponse.plans![index].planSummary!.endDate!),
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
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  Center(
                                                                      child: Image
                                                                          .asset(
                                                                              "assets/images/line.png")),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Text(
                                                                            "Balance",
                                                                            style: TextStyle(
                                                                                fontSize: 11,
                                                                                color: deepKoamaru,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w300),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Text(
                                                                            state.planResponse.plans![index].planSummary!.principal!.toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 11,
                                                                                color: deepKoamaru,
                                                                                fontFamily: "Montserrat",
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          PopupMenuButton(
                                                                            itemBuilder:
                                                                                (context) {
                                                                              return <PopupMenuEntry>[
                                                                                PopupMenuItem<String>(
                                                                                    value: '1',
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: const [
                                                                                        Text(
                                                                                          'View account details',
                                                                                          style: TextStyle(
                                                                                            fontFamily: "Montserrat",
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        Divider(color: alto),
                                                                                      ],
                                                                                    )),
                                                                                PopupMenuItem<String>(
                                                                                    value: '2',
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: const [
                                                                                        Text(
                                                                                          'Pay with card',
                                                                                          style: TextStyle(
                                                                                            fontFamily: "Montserrat",
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        Divider(color: alto),
                                                                                      ],
                                                                                    )),
                                                                                PopupMenuItem<String>(
                                                                                    value: '3',
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: const [
                                                                                        Text(
                                                                                          'Remove',
                                                                                          style: TextStyle(
                                                                                            fontFamily: "Montserrat",
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        Divider(color: alto),
                                                                                      ],
                                                                                    )),
                                                                              ];
                                                                            },
                                                                            onSelected:
                                                                                (val) async {
                                                                              if (val == null)
                                                                                return;

                                                                              if (val == "1") {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAcountDetails(planId: state.planResponse.plans![index].id)));
                                                                              } else if (val == "2") {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PayWithCard(), settings: RouteSettings(arguments: state.planResponse.plans![index])));
                                                                              } else if (val == "3") {
                                                                                PopMessage().displayPopup(context: context, text: "Plan will auto delete after 48 hours", type: PopupType.failure);
                                                                                try {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (_) {
                                                                                        return AlertDialog(
                                                                                            // insetPadding:
                                                                                            //     const EdgeInsets.symmetric(horizontal: 20),
                                                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                            title: const Icon(
                                                                                              Icons.info,
                                                                                              color: deepKoamaru,
                                                                                              size: 50,
                                                                                            ),
                                                                                            content: SizedBox(
                                                                                              height: 120,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    width: 250,
                                                                                                    child: Stack(
                                                                                                      children: [
                                                                                                        Positioned(
                                                                                                          // top: 70,
                                                                                                          right: 20,
                                                                                                          child: Image.asset(
                                                                                                            "assets/images/box.png",
                                                                                                            color: Colors.blue,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 20,
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          height: 50,
                                                                                                          width: 50,
                                                                                                          // color: Colors.black,
                                                                                                        ),
                                                                                                        Positioned(
                                                                                                          top: 25,
                                                                                                          left: 20,
                                                                                                          child: Image.asset(
                                                                                                            "assets/images/polygon3.png",
                                                                                                            color: Colors.blue,
                                                                                                            alignment: Alignment.bottomRight,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    width: 200,
                                                                                                    child: Text(
                                                                                                      "Pay with Paystack",
                                                                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: "Montserrat"),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ));
                                                                                      });
                                                                                  // showDialog(
                                                                                  //     context: context,
                                                                                  //     barrierDismissible: false,
                                                                                  //     builder: (context) => const Center(child: CircularProgressIndicator()));
                                                                                  // await ProductRepository().deletePlan(state.planResponse.plans![index].id!);
                                                                                  // ignore: use_build_context_synchronously
                                                                                  Navigator.pop(context);
                                                                                } catch (e) {
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              }
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              "...",
                                                                              style: TextStyle(fontSize: 30, color: deepKoamaru, letterSpacing: 3, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        }
                                      } else {
                                        return Container();
                                      }
                                    }),
                                limit != 2
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Appbutton(
                                          onTap: () {
                                            setState(() {
                                              show = true;
                                              limit = 100;
                                            });
                                          },
                                          title: "View all",
                                          backgroundColor: deepKoamaru,
                                          textColor: Colors.white,
                                        ),
                                      )
                              ],
                            ),
                          );
                        } else {
                          // final SessionManager _sessionManager = SessionManager();

                          return Column(
                            children: [
                              Center(
                                  child: Text(
                                      "Hi ${_sessionManager.companyNameVal}, "
                                      "you have no active Plan availible")),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Dashboard(page: 1))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: deepKoamaru,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Add Plan",
                                            style: TextStyle(
                                              color: deepKoamaru,
                                              fontFamily: "Montserrat",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              // const Center(child: Text("No Plan yet")),
                            ],
                          );
                        }
                      }
                      if (state is PlanError) {
                        return Column(children: [
                          Text(state.error),
                          IconButton(
                              onPressed: () {
                                createPlanBloc.add(const FetchPlan());
                              },
                              icon: const Icon(Icons.refresh))
                        ]);
                      }
                      return Center(
                          child: IconButton(
                              onPressed: () {
                                createPlanBloc.add(const FetchPlan());
                              },
                              icon: const Icon(Icons.refresh)));
                    },
                    listener: (context, state) {
                      if (state is PlanSuccessful) {
                        plans = state.planResponse.plans!;

                        for (var el in plans) {
                          setState(() {
                            productCategory.add(el.productCategory!.name!);
                          });
                        }
                        setState(() {
                          productCategory = productCategory.toSet().toList();
                        });
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  List<PopupMenuEntry> listpopup = [
    PopupMenuItem<String>(
        value: '1',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Rollover',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: alto),
          ],
        )),
    PopupMenuItem<String>(
        value: '2',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Transfer',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: alto),
          ],
        )),
    PopupMenuItem<String>(
        value: '3',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Withdraw',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: alto),
          ],
        )),
    const PopupMenuItem<String>(
        value: '4',
        child: Text(
          'History',
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )),
  ];
}
