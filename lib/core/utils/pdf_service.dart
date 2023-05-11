// ignore_for_file: always_specify_types

import 'package:eighty_three_native_component/core/res/src/cubit/country/country_util.dart';
import 'package:eighty_three_native_component/core/shared/authentication/modules/login/provider/model/logged_in_user_model.dart';

import 'package:eighty_three_native_component/core/shared/receipt/provider/model/receipt_model.dart';
import 'package:eighty_three_native_component/core/utils/currency_util.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfService {
  Future<Uint8List> generate(
    ReceiptModel receipt, {
    String? qrData,
  }) async {
    final Document document = Document();
    final ByteData font =
        await rootBundle.load("assets/fonts/Bahij_TheSansArabic-Plain.ttf");

    final Font ttf = Font.ttf(font);
    final Uint8List logoBytes =
        await convertToImage('assets/images/more/about/about-icon.png');
    final MemoryImage logo = MemoryImage(logoBytes);
    final purpleColor = PdfColor.fromHex("#5d3f88");
    final Uint8List senderIconBytes =
        await convertToImage('assets/icons/receipt/sender.png');
    final Uint8List receiverIconBytes =
        await convertToImage('assets/icons/receipt/receive.png');
    final Uint8List phoneIconBytes =
        await convertToImage('assets/icons/receipt/phone-call.png');
    final Uint8List locationIconBytes =
        await convertToImage('assets/icons/receipt/location-pin.png');
    final Uint8List paymentIconBytes =
        await convertToImage('assets/icons/receipt/list.png');

    document.addPage(Page(
      theme: ThemeData(
          defaultTextStyle: TextStyle(
        font: ttf,
      )),
      build: (Context context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(logo, receipt),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                child: Text(
                  "Summary",
                  style: TextStyle(
                    color: PdfColor.fromHex("#3bb684"),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (qrData != null) ...[
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: BarcodeWidget(
                  width: 400,
                  height: 400,
                  data: qrData,
                  barcode: Barcode.qrCode(),
                ),
              ),
            ] else ...[
              _buildSenderDetails(senderIconBytes, purpleColor),
              SizedBox(height: 20),
              if (receipt.beneficiary != null) ...[
                _buildReceiverDetails(receiverIconBytes, purpleColor, receipt),
                SizedBox(height: 20),
              ],
              _buildPaymentDetails(paymentIconBytes, purpleColor, receipt),
            ],
            Spacer(),
            Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 30),
                color: purpleColor,
                child: Column(children: [
                  Row(children: [
                    Image(MemoryImage(phoneIconBytes), width: 12, height: 12),
                    SizedBox(width: 15),
                    Text(
                      "Contact US +966478323829",
                      style: const TextStyle(
                        color: PdfColors.white,
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Image(MemoryImage(locationIconBytes),
                        width: 12, height: 12),
                    SizedBox(width: 15),
                    Text(
                      "Derah Dist., P.O.Box: 6160 Postal Code: 11442",
                      style: const TextStyle(
                        color: PdfColors.white,
                      ),
                    ),
                  ])
                ])),
          ],
        );
      },
    ));
    final Uint8List pdfBytes = await document.save();
    return pdfBytes;
  }

  Row _buildPaymentDetails(
      Uint8List paymentIconBytes, PdfColor purpleColor, ReceiptModel receipt) {
    return Row(children: [
      Image(MemoryImage(paymentIconBytes), width: 50, height: 50),
      SizedBox(width: 20),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Payment Details",
          style: TextStyle(
            color: purpleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(
          color: purpleColor,
        ),

        ///----> sender details
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("PURPOSE OF REMITTANCE"),
          Text(receipt.purpose ?? ""),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("RELATIONSHIP"),
          Text(receipt.beneficiary?.relation ?? ""),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("FEES"),
          Text(receipt.fees ?? ""),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Discount"),
          Text(receipt.discount ?? ""),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Total Amount",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            receipt.amount ?? "0",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ])),
    ]);
  }

  Row _buildReceiverDetails(
      Uint8List receiverIconBytes, PdfColor purpleColor, ReceiptModel receipt) {
    return Row(children: [
      Image(MemoryImage(receiverIconBytes), width: 50, height: 50),
      SizedBox(width: 20),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Receiver Details",
              style: TextStyle(
                color: purpleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: purpleColor,
            ),

            ///----> sender details
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Receiver Name"),
              Text(receipt.beneficiary!.fullName),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Receiver Mobile No"),
              Text(receipt.beneficiary!.phoneNumber ?? "XXXXXXXXXX"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Country"),
              if (receipt.beneficiary!.countryId != -1) ...[
                Text(getCountry(
                      uuid: receipt.beneficiary!.countryId!,
                    ).name ??
                    ""),
              ] else ...[
                Text(loggedInUser.country!),
              ]
            ]),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Bank Name"),
              Text(receipt.beneficiary?.bankName?.isNotEmpty == false ||
                      receipt.beneficiary?.bankName == null
                  ? "XXXXXXX"
                  : receipt.beneficiary!.bankName!),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Account No"),
              Text(receipt.beneficiary?.accountNumber ?? "XXXXXXXXXXXXXXXX"),
            ]),
          ],
        ),
      ),
    ]);
  }

  Row _buildSenderDetails(Uint8List senderIconBytes, PdfColor purpleColor) {
    return Row(children: [
      Image(MemoryImage(senderIconBytes), width: 50, height: 50),
      SizedBox(width: 20),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sender Details",
              style: TextStyle(
                color: purpleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: purpleColor,
            ),

            ///----> sender details
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Sender Name"),
              Text(loggedInUser.name ?? ""),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Sender ID"),
              Text(loggedInUser.identityId ?? ""),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Country"),
              Text("SAUDI ARABIA"),
            ]),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Mobile Number"),
              Text(loggedInUser.phone ?? "XXXXXXXXXX"),
            ]),
          ],
        ),
      )
    ]);
  }

  Column _buildHeader(
    MemoryImage logo,
    ReceiptModel receipt,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Receipt from Res pay",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Image(
            logo,
            height: 50,
            width: 50,
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Transaction ID : ${receipt.id}",
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("AMOUNT"),
              Text(
                "${receipt.amount} ${receipt.beneficiary != null && receipt.beneficiary?.currencyId?.isNegative == false ? getCurrency(receipt.beneficiary!.currencyId!).name : "SAR"}",
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date"),
              Text(DateFormat('dd.MM.yyyy / hh:mm a', "en_US")
                  .format(receipt.date ?? DateTime.now())),
            ],
          ),
        ],
      ),
    ]);
  }

  Future<Uint8List> convertToImage(String name) async {
    final Uint8List data = (await rootBundle.load(name)).buffer.asUint8List();

    return data;
  }
}
