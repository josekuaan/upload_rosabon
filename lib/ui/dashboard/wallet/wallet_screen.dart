import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreentate();
}

class _WalletScreentate extends State<WalletScreen> {
  final SessionManager _sessionManager = SessionManager();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  WalletBloc walletBloc = WalletBloc();
  String accountName = "";
  String accountNumber = "";

  @override
  void initState() {
    accountNumber = _sessionManager.virtualAccountNoVal;
    accountName = _sessionManager.virtualAccountNameVAl;
    walletBloc = WalletBloc();
    walletBloc.add(const FetchWalletBalance());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(accountNumber);
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
        leadingWidth: 48.0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: AppDrawer(map: _sessionManager.userRoleVal),
      body: BlocConsumer<WalletBloc, WalletState>(
        bloc: walletBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WalletBalanceLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
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
            );
          } else if (state is Walletsuccess) {
            return ListView(
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.240,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/balance_card.PNG")),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 40, top: 5),
                          child: Text(
                            "Nuban Account Number",
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
                          child: Text(
                            "${accountNumber.substring(0, 4)} -${accountNumber.substring(4, 8)} -${accountNumber.substring(8, 10)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "($accountName)",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 40, bottom: 20, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Balance ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Text(
                                      "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: state.walletResponse.amount!).output.nonSymbol}",
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
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_sessionManager.userRoleVal ==
                                "INDIVIDUAL_USER") {
                              Navigator.pushNamed(
                                  context, AppRouter.wallettobank,
                                  arguments: state.walletResponse.amount);
                            } else {
                              Navigator.pushNamed(
                                  context, AppRouter.companywithdrawtobank,
                                  arguments: state.walletResponse.amount);
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: cornflowerblue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset("assets/images/atm.png"),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Withdraw",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.mytransfer,
                                arguments: state.walletResponse.amount);
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: cornflowerblue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset("assets/images/refresh.png"),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Transfer",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AppRouter.mytransactiondetails,
                              arguments: {
                                "title": "Transaction Details",
                                "balance": state.walletResponse.amount
                              }),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: cornflowerblue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset("assets/images/history.png"),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "History",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 3.h),
                const Divider(height: 1, color: alto),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.myreferral),
                    child: Text(
                      "My Referrals",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.myreferralbonus),
                    child: Text(
                      "My Referral Bonus",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.mydeposit),
                    child: Text(
                      "My Deposits",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.specialearning),
                    child: Text(
                      "Rosabon Special Earnings",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: Icon(Icons.refresh),
          );
        },
      ),
    );
  }
}
