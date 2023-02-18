import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/director/director_bloc.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/app_popup.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class ViewDirector extends StatefulWidget {
  const ViewDirector({Key? key}) : super(key: key);

  @override
  State<ViewDirector> createState() => _ViewDirectorState();
}

class _ViewDirectorState extends State<ViewDirector> {
  late DirectorBloc directorBloc;

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    directorBloc = DirectorBloc();
    directorBloc.add(const FetchDirector());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: concreteLight, offset: Offset(0, 2.0), blurRadius: 24.0)
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: deepKoamaru,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            leadingWidth: 48.0,
            centerTitle: false,
            titleSpacing: 0,
            title: const Text("More Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ListView(
          children: [
            SizedBox(
                child: BlocConsumer<DirectorBloc, DirectorState>(
                    bloc: directorBloc,
                    listener: (context, state) {
                      if (state is DirectorLoading) {
                        setState(() {
                          isLoading.value = true;
                        });
                      }

                      if (state is DeleteSuccess) {
                        // isLoading.value = false;
                        setState(() {});
                        PopMessage().displayPopup(
                            context: context,
                            type: PopupType.success,
                            text: "Director successfully updated");
                      }
                      if (state is DirectorError) {
                        isLoading.value = false;
                        setState(() {});
                        PopMessage().displayPopup(
                            context: context,
                            type: PopupType.failure,
                            text: state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is DirectorLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is DirectorSuccess) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            itemCount: state.directorResponse.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  if (state.directorResponse.data!.isEmpty)
                                    const Text('No Director Saved yet'),
                                  ListTile(
                                    minLeadingWidth: 10,
                                    minVerticalPadding: 2,
                                    trailing:
                                        //  Row(
                                        //   children: [
                                        GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                    title: const Text(
                                                        "Are you sure?"),
                                                    content: const Text(
                                                        "You can not delete the last director in your profile."),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child:
                                                              const Text("Ok"))
                                                    ],
                                                  ));
                                        } else {
                                          popMessage(context,
                                              () => Navigator.of(context).pop(),
                                              () {
                                            directorBloc.add(DeleteDirector(
                                                id: state.directorResponse
                                                    .data![index].id!));
                                            state.directorResponse.data!
                                                .removeAt(index);
                                            Navigator.of(context).pop();
                                          }, "NO", "YES", "Delete Director?",
                                              "Are you sure you want to delete this director");
                                        }
                                      },
                                      child: const Icon(
                                          Icons.delete_forever_rounded,
                                          color: Colors.red,
                                          size: 25),
                                    ),
                                    // const Icon(
                                    //     Icons.arrow_forward_ios_sharp,
                                    //     size: 15),
                                    //   ],
                                    // ),
                                    title: Text("Director ${index + 1}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRouter.editDirector,
                                        arguments: state
                                            .directorResponse.data![index]),
                                  ),
                                  const Divider(height: 1, color: alto)
                                ],
                              );

                              // return Column(
                              //   children: [
                              //     Theme(
                              //       data: Theme.of(context).copyWith(
                              //           dividerColor: Colors.transparent),
                              //       child: ExpansionTile(
                              //           title: Text("Director$index",
                              //               style: const TextStyle(
                              //                 color: Colors.black,
                              //                 fontFamily: "Montserrat",
                              //                 fontSize: 12,
                              //                 fontWeight: FontWeight.w500,
                              //               )),
                              //           childrenPadding:
                              //               const EdgeInsets.symmetric(
                              //                   vertical: 20),
                              //           collapsedTextColor: Colors.black54,
                              //           onExpansionChanged: (bool val) =>
                              //               setState(() {
                              //                 _customTileExpanded = val;
                              //               }),
                              //           tilePadding: const EdgeInsets.symmetric(
                              //               horizontal: 15),
                              //           trailing: _customTileExpanded
                              //               ? const Icon(
                              //                   Icons
                              //                       .keyboard_arrow_down_rounded,
                              //                   size: 25,
                              //                   color: Colors.black)
                              //               : const Icon(
                              //                   Icons.arrow_forward_ios,
                              //                   size: 15,
                              //                   color: Colors.black),
                              //           children: [

                              //           ]),
                              //     ),
                            });
                      } else {}
                      return const Center(child: Text("retry"));
                    })),
          ],
        ),
      ),
    );
  }
}
