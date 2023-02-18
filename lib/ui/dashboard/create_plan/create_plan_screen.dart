import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/product/products_bloc.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/dashboard/create_plan/widget/plan_card.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

import 'package:rosabon/ui/widgets/app_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreentate();
}

class _CreatePlanScreentate extends State<CreatePlanScreen> {
  final SessionManager _sessionManager = SessionManager();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductsBloc productsBloc;

  @override
  void initState() {
    productsBloc = ProductsBloc();
    productsBloc.add(const FetchProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: deepKoamaru,
        elevation: 0,
        leading: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/images/hamburgar.PNG")),
        leadingWidth: 48.0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      backgroundColor: Colors.white,
      drawer: AppDrawer(map: _sessionManager.userRoleVal),
      body: BlocConsumer<ProductsBloc, ProductsState>(
          bloc: productsBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Fetching) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Shimmer.fromColors(
                    highlightColor: gray.withOpacity(0.5),
                    baseColor: gray.withOpacity(0.2),
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.white,
                        ),
                      ),
                      itemCount: 4,
                    )),
              );
              // return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductCategorySuccessful) {
              if (state.productCategoryResponse.product!.isNotEmpty) {
                // if(state.productCategoryResponse.product.)
                return ListView(
                  children: [
                    SizedBox(height: 2.h),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Choose Plan",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: state.productCategoryResponse.product!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // if (state.productCategoryResponse.product![index]
                            //         .products![index].status ==
                            //     "ACTIVE")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(state.productCategoryResponse
                                      .product![index].productCategoryName!),
                                ),
                                PlanCard(
                                    productCategoryId: state
                                        .productCategoryResponse
                                        .product![index]
                                        .productCategoryId,
                                    products: state.productCategoryResponse
                                        .product![index].products!),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No product for this plan"));
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
          }),
    );
  }
}
