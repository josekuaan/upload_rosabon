import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rosabon/bloc/auth/wallet/wallet_bloc.dart';
import 'package:rosabon/model/response_models/transaction_response.dart';
import 'package:rosabon/ui/dashboard/statement/widget/pdf_document_api.dart';
import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/widgets/app_bar.dart';
// import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MyTransactionDetails extends StatefulWidget {
  const MyTransactionDetails({Key? key}) : super(key: key);

  @override
  State<MyTransactionDetails> createState() => _MyTransactionDetailsState();
}

class _MyTransactionDetailsState extends State<MyTransactionDetails> {
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
  void initState() {
    walletBloc = WalletBloc();
    walletBloc.add(const FetchWalletTransctions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: map["title"].toString()),
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
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
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
            child: BlocConsumer<WalletBloc, WalletState>(
              bloc: walletBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is WalletTransLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TransactionSuccess) {
                  if (state.transactionResponse.transaction!.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount:
                            state.transactionResponse.transaction!.length,
                        itemBuilder: (context, index) {
                          Transaction transaction =
                              state.transactionResponse.transaction![index];

                          return InkWell(
                            onTap: (() {
                              modalDetail(context, transaction, map);
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
                                          "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.debit! : transaction.debit!).output.nonSymbol}",
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
                                          "${NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN").currencySymbol}${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.debit! : transaction.debit!).output.nonSymbol}",
                                          // "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.debit! : transaction.debit!).output.nonSymbol}",
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
                    );
                  } else {
                    return const SizedBox(
                        height: 200,
                        child: Center(child: Text("No Transactions yet.")));
                  }
                }
                return const Center(child: Text("retry"));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> modalDetail(BuildContext context, Transaction transaction,
      Map<dynamic, dynamic> map) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 10,
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
              child: ListView(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: transaction.transactionType == "DEBIT"
                                      ? wepeep
                                      : narvik,
                                  borderRadius: BorderRadius.circular(5)),
                              child: transaction.transactionType == "DEBIT"
                                  ? SvgPicture.asset(
                                      "assets/images/arrow.svg",
                                      color:
                                          transaction.transactionType == "DEBIT"
                                              ? redOrange
                                              : Colors.green,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/arrow_down.svg",
                                      color:
                                          transaction.transactionType == "DEBIT"
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
                                    Text(transaction.transactionType == "CREDIT"
                                        ? "+"
                                        : "-"),
                                    Text(
                                      "₦${MoneyFormatter(amount: transaction.transactionType == "CREDIT" ? transaction.debit! : transaction.debit!).output.nonSymbol}",
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
                            SizedBox(
                              child: Text(
                                transaction.transactionDate.toString(),
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
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
                              "Description",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12,
                                color: Theme.of(context).dividerColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                transaction.description.toString(),
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
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
                              "₦${MoneyFormatter(amount: transaction.balanceAfterTransaction!).output.nonSymbol}",
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
                    ]),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        screenshotController.capture().then((image) {
                          if (image != null) {
                            screenToPdf(transaction.transactionId!, image);
                          }
                        }).catchError((onError) {
                          print(onError);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: gray),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(child: Text('Download PDF'))),
                    ),
                  ),
                ],
              ),
            ));
  }
}
