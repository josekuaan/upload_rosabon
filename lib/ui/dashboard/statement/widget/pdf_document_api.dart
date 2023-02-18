import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rosabon/model/response_models/plan_history_response.dart';
import 'package:rosabon/model/response_models/transaction_response.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class PdfducumentApi {
  static Future<File> generate(List<Transaction> transaction) async {
    final pdf = Document();

    // for (var el in transaction) {
    pdf.addPage(MultiPage(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        build: (context) => [buildPage(transaction)]));
    // }
    return SavePdf.saveDocument(name: "pdf_name.pdf", pdf: pdf);
  }

  static Future<File> generatePlanPdf(
      List<History> history, String currency) async {
    final pdf = Document();

    // for (var el in transaction) {
    pdf.addPage(MultiPage(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        build: (context) => [buildPlanPage(history)]));
    // }
    return SavePdf.saveDocument(name: "pdf_name.pdf", pdf: pdf);
  }

  static Widget buildPlanPage(List<History> el) {
    return Column(children: [
      Container(
          color: PdfColors.blue,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 120,
              child: Text("ID",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Date",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Type",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Amount\n(NGN)",
                  style: TextStyle(
                    fontSize: 22,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            )
          ])),
      SizedBox(height: 10),
      Container(
          child: Column(
              children: el
                  .map((e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      // width: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(e.transactionId.toString(),
                              style: const TextStyle(
                                // fontFamily: "Montserrat",
                                fontSize: 16,
                                // fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(
                            width: 120,
                            child: Text(
                                DateFormat("dd-MM-yyyy")
                                    .format(e.dateOfTransaction!)
                                    .toString(),
                                style: const TextStyle(
                                  // fontFamily: "Montserrat",
                                  fontSize: 16,
                                  // color:
                                  //  Theme.of(context).dividerColor,
                                  // fontWeight:  FontWeight.w300,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(e.type.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                                MoneyFormatter(amount: e.amount!)
                                    .output
                                    .nonSymbol,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.right),
                          )
                        ],
                      )))
                  .toList()))
    ]);
  }

  static Widget buildPage(List<Transaction> el) {
    return Column(children: [
      Container(
          color: PdfColors.blue,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 120,
              child: Text("ID",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Date",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Type",
                  style: TextStyle(
                    fontSize: 24,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 120,
              child: Text("Amount\n(NGN)",
                  style: TextStyle(
                    fontSize: 22,
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            )
          ])),
      SizedBox(height: 10),
      Container(
          child: Column(
              children: el
                  .map((e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(e.transactionId.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(
                                DateFormat("dd-MM-yyyy")
                                    .format(DateFormat("dd-MM-yyyy")
                                        .parse(e.transactionDate!))
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(e.transactionType.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(
                                MoneyFormatter(amount: e.debit!)
                                    .output
                                    .nonSymbol,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.right),
                          )
                        ],
                      )))
                  .toList()))
    ]);
  }
}

class SavePdf {
  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    var uuid = Uuid();
    String filesName = uuid.v1();
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${filesName.substring(0, 10)}.pdf');

    await file.writeAsBytes(bytes);

    return file;
  }
}

Future screenToPdf(String fileName, Uint8List screenShot) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a6,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  final bytes = await pdf.save();
  final path = await getApplicationDocumentsDirectory();
  File pdfFile = File('${path.path}/$fileName.pdf');

  pdfFile.writeAsBytes(bytes);
  await Share.shareFiles([pdfFile.path]);
}
