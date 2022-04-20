import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
//import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SellReceiptPage extends StatefulWidget {
  const SellReceiptPage(this.shop, this.customerName, this.totalPrice,
      this.totalDiscount, this.totalVat
      // this.transaction,
      );
  final Shop shop;
  final String customerName;
  final int totalPrice;
  final int totalDiscount;
  final int totalVat;

  //final Transactions transaction;

  @override
  State<SellReceiptPage> createState() => _SellReceiptPageState();
}

class _SellReceiptPageState extends State<SellReceiptPage> {
  final SellController sc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sell Receipt")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(compress: true);
    //final font = await PdfGoogleFonts.nunitoExtraLight();

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
                                  "${widget.shop.name}",
                                  style: pw.TextStyle(
                                      //color: DEFAULT_BLACK,
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(
                                  "${widget.shop.publicNumber}",
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
                            "${widget.shop.address}",
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
                                widget.customerName.isEmpty
                                    ? "Not Given"
                                    : "${widget.customerName}",
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
                                Utility.dateTimeFormat
                                    .format(transaction.createdAt)
                                    .toString(),
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
                                "${widget.totalPrice}",
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
                    itemCount: sc.cart.length,
                    itemBuilder: (pw.Context context, int index) {
                      Product item = sc.cart[index];
                      print("pdf item list: ${item.name}");
                      var totalPrice = item.sellingPrice;
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
                                          "${item.sellingPrice}",
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
                                        "1",
                                        //  "${item..toString()}",
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
                                  "${widget.totalPrice} Tk",
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
                                  "${widget.totalDiscount} Tk",
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
                                  // "${widget.transaction.totalVat} Tk",
                                  "${widget.totalVat} Tk",
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
                                  "${widget.totalPrice} Tk",
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
