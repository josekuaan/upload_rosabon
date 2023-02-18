import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/deposit_history_response.dart';
import 'package:rosabon/ui/dashboard/statement/widget/pdf_document_api.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

class Wallettransactions extends StatefulWidget {
  const Wallettransactions({super.key});

  @override
  State<Wallettransactions> createState() => _WallettransactionsState();
}

class _WallettransactionsState extends State<Wallettransactions> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  final amount = TextEditingController();
  final reasonforwithdrawal = TextEditingController();
  late WalletBloc walletBloc;
  String startDate = "Start Date";
  String endDate = "End Date";
  DateFormat formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss a");
  String getDateTime(String dateFromServer) {
    dateFromServer = dateFromServer.replaceAll(" ", "");
    dateFromServer = dateFromServer.replaceAll("T", " ");
    return dateFromServer;
  }

  Future<void> _selectDate(BuildContext context, type) async {
    DateFormat formatter =
        DateFormat('yyyy-MM-dd'); //specifies day/month/year format
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (type == "Start Date") {
          startDate = formatter.format(picked);
        } else {
          endDate = formatter.format(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as List<Deposit>;
    print(map);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(title: "Credit Wallet Transfer Deposit"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Filter by Transaction Date",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat"),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.40,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: softpeach, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 3),
                        Text(startDate),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const SizedBox(width: 5),
                              const VerticalDivider(thickness: 2, color: alto),
                              IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                onPressed: () =>
                                    _selectDate(context, "Start Date"),
                                icon: const Icon(Icons.calendar_today_outlined,
                                    size: 20),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.40,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: softpeach, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 3),
                        Text(endDate),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const SizedBox(width: 5),
                              const VerticalDivider(
                                thickness: 2,
                                color: alto,
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                onPressed: () =>
                                    _selectDate(context, "End Date"),
                                icon: const Icon(Icons.calendar_today_outlined,
                                    size: 20),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
              child: map.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: map.length,
                        itemBuilder: (context, index) {
                          Deposit transaction = map[index];

                          return InkWell(
                            onTap: (() {
                              modalDetail(context, transaction);
                            }),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //"Apr 28, 2022"
                                        Text(
                                          transaction.transactionDate
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 10,
                                            color:
                                                Theme.of(context).dividerColor,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          transaction.transactionId.toString(),
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Wallet ${transaction.transactionType}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).dividerColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 15.w,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: transaction.transactionType ==
                                                "DEBIT"
                                            ? wepeep
                                            : narvik,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: transaction.transactionType ==
                                            "DEBIT"
                                        ? SvgPicture.asset(
                                            "assets/images/arrow.svg",
                                            color:
                                                transaction.transactionType ==
                                                        "DEBIT"
                                                    ? redOrange
                                                    : Colors.green,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/arrow_down.svg",
                                            color:
                                                transaction.transactionType ==
                                                        "DEBIT"
                                                    ? softpeach
                                                    : Colors.green,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.amount! : transaction.amount!).output.nonSymbol}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            color:
                                                transaction.transactionType ==
                                                        "DEBIT"
                                                    ? Colors.black
                                                    : Colors.green,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.amount! : transaction.amount!).output.nonSymbol}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            color: Colors.grey[40],
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Image.asset("assets/images/empty_state_card.png")))
        ],
      ),
    );
  }

  Future<dynamic> modalDetail(BuildContext context, Deposit transaction) {
    return showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (ctx) => Container(
              height: 500,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    child: Screenshot(
                      controller: screenshotController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color:
                                          transaction.transactionType == "DEBIT"
                                              ? wepeep
                                              : narvik,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: transaction.transactionType == "DEBIT"
                                      ? SvgPicture.asset(
                                          "assets/images/arrow.svg",
                                          color: transaction.transactionType ==
                                                  "DEBIT"
                                              ? redOrange
                                              : Colors.green,
                                        )
                                      : SvgPicture.asset(
                                          "assets/images/arrow_down.svg",
                                          color: transaction.transactionType ==
                                                  "DEBIT"
                                              ? softpeach
                                              : Colors.green,
                                        ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(transaction.transactionType ==
                                                "CREDIT"
                                            ? "+"
                                            : "-"),
                                        Text(
                                          "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.amount! : transaction.amount!).output.nonSymbol}",
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Wallet ${transaction.transactionType}",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        color: Theme.of(context).dividerColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction ID",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transaction.transactionId.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            color: alto,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction Date",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                //"April 20,2022"
                                Text(
                                  transaction.transactionDate.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            color: alto,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transcation Type",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transaction.transactionType.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            color: alto,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Balance",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "₦${MoneyFormatter(amount: transaction.balance!).output.nonSymbol}",
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transaction.description.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            color: alto,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      screenshotController.capture().then((image) {
                        if (image != null) {
                          screenToPdf(
                              "wallet_credit${transaction.transactionId!}",
                              image);
                        }
                      }).catchError((onError) {
                        print(onError );
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: gray),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text('Download PDF')),
                  ),
                ],
              ),
            ));
  }
}
