import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosabon/bloc/help/help_bloc.dart';
import 'package:rosabon/model/response_models/help_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool _customTileExpanded = false;
  late HelpBloc _helpBloc;
  List<HelpCenter> help = [];
  @override
  void initState() {
    _helpBloc = HelpBloc();
    _helpBloc.add(const Help());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: ""),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 15.0, top: 20.0),
            child: Text("FAQS",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
            decoration: BoxDecoration(
                color: athensgray, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child:
                      SvgPicture.asset("assets/images/search.svg", color: gray),
                ),
                SizedBox(
                    width: 260,
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Search Using Keywords",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none),
                      onChanged: (String val) {
                        // setState(() {
                        //   help.sort((a, b) => a.faqCategory!.name!
                        //       .toLowerCase()
                        //       .compareTo(val.toLowerCase()));
                        // });
                        setState(() {
                          help.sort((a, b) => b.question!
                              .toLowerCase()
                              .compareTo(val.toLowerCase()));
                        });
                      },
                    )),
                // GestureDetector(
                //   onTap: (() {

                //   }),
                //   child: const Icon(
                //     Icons.close,
                //     size: 20,
                //     color: gray,
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            child: BlocConsumer<HelpBloc, HelpState>(
              bloc: _helpBloc,
              listener: (context, state) {
                if (state is HelpSuccess) {
                  for (var el in state.helpResponse.helpCenter!) {
                    if (el.status == "ACTIVE") {
                      help.add(el);
                    }
                  }
                  // help = state.helpResponse.helpCenter!;
                }
              },
              builder: (context, state) {
                if (state is HelpLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HelpSuccess) {
                  if (help.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: help.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  expandedAlignment: Alignment.topLeft,
                                  title: Text(help[index].answer ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  childrenPadding:
                                      const EdgeInsets.only(bottom: 20),
                                  collapsedTextColor: Colors.black54,
                                  onExpansionChanged: (bool val) =>
                                      setState(() {
                                        _customTileExpanded = val;
                                      }),
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  trailing: _customTileExpanded
                                      ? const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 25,
                                          color: Colors.black)
                                      : const Icon(Icons.arrow_forward_ios,
                                          size: 15, color: Colors.black),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(help[index].question ?? ""),
                                          const SizedBox(height: 10),
                                          Text(help[index].answer ?? ""),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                          // const Divider(height: 1, color: alto),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Theme(
                          //     data: Theme.of(context)
                          //         .copyWith(dividerColor: Colors.transparent),
                          //     child: ExpansionTile(
                          //         title: const Text("How to get Referral Bonus",
                          //             style: TextStyle(
                          //               color: Colors.black,
                          //               fontFamily: "Montserrat",
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //             )),
                          //         childrenPadding:
                          //             const EdgeInsets.symmetric(vertical: 20),
                          //         collapsedTextColor: Colors.black54,
                          //         onExpansionChanged: (bool val) => setState(() {
                          //               _customTileExpanded = val;
                          //             }),
                          //         tilePadding:
                          //             const EdgeInsets.symmetric(horizontal: 15),
                          //         trailing: _customTileExpanded
                          //             ? const Icon(Icons.keyboard_arrow_down_rounded,
                          //                 size: 25, color: Colors.black)
                          //             : const Icon(Icons.arrow_forward_ios,
                          //                 size: 15, color: Colors.black),
                          //         children: [
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.symmetric(horizontal: 15),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: const [
                          //                 Text("Did you know?"),
                          //                 SizedBox(height: 10),
                          //                 Text(
                          //                     "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter "),
                          //               ],
                          //             ),
                          //           ),
                          //         ]),
                          //   ),
                          // ),
                          // const Divider(height: 1, color: alto),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Theme(
                          //     data: Theme.of(context)
                          //         .copyWith(dividerColor: Colors.transparent),
                          //     child: ExpansionTile(
                          //         title: const Text("How to start an Investment plan",
                          //             style: TextStyle(
                          //               color: Colors.black,
                          //               fontFamily: "Montserrat",
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //             )),
                          //         childrenPadding:
                          //             const EdgeInsets.symmetric(vertical: 20),
                          //         collapsedTextColor: Colors.black54,
                          //         onExpansionChanged: (bool val) => setState(() {
                          //               _customTileExpanded = val;
                          //             }),
                          //         tilePadding:
                          //             const EdgeInsets.symmetric(horizontal: 15),
                          //         trailing: _customTileExpanded
                          //             ? const Icon(Icons.keyboard_arrow_down_rounded,
                          //                 size: 25, color: Colors.black)
                          //             : const Icon(Icons.arrow_forward_ios,
                          //                 size: 15, color: Colors.black),
                          //         children: [
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.symmetric(horizontal: 15),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: const [
                          //                 Text("Did you know?"),
                          //                 SizedBox(height: 10),
                          //                 Text(
                          //                     "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter "),
                          //               ],
                          //             ),
                          //           ),
                          //         ]),
                          //   ),
                          // ),
                          // const Divider(height: 1, color: alto)
                        });
                  } else {
                    return const Center(child: Text("No FAQ Yet"));
                  }
                }
                return const Text("retyr");
              },
            ),
          ),
        ],
      ),
    );
  }
}
