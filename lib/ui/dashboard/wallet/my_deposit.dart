import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/deposit_history_response.dart';
import 'package:rosabon/ui/dashboard/wallet/widgets/plan_transaction.dart';
import 'package:rosabon/ui/dashboard/wallet/widgets/wallet_transactions.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';

class MyDeposit extends StatefulWidget {
  const MyDeposit({Key? key}) : super(key: key);

  @override
  State<MyDeposit> createState() => _MyDepositState();
}

class _MyDepositState extends State<MyDeposit> {
  bool isPoked = true;
  late WalletBloc walletBloc;
  List<Deposit> banktransfers = [];
  List<Deposit> wallet = [];
  List<Deposit> plan = [];
  @override
  void initState() {
    walletBloc = WalletBloc();
    walletBloc.add(const FetchDepositTransctions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "My Deposits"),
      body: BlocConsumer<WalletBloc, WalletState>(
          bloc: walletBloc,
          listener: (context, state) {
           
            if (state is BankDepositSuccess) {
              for (var el in state.depositHistoryResponse.deposit!) {
                if (el.category == "BANK_ACCOUNT_TO_WALLET_FUNDING") {
                  banktransfers.add(el);
                } else if (el.category == "PLAN_TO_WALLET_FUNDING") {
                  plan.add(el);
                } else if (el.category == "WALLET_FUNDING_BY_CREDIT_WALLET" ||
                    el.category == "FUND_REVERSAL_TO_WALLET" ||
                    el.category == "WALLET_TO_BANK_ACCOUNT_FUNDING" ||
                    el.category == "WALLET_FUNDING_BY_CARD" ||
                    el.category == "WALLET_FUNDING_BY_REFERRAL") {
                  wallet.add(el);
                }
              }
            }
          },
          builder: (context, state) {
            if (state is WalletTransLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BankDepositSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text(
                        "Bank Transfer Deposit",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        "Deposit initiated via external sources",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                      onTap: () => Navigator.pushNamed(
                          context, AppRouter.singletransactions,
                          arguments: banktransfers),
                    ),
                    const Divider(color: alto),
                    ListTile(
                      title: const Text(
                        "Credit Wallet Transfer Deposit",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        "Deposit initiated From user’s credit wallet",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Wallettransactions(),
                              settings: RouteSettings(arguments: wallet))),
                    ),
                    const Divider(color: alto),
                    ListTile(
                      title: const Text(
                        "Plan Transfer Deposit",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        "Deposit initiated From user’s plan",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Plantransactions(),
                              settings: RouteSettings(arguments: plan))),
                    ),
                    const Divider(color: alto),
                  ],
                ),
              );
            }
            return const Center(child: Text("retry"));
          }),
    );
  }
}
