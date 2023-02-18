import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/bonus_response.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class SpecialEarning extends StatefulWidget {
  const SpecialEarning({Key? key}) : super(key: key);

  @override
  State<SpecialEarning> createState() => _SpecialEarningState();
}

class _SpecialEarningState extends State<SpecialEarning> {
  bool isRedeemed = false;
  bool loading = false;
  late WalletBloc _walletBloc;
  String? totalEarning, totalRedeemedEarnings;
  List<Bonus> bonus = [];
  @override
  void initState() {
    _walletBloc = WalletBloc();
    _walletBloc.add(const GetTotalSpecialEarning());
    _walletBloc.add(const Totalearning());
    _walletBloc.add(const SpecialActivity());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Rosabon Special Earnings"),
      body: BlocListener<WalletBloc, WalletState>(
          bloc: _walletBloc,
          listener: (context, state) {
            if (state is TotalearningSuccess) {
              setState(() {
                totalEarning = state.baseResponse.message;
              });
            }
            if (state is TotalSpecialEarningSuccess) {
              setState(() {
                totalRedeemedEarnings = state.baseResponse.message;
              });
            }
            if (state is ReferalBonusSuccess) {
              setState(() {
                bonus = state.bonuResponse.bonus!;
                loading = false;
              });
            }
            if (state is MyRefersLoading) {
              setState(() {
                loading = true;
              });
            }
            if (state is PokeLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()));
            }

            if (state is PokeSuccess) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Bonus redeemed", textColor: Colors.white);
            }
            if (state is PokeError) {
              Navigator.pop(context);
              PopMessage().displayPopup(
                  context: context, text: state.error, type: PopupType.failure);
            }
          },
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: ListView(
                    children: [
                      SizedBox(height: 2.h),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.3),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: mystic),
                            color: athensgray,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Redeemed Earnings :",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 9.sp,
                                color: Theme.of(context).dividerColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "₦  ${totalRedeemedEarnings ?? ""}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.2),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: mystic),
                            color: athensgray,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Earnings :",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 9.sp,
                                        color: Theme.of(context).dividerColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "₦ ${totalEarning ?? ""}",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    _walletBloc.add(const RedeemSpecialBonus());
                                    setState;
                                    (() {
                                      isRedeemed = !isRedeemed;
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                          color:
                                              isRedeemed ? alto : deepKoamaru,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Redeem",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 9.sp,
                                          color:
                                              isRedeemed ? gray : Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Container(
                            //   height: 5,
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //       color: mystic, borderRadius: BorderRadius.circular(50)),
                            // ),
                            // const SizedBox(height: 10),
                            // const Center(child: Text("0 out of ₦100,000 Earned"))
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: alto),
                      ListView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: bonus.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bonus[index]
                                            .dateOfTransaction
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 10.sp,
                                          color: gray,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        bonus[index].description.toString(),
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            bonus[index].description.toString(),
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 10.sp,
                                              color: gray,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Text(
                                    " ₦ ${bonus[index].amount}",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                )
          //   } else {
          //     return const Center(
          //         child: Text("You don't have any bonus yet."));
          //   }
          // } else if (state is MyRefersError) {
          //   return Center(child: Text(state.error.toString()));
          // }

          ),
    );
  }
}
