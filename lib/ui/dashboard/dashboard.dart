import 'package:flutter/material.dart';
import 'package:rosabon/mix/ui_tool_mixin.dart';
import 'package:rosabon/ui/dashboard/choose_plan/choose_plan_screen.dart';
import 'package:rosabon/ui/dashboard/create_plan/create_plan_screen.dart';
import 'package:rosabon/ui/dashboard/home/home_screen.dart';
import 'package:rosabon/ui/dashboard/wallet/wallet_screen.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, this.page = 0}) : super(key: key);

  int page;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with UiToolMixin {
  late DateTime currentBackPressTime;

  int currentIndex = 0;

  List<Widget> screen = const [
    HomeScreen(),
    CreatePlanScreen(),
    // ProductScreen(),
    ChoosePlanScreen(),
    WalletScreen()
  ];
  @override
  void initState() {
    currentIndex = widget.page;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWilPop,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          unselectedItemColor: alto,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: deepKoamaru,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home.png")),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/create.png")),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/plan.png")),
              label: 'Plan',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/wallet.png")),
              label: 'Wallet',
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWilPop() {
    DateTime now = DateTime.now();

    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      showMessage('Press back one more time to exit the app', context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
