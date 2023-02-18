import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/myreferal_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';

class MyReferral extends StatefulWidget {
  const MyReferral({Key? key}) : super(key: key);

  @override
  State<MyReferral> createState() => _MyReferralState();
}

class _MyReferralState extends State<MyReferral> {
  late WalletBloc _walletBloc;
  bool toggle = false;
  bool initLoading = false;
  List<Referal> referals = [];

  @override
  void initState() {
    _walletBloc = WalletBloc();
    _walletBloc.add(const MyRefers());
    super.initState();
  }

  bool isPoked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "My Referrals"),
      body: BlocListener<WalletBloc, WalletState>(
        bloc: _walletBloc,
        listener: (context, state) {
          if (state is PokeLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()));
          }
          if (state is PokeSuccess) {
            Navigator.pop(context);
            setState(() {
              toggle = true;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: const Icon(
                        Icons.info,
                        color: deepKoamaru,
                        size: 50,
                      ),
                      content: SizedBox(
                        height: 100,
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
                              width: 300,
                              child: Center(
                                child: Text(
                                  "User Prompted",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                });
          }
          if (state is MyRefersLoading) {
            setState(() {
              initLoading = true;
            });
          }
          if (state is MyRefersSuccess) {
            setState(() {
              initLoading = false;
            });
            referals = state.myreferalResponse.referals!;
            print(referals.length);
          }
          if (state is PokeError) {
            setState(() {
              toggle = false;
            });
            PopMessage().displayPopup(
                context: context, text: state.error, type: PopupType.failure);
          }
        },
        child: initLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: referals.length,
                  itemBuilder: (context, index) {
                    var refers = referals;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              referals[index].dateOfReg ?? "",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 9,
                                color: Theme.of(context).dividerColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              referals[index].customerName ?? "",
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  referals[index].status == "ACTIVE"
                                      ? "Inactive"
                                      : "Active",
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                CircleAvatar(
                                    radius: 4,
                                    backgroundColor:
                                        referals[index].status == "ACTIVE"
                                            ? alto
                                            : Colors.green)
                              ],
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                                onTap: () {
                                  if (referals[index].status != "ACTIVE") {
                                    _walletBloc
                                        .add(PokeUser(id: refers[index].id!));
                                    setState(() {
                                      referals[index].status = "ACTIVE";
                                    });
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    decoration: BoxDecoration(
                                        color:
                                            referals[index].status == "ACTIVE"
                                                ? alto
                                                : deepKoamaru,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text(
                                      "Poke User",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )))
                          ],
                        )
                      ],
                    );
                  },
                  separatorBuilder: ((context, index) {
                    return const Divider(height: 50, color: alto);
                  }),
                ),
              ),
      ),
    );
  }
}


//  isLoading
//               ? const Opacity(
//                   opacity: 0.8,
//                   child:
//                       ModalBarrier(dismissible: false, color: Colors.black54),
//                 )
//               : Container(),
//           isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Container()