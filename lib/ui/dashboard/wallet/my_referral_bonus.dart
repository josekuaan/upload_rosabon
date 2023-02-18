import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/bonus_response.dart';
import 'package:rosabon/model/response_models/user_response.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:rosabon/ui/widgets/app_num.dart';
import 'package:rosabon/ui/widgets/pop_message.dart';
import 'package:sizer/sizer.dart';

class MyReferralBonus extends StatefulWidget {
  const MyReferralBonus({Key? key}) : super(key: key);

  @override
  State<MyReferralBonus> createState() => _MyReferralBonusState();
}

class _MyReferralBonusState extends State<MyReferralBonus> {
  final sessionManager = SessionManager();
  bool isPoked = true;
  bool initLoading = false;
  late WalletBloc _walletBloc;
  late UserBloc userBloc;
  late double progressValue;
  double totalRedeemedBonus = 0.0;
  double earnedReferralBonus = 0.0;
  List<Bonus> bonus = [];
  UserResponse? user;
  @override
  void initState() {
    _walletBloc = WalletBloc();
    userBloc = UserBloc();
    // userBloc.add(FetchUser(name: sessionManager.userEmailVal));
    // _walletBloc.add(const FetchThreshold());
    _walletBloc.add(const MyRefersActivitty());
    progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: "My Referral Bonus"),
        body: MultiBlocListener(
            listeners: [
              BlocListener<UserBloc, UserState>(
                  bloc: userBloc,
                  listener: (context, state) {
                    print("===============$state============");
                    if (state is FetchUserSuccess) {
                      user = state.userResponse;
                    }
                  }),
              BlocListener<WalletBloc, WalletState>(
                bloc: _walletBloc,
                listener: (context, state) {
                  if (state is MyRefersLoading) {
                    setState(() {
                      initLoading = true;
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
                  if (state is ReferalBonusSuccess) {
                    bonus = state.bonuResponse.bonus!;
                    double val = 0.0;
                    double totalBonus = 0.0;
                    double earnedBonus = 0.0;
                    print(state.bonuResponse.bonus![0].referralBonus);
                    for (var el in state.bonuResponse.bonus!) {
                      if (el.referralBonus != null) {
                        val += el.referralBonus!.earnedReferralBonus != 0.0
                            ? el.referralBonus!.earnedReferralBonus! / 100
                            : 0.00;
                      } else {
                        val = 0.00;
                      }
                    }

                    setState(() {
                      progressValue = val;
                      if (state.bonuResponse.bonus!.isNotEmpty) {
                        earnedReferralBonus = state.bonuResponse.bonus![0]
                            .referralBonus!.earnedReferralBonus!;
                        totalRedeemedBonus = state.bonuResponse.bonus![0]
                            .referralBonus!.totalRedeemedBonus!;
                      }
                      initLoading = false;
                    });
                  }
                  if (state is PokeError) {
                    Navigator.pop(context);
                    setState(() {
                      isPoked = true;
                    });
                    PopMessage().displayPopup(
                        context: context,
                        text: state.error,
                        type: PopupType.failure);
                  }
                },
              ),
            ],
            child: initLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 20, right: 20),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          decoration: BoxDecoration(
                              color: athensgray,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Redeemed Referral Bonus:",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 9.sp,
                                  color: Theme.of(context).dividerColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: double.parse(totalRedeemedBonus.toString())).output.nonSymbol}",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: athensgray,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Earned Referral Bonus",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 9.sp,
                                          color: Theme.of(context).dividerColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: double.parse(earnedReferralBonus.toString())).output.nonSymbol}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IgnorePointer(
                                    ignoring: !isPoked,
                                    child: InkWell(
                                      onTap: () {
                                        _walletBloc.add(const Redeembonus());
                                        setState(() {
                                          isPoked = !isPoked;
                                        });
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          decoration: BoxDecoration(
                                              color:
                                                  isPoked ? deepKoamaru : alto,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "Redeem",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 8.sp,
                                              color:
                                                  isPoked ? Colors.white : gray,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 1.sp),
                              LinearProgressIndicator(
                                backgroundColor: mystic,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    deepKoamaru),
                                value: progressValue,
                              ),
                              // Container(
                              //   height: 5,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //       color: mystic,
                              //       borderRadius: BorderRadius.circular(50)),
                              // ),
                              SizedBox(height: 1.h),
                              Center(
                                  child: Text(
                                "${MoneyFormatter(amount: double.parse(earnedReferralBonus.toString())).output.nonSymbol} out of ${bonus.isNotEmpty ? "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: bonus[0].threshold!.amount!).output.nonSymbol}" : 0} Earned",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 9.sp,
                                  color: Theme.of(context).dividerColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(height: 1.h),
                        const Divider(color: alto),
                        ListView.builder(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            itemCount: bonus.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bonus[index].createdAt.toString(),
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 10.sp,
                                            color: gray,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        // SizedBox(height: 1.h),
                                        // Text(
                                        //   bonus[index].description.toString(),
                                        //   style: TextStyle(
                                        //     fontFamily: "Montserrat",
                                        //     fontSize: 12.sp,
                                        //     fontWeight: FontWeight.w500,
                                        //   ),
                                        // ),
                                        SizedBox(height: 1.h),
                                        SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              bonus[index]
                                                  .description
                                                  .toString(),
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
                                      "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: bonus[index].amount!).output.nonSymbol}",
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
                        const Divider(color: alto)
                      ],
                    ),
                  )));
  }
}
