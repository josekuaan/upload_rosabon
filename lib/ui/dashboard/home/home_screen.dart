import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/login/login_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/product/products_bloc.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/product_screen.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_drawer.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/app_strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionManager _sessionManager = SessionManager();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late CreatePlanBloc createPlanBloc;
  late ProductsBloc productsBloc;
  bool customTileExpanded = false;
  double? totalWorth;
  @override
  void initState() {
    productsBloc = ProductsBloc();
    createPlanBloc = CreatePlanBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        createPlanBloc.add(const FetchPlan());
        productsBloc.add(const FetchProduct());
      } else {
        PopMessage().displayPopup(
            context: context,
            text: "Please check your internet",
            type: PopupType.failure);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // totalWorth = _sessionManager.totalWorthVal;
    context.watch<CreatePlanBloc>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: deepKoamaru,
        elevation: 0,
        leading: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/images/hamburgar.PNG")),
        actions: [
          SizedBox(
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.notification),
                    icon: const Icon(
                      Icons.notifications_none,
                      color: gray,
                    )),
                InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, AppRouter.investmentcalculator),
                    child: Image.asset("assets/images/calculate.png")),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    if (_sessionManager.userRoleVal.toString() ==
                        'INDIVIDUAL_USER') {
                      Navigator.pushNamed(context, AppRouter.profile,
                          arguments: _sessionManager.userRoleVal);
                    } else {
                      Navigator.pushNamed(context, AppRouter.corprateprofile,
                          arguments: _sessionManager.userRoleVal);
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: alto,
                    child: Icon(Icons.person),
                  ),
                )
              ],
            ),
          ),
        ],
        leadingWidth: 48.0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: AppDrawer(map: _sessionManager.userRoleVal),
      body: ListView(
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${_sessionManager.userFullNameVal}",
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: alto,
                    fontFamily: "Montserrat",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Dashboard(page: 1))),
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
          BlocConsumer<CreatePlanBloc, CreatePlanState>(
              bloc: createPlanBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is Fetching) {
                  return SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Shimmer.fromColors(
                          highlightColor: gray.withOpacity(0.2),
                          baseColor: gray.withOpacity(0.2),
                          enabled: true,
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            itemCount: 1,
                          )),
                    ),
                  );
                }
                if (state is PlanSuccessful) {
                  double totalWorthVal = 0.0;
                  int activePlanVal = 0;
                  for (var i = 0; i < state.planResponse.plans!.length; i++) {
                    var val = state.planResponse.plans![i];

                    if (val.planStatus == "ACTIVE") {
                      activePlanVal += 1;
                    }

                    if (val.planStatus == "ACTIVE" ||
                        val.planStatus == "MATURED") {
                      totalWorthVal = (totalWorthVal +
                          state.planResponse.plans![i].planSummary!.principal! *
                              state.planResponse.plans![i].exchangeRate!);
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.235,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/balance_card.PNG")),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.only(left: 40, top: 5),
                            child: Text(
                              "Total networth",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: "${AppStrings.naira} ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Montserrat")),
                              TextSpan(
                                text: MoneyFormatter(
                                  amount: totalWorthVal,
                                ).output.nonSymbol,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // const TextSpan(
                              //   text: '.00',
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 9,
                              //       fontWeight: FontWeight.w300,
                              //       fontFamily: "Montserrat"),
                              // ),
                            ])),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, bottom: 20, top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Active plans: ",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text(
                                        activePlanVal.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                          "assets/images/toggle.png")),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    "Unable to load data",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Categories",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(height: 1, color: alto),
          SizedBox(
            child: BlocConsumer<ProductsBloc, ProductsState>(
              bloc: productsBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FetchingProduct) {
                  return SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Shimmer.fromColors(
                          highlightColor: gray.withOpacity(0.2),
                          baseColor: gray.withOpacity(0.2),
                          enabled: true,
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemCount: 4,
                          )),
                    ),
                  );
                }
                if (state is ProductCategorySuccessful) {
                  if (state.productCategoryResponse.product!.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount:
                            state.productCategoryResponse.product!.length,
                        itemBuilder: (context, index) {
                          // activePlan
                          // bool customTileExpanded = false;
                          return SizedBox(
                            width: double.infinity,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  title: Text(
                                      state.productCategoryResponse
                                          .product![index].productCategoryName!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  childrenPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  collapsedTextColor: Colors.black54,
                                  onExpansionChanged: (bool val) =>
                                      setState(() {
                                        customTileExpanded = val;
                                      }),
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  trailing: customTileExpanded
                                      ? const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 25,
                                          color: Colors.black)
                                      : const Icon(Icons.arrow_forward_ios,
                                          size: 15, color: Colors.black),
                                  children: state.productCategoryResponse
                                      .product![index].products!
                                      .map((e) {
                                    return Column(
                                      children: [
                                        if (e.status == 'ACTIVE')
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 220,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 25,
                                                      horizontal: 6),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: alto,
                                                            offset:
                                                                Offset(0, 4.0),
                                                            blurRadius: 24.0)
                                                      ],
                                                      color: Colors.white),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          e.imageUrl != null
                                                              ? Container(
                                                                  height: 80,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          // color: alto,
                                                                          image: e.imageUrl != null
                                                                              ? DecorationImage(image: NetworkImage(e.imageUrl!))
                                                                              : null),
                                                                )
                                                              : Container(
                                                                  height: 80,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: alto,
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  e.productName ??
                                                                      "",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                      "."),
                                                                  SizedBox(
                                                                    width: 55.w,
                                                                    child: Text(
                                                                      e.productDescription
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontSize:
                                                                            9,
                                                                        color:
                                                                            emperor,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 30),
                                                      Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      30),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  deepKoamaru,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          child: InkWell(
                                                            onTap: () =>
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ProductScreen(
                                                                        productCategoryId: state
                                                                            .productCategoryResponse
                                                                            .product![index]
                                                                            .productCategoryId,
                                                                        //  e
                                                                        //     .productCategoryId,
                                                                        product:
                                                                            e,
                                                                      ),
                                                                    )),

                                                            // Navigator.pushNamed(
                                                            //     context,
                                                            //     AppRouter
                                                            //         .products,
                                                            //     arguments: {

                                                            //   "e": e
                                                            // }),
                                                            child: const Text(
                                                              "Create Plan",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  }).toList()),
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child:
                            Image.asset("assets/images/empty_state_card.png"));
                  }
                }
                if (state is ProductError) {
                  return Column(children: [
                    Text(state.error),
                    IconButton(
                        onPressed: () {
                          productsBloc.add(const FetchProduct());
                        },
                        icon: const Icon(Icons.refresh))
                  ]);
                }
                return Center(
                    child: IconButton(
                        onPressed: () {
                          productsBloc.add(const FetchProduct());
                        },
                        icon: const Icon(Icons.refresh)));
              },
            ),
          ),

          // const FixedSavings(),
          // const TargetSaving(),
          // const TargetIncome(),
        ],
      ),
    );
  }
}
