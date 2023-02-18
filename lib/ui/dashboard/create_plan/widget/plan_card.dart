import 'package:flutter/material.dart';
import 'package:rosabon/model/response_models/product_category_response.dart';
import 'package:rosabon/ui/dashboard/choose_plan/widgets/product_screen.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:sizer/sizer.dart';

class PlanCard extends StatelessWidget {
  final List<Products> products;
  final int? productCategoryId;
  const PlanCard({Key? key, required this.products, this.productCategoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
          children: products.map((e) {
        return Column(
          children: [
            if (e.status == "ACTIVE")
              Container(
                height: 220,
                margin: EdgeInsets.symmetric(vertical: 1.h),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: alto, offset: Offset(0, 4.0), blurRadius: 24.0)
                    ],
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        e.imageUrl != null
                            ? Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: alto,
                                    image: e.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(e.imageUrl!))
                                        : null),
                              )
                            : Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: alto,
                                ),
                              ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.productName ?? "",
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                            Row(
                              children: [
                                const CircleAvatar(
                                    radius: 2, backgroundColor: deepKoamaru),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 55.w,
                                  child: Text(
                                    e.productDescription.toString(),
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 9,
                                      color: emperor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            color: deepKoamaru,
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                      productCategoryId: productCategoryId,
                                      product: e))),
                          child: const Text(
                            "Create Plan",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }).toList()),
    );
  }
}
