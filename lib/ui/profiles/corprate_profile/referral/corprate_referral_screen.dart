import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';

class CorprateReferralScreen extends StatelessWidget {
  CorprateReferralScreen({Key? key}) : super(key: key);
  final SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            title: const Text("Referral Link",
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: ListView(
          children: [
            Text(
              "Referral Link",
              style: TextStyle(
                  color: Theme.of(context).dividerColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Montserrat"),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text("9GarGmf6VxO6KLNY84aMYeZ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: deepKoamaru),
                  child: InkWell(
                    enableFeedback: true,
                    onTap: () {
                      FlutterClipboard.copy(_sessionManager.referralLinkVal)
                          .then((value) => print('copied'));
                      Fluttertoast.showToast(
                          msg: "Copied!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: const Text("Copy",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Referral Code",
              style: TextStyle(
                  color: Theme.of(context).dividerColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Montserrat"),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                      _sessionManager.referralLinkVal.isEmpty
                          ? "No referal link to copy"
                          : _sessionManager.referralLinkVal.isEmpty.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: deepKoamaru),
                  child: InkWell(
                    enableFeedback: true,
                    onTap: () {
                      FlutterClipboard.copy(
                              _sessionManager.referralLinkVal.isEmpty
                                  ? "No referal link to copy"
                                  : _sessionManager.referralLinkVal.isEmpty
                                      .toString())
                          .then((value) => print('copied'));
                      Fluttertoast.showToast(
                          msg: "Copied!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: const Text("Copy",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
