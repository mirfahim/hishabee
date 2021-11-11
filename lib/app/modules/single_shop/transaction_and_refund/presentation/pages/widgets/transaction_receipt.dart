import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransactionReceiptPage extends StatelessWidget {
  const TransactionReceiptPage({this.shop, this.transaction});
  final Shop shop;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction Receipt")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Container(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    height: 60,
                    width: 300,
                    //color: DEFAULT_YELLOW_BG,
                    child: pw.Row(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(
                            "Receipt",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Spacer(),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Container(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  "${shop.name}",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(
                                  "${shop.publicNumber}",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(
                            "${shop.address}",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Container(
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                "Customer",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.normal),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                transaction.customerName == null
                                    ? "Not Given"
                                    : "${transaction.customerName}",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Container(
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                "Sell Time",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.normal),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              /*pw.Text(
                                "${Utility.dateTimeFormat.format(transaction.createdAt)}",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Container(
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                "Total Amount",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.normal),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                "${transaction.totalPrice}",
                                style: pw.TextStyle(
                                    //color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Divider(
                    //color: pw.DEFAULT_BLACK,
                    thickness: 2,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Container(
                          width: 100,
                          child: pw.Text(
                            "Product Name",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 5, right: 5),
                        child: pw.Container(
                          width: 50,
                          child: pw.Center(
                            child: pw.Text(
                              "price",
                              style: pw.TextStyle(
                                  //color: DEFAULT_BLACK,
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 5, right: 5),
                        child: pw.Container(
                          width: 50,
                          child: pw.Text(
                            "Quantity",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 5, right: 5),
                        child: pw.Container(
                          width: 60,
                          child: pw.Text(
                            "Total Price",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Divider(
                    //color: DEFAULT_BLACK,
                    thickness: 2,
                  ),
                  pw.ListView.builder(
                    itemCount: transaction.transactionItems.length,
                    itemBuilder: (pw.Context context, int index) {
                      TransactionItem item =
                          transaction.transactionItems[index];
                      print("pdf item list: ${item.name}");
                      var totalPrice = item.price * item.quantity;
                      return pw.Container(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(8.0),
                                  child: pw.Container(
                                    width: 100,
                                    child: pw.Text(
                                      "${item.name}",
                                      style: pw.TextStyle(
                                          //color: DEFAULT_BLACK,
                                          fontSize: 16,
                                          fontWeight: pw.FontWeight.normal),
                                    ),
                                  ),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      top: 8.0, bottom: 8, left: 5, right: 5),
                                  child: pw.Container(
                                    width: 50,
                                    child: pw.Center(
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "${item.price}",
                                          style: pw.TextStyle(
                                              //color: DEFAULT_BLACK,
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      top: 8.0, bottom: 8, left: 5, right: 5),
                                  child: pw.Container(
                                    width: 50,
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "${item.quantity.toString()}",
                                        style: pw.TextStyle(
                                            //color: DEFAULT_BLACK,
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      top: 8.0, bottom: 8, left: 5, right: 5),
                                  child: pw.Container(
                                    width: 60,
                                    child: pw.Align(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        "${totalPrice.toString()}",
                                        style: pw.TextStyle(
                                            //color: DEFAULT_BLACK,
                                            fontSize: 16,
                                            fontWeight: pw.FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Divider(
                              //color: DEFAULT_BLACK.withOpacity(0.5),
                              thickness: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Text(
                            "Total price :",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 20.0),
                            child: pw.Container(
                              width: 60,
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  "${transaction.totalPrice} Tk",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Text(
                            "(-) Discount :",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 20.0),
                            child: pw.Container(
                              width: 60,
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  "${transaction.totalDiscount} Tk",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Text(
                            "vat :",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 20.0),
                            child: pw.Container(
                              width: 60,
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  "${transaction.totalVat} Tk",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Container(
                        width: 100,
                        child: pw.Divider(
                            //color: DEFAULT_BLACK.withOpacity(0.5),
                            )),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Text(
                            "Total Amount :",
                            style: pw.TextStyle(
                                //color: DEFAULT_BLACK,
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 20.0),
                            child: pw.Container(
                              width: 60,
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  "${transaction.totalPrice} Tk",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}
