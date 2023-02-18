import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/plan_history.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_constants.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  late CreatePlanBloc createPlanBloc;
  @override
  void initState() {
    createPlanBloc = CreatePlanBloc();
    createPlanBloc.add(const FetchClosePlan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: BlocConsumer(
          bloc: createPlanBloc,
          listener: (context, state) {},
          builder: (contex, state) {
            if (state is Fetching) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlanSuccessful) {
              if (state.planResponse.plans!.isNotEmpty) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Closed Plans",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            itemCount: state.planResponse.plans!.length,
                            itemBuilder: (contex, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: athensgray,
                                        offset: Offset.fromDirection(2.0),
                                        blurRadius: 20.0)
                                  ],
                                ),
                                child: Container(
                                  // height: MediaQuery.of(context).size.height,
                                  // width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/medium_bg.PNG"))),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: width * 0.5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state
                                                              .planResponse
                                                              .plans![index]
                                                              .planName ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      state
                                                              .planResponse
                                                              .plans![index]
                                                              .planName ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                state.planResponse.plans![index]
                                                        .planStatus ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    yMDDate(state
                                                        .planResponse
                                                        .plans![index]
                                                        .planSummary!
                                                        .startDate!),
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: deepKoamaru,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    yMDDate(state
                                                        .planResponse
                                                        .plans![index]
                                                        .planSummary!
                                                        .endDate!),
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: deepKoamaru,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Center(
                                              child: Image.asset(
                                                  "assets/images/line.png")),
                                          const SizedBox(height: 23),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: state.planResponse.plans![index].currency == null ? '' : state.planResponse.plans![index].currency!.name).currencySymbol} ${MoneyFormatter(amount: state.planResponse.plans![index].planSummary!.principal!.toDouble()).output.nonSymbol}",
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: deepKoamaru,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  PopupMenuButton(
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem<String>(
                                                          value: '1',
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Text(
                                                                'History',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                    onSelected: (val) {
                                                      if (val == null) return;

                                                      if (val == "1") {
                                                        //code here
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PlanHistory(
                                                                    currency:
                                                                        "",
                                                                    id: state
                                                                        .planResponse
                                                                        .plans![
                                                                            index]
                                                                        .id!)));
                                                      }
                                                    },
                                                    child: const Text(
                                                      "...",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: deepKoamaru,
                                                          letterSpacing: 3,
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
                                          const SizedBox(height: 20),
                                        ]),
                                  ),
                                ),
                              );
                            })),
                  ],
                );
              } else {
                return Center(
                    child: Image.asset("assets/images/empty_state_card.png"));
              }
            }
            if (state is PlanError) {
              return Center(child: Text(state.error));
            }

            return const Center(child: Text("retry"));
          }),
    );
  }
}
