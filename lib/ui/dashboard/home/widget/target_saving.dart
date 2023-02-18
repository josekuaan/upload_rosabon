import 'package:flutter/material.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';

class TargetSaving extends StatefulWidget {
  const TargetSaving({Key? key}) : super(key: key);

  @override
  State<TargetSaving> createState() => _TargetSavingState();
}

class _TargetSavingState extends State<TargetSaving> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: const Text("Target Saving",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                childrenPadding: EdgeInsets.zero,
                onExpansionChanged: (bool val) => setState(() {
                      _customTileExpanded = val;
                    }),
                tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                trailing: _customTileExpanded
                    ? const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 25, color: Colors.black)
                    : const Icon(Icons.arrow_forward_ios,
                        size: 15, color: Colors.black),
                children: [
                  SizedBox(
                    height: 650,
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                height: 200,
                                padding: EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: alto,
                                          offset: Offset(0, 4.0),
                                          blurRadius: 24.0)
                                    ],
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: alto),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Product 1",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Row(
                                              children: const [
                                                Text("."),
                                                Text(
                                                  "Lorem Ipsum is simply dummy text of the  ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 9,
                                                    color: emperor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Text("."),
                                                Text(
                                                  "Lorem Ipsum is simply dummy text of the  ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 9,
                                                    color: emperor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Text("."),
                                                Text(
                                                  "Lorem Ipsum is simply dummy text of the  ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 9,
                                                    color: emperor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 30),
                                        decoration: BoxDecoration(
                                            color: deepKoamaru,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: InkWell(
                                          onTap: () => Navigator.pushNamed(
                                              context, AppRouter.products,
                                              arguments: "Product 3"),
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
                          ),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        ),
        const Divider(height: 1, color: alto)
      ],
    );
  }
}
