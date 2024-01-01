import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/screens/worksheet.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:intl/intl.dart';

import '../widgets/pdfButton.dart';


class TimesheetPage extends StatefulWidget {
  final String CLIENT_NAME;
  final String CLIENT_ADDRESS;
  final String BUSINESS_UNITE;
  final String WEEK_ENDING_DATE;
  final String CANDIDATE_NAME;

  const TimesheetPage({
    Key? key,
    required this.CLIENT_NAME,
    required this.CLIENT_ADDRESS,
    required this.BUSINESS_UNITE,
    required this.WEEK_ENDING_DATE,
    required this.CANDIDATE_NAME,
  }) : super(key: key);

  @override
  State<TimesheetPage> createState() => _TimesheetPageState();
}

class _TimesheetPageState extends State<TimesheetPage> {
  // DateTime now = DateTime.now();
  String formattedDateTime =
  DateFormat('yyyy-MM-dd \t  hh-mm-ss-a').format(DateTime.now());
  String formattedDateTime1 =
  DateFormat('yyyy-MM-dd \t  hh-mm-ss-a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            padding: EdgeInsets.only(
                top: constraints.maxWidth * 0.01 * 16,
                left: constraints.maxWidth * 0.01 * 4,
                right: constraints.maxWidth * 0.01 * 4),
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/logoimage/Naniwhite.jpg'),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: constraints.maxWidth * 0.04),
                  Text(
                    "NANI RECRUITMENT LTD",
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: bggcolor,
                    ),
                  ),
                  SizedBox(height: constraints.maxWidth * 0.04),
                  Container(
                    // height: 175,
                    height: constraints.maxWidth * 0.38,
                    // width: 360,
                    width: constraints.maxWidth * 0.90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          //todo:sender;
                          Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CLIENT NAME: ${widget.CLIENT_NAME}',
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: txtcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 1, color: Colors.grey.withOpacity(0.5)),
                          Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CLIENT ADDRESS: ${widget.CLIENT_ADDRESS}",
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: txtcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 1, color: Colors.grey.withOpacity(0.5)),
                          Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BUSINESS UNITE: ${widget.BUSINESS_UNITE}',
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: txtcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 1, color: Colors.grey.withOpacity(0.5)),
                          Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WEEK – ENDING DATE: : ${widget.WEEK_ENDING_DATE}",
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: txtcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 1, color: Colors.grey.withOpacity(0.5)),
                          Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CANDIDATE NAME: ${widget.CANDIDATE_NAME}',
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: txtcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //todo:receiver
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxWidth * 0.03),
                  Column(
                    children: [
                      Text(
                        "HOURS WORKED",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.040,
                          fontWeight: FontWeight.bold,
                          color: txtcolor,
                        ),
                      ),
                      WorksheetHeader(),
                    ],
                  ),
                  SizedBox(height: constraints.maxWidth * 0.01 * 2),
                  InkWell(
                    onTap: () {
                      printOrSaveAsPdf1();
                    },
                    child: AppButton(
                      icon: Icons.print,
                      text: "PRINT",
                      backgroundColor: bggcolor,
                      textColor: Colors.black,
                      // onTap: () {
                      //   Navigator.pop(context);
                      // },
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  //todo: SharePDF
  Future<void> printOrSaveAsPdf1() async {
    final pdf = pw.Document();
    // Add background image
    final Uint8List backgroundImage =
    (await rootBundle.load('assets/logoimage/Naniwhite.jpg')).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            decoration: pw.BoxDecoration(
              image: pw.DecorationImage(
                image: pw.MemoryImage(backgroundImage),
                fit: pw.BoxFit.cover,
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 75),
                pw.Text(
                  'NANI RECRUITMENT LTD 71-75 Shelton Street',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    // color: PdfColor.fromInt(0xFFb34f6b)
                    color: PdfColor.fromInt(0xFF1a2b57),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'Covent Garden, London WC2H 9JQ.',
                  style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      // color: PdfColors.grey,
                      color: PdfColor.fromInt(0xFFb34f6b)),
                ),
                pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.only(left: 40)),
                        pw.Text(
                          'Date: $formattedDateTime',
                          style: pw.TextStyle(
                            fontSize: 16,
                            // fontWeight: pw.FontWeight.,
                            color: PdfColors.grey,
                          ),
                        ),
                      ],
                    ),
                    // pw.SizedBox(height: 5),
                  ],
                ),

                pw.SizedBox(
                  height: 10,
                ),
                pw.Container(
                    height: 2, // Replace with your desired thickness
                    width: 395,
                    // color: PdfColors.grey,
                    color: PdfColor.fromInt(0xFFb34f6b)
                  // color: PdfColor.fromInt(0xFF1a2b57),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                //sender
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Padding(
                      // padding: pw.EdgeInsets.only(left: 40)),
                      padding: pw.EdgeInsets.only(left: 40, top: 30),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          width: 10,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "CLIENT NAME: ",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              widget.CLIENT_NAME,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 2, // Replace with your desired thickness
                          width: 395,
                          color: PdfColors.grey,
                          // color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "CLIENT ADDRESS: ",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "${widget.CLIENT_ADDRESS}",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 2, // Replace with your desired thickness
                          width: 395,
                          color: PdfColors.grey,
                          // color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "BUSINESS UNITE: ",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              widget.BUSINESS_UNITE,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey,
                              ),
                            ),
                            pw.SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 2, // Replace with your desired thickness
                          width: 395,
                          color: PdfColors.grey,
                          // color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "WEEK ENDING DATE: ",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              widget.WEEK_ENDING_DATE,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey,
                              ),
                            ),
                            pw.SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 2, // Replace with your desired thickness
                          width: 395,
                          color: PdfColors.grey,
                          // color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "CANDIDATE NAME: ",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.Text(
                              widget.CANDIDATE_NAME,
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey,
                              ),
                            ),
                            pw.SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                            height: 2, // Replace with your desired thickness
                            width: 395,
                            color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          width: 400,
                          child: pw.Center(
                            child: pw.FittedBox(
                              fit: pw.BoxFit.fitWidth,
                              child: pw.Text(
                                'HOURS WORKED',
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 2, // Replace with your desired thickness
                          width: 395,
                          color: PdfColors.grey,
                          // color: PdfColor.fromInt(0xFFb34f6b)
                          // color: PdfColor.fromInt(0xFF1a2b57),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          width: double.infinity, // or specify a fixed width
                          child: pw.Row(
                            children: [
                              pw.Container(width: 70, child: pw.Text('DAY')),
                              pw.Container(width: 70, child: pw.Text('DATE')),
                              pw.Container(width: 70, child: pw.Text('TIME_S')),
                              pw.Container(width: 70, child: pw.Text('TIME_F')),
                              pw.Container(width: 70, child: pw.Text('BREAK')),
                              pw.Container(width: 70, child: pw.Text('HOURS_W')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(
                  height: 10,
                ),
                pw.Container(
                    height: 2, // Replace with your desired thickness
                    width: 395,
                    // color: PdfColors.grey,
                    color: PdfColor.fromInt(0xFFb34f6b)
                  // color: PdfColor.fromInt(0xFF1a2b57),
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(left: 40, top: 30),
                      ),
                      //sender
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            width: 10,
                          ),
                          buildDayRow('Mon'),
                          buildDayRow('Tues'),
                          buildDayRow('Wed'),
                          buildDayRow('Thurs'),
                          buildDayRow('Fri'),
                          buildDayRow('Sat'),
                          buildDayRow('Sun'),
                        ],
                      ),
                      //end Receiver;
                    ]),
                // pw.SizedBox(
                //   height: 15,
                // ),
                pw.Container(
                    height: 2, // Replace with your desired thickness
                    width: 395,
                    // color: PdfColors.grey,
                    color: PdfColor.fromInt(0xFFb34f6b)
                  // color: PdfColor.fromInt(0xFF1a2b57),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 40, top: 20),
                        ),
                        pw.Text("SIGNATURE:"),
                        pw.Text("________________________",
                          // style: pw.TextStyle(
                          //   fontSize: 16,
                          //   fontWeight: pw.FontWeight.bold,
                          //   color: PdfColors.black,
                          // ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Text("DATE:"),
                        // _buildFormFieldWithLine("Date:"),
                        pw.Text("______________________"),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 40),
                        ),
                        pw.Text("PRINT NAME:"),
                        pw.Text(
                            "______________________________________________"),
                        pw.SizedBox(height: 5),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 40),
                        ),
                        pw.Text("POSITION:"),
                        pw.Text(
                            "______________________________________________"),
                        pw.SizedBox(height: 5),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 40),
                        ),
                        pw.Text("DEPARTMENT:"),
                        pw.Text(
                            "______________________________________________"),
                        // Divider(thickness: 2.0, color: Colors.grey),
                        pw.SizedBox(width: 5),
                      ],
                    ),
                    // pw.Text("hello")
                  ],
                ),
                pw.Text(
                  'I certify that the total ……… hours have been satisfactorily worked and that payment will'
                      'be mode hours in respect of these according to your terms and conditions of business which '
                      'I have received and accept as the basic of this transaction',
                  style: pw.TextStyle(
                    fontSize: 16,
                    // fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'PrintedDay_details_$formattedDateTime.pdf',
    );
  }

  pw.Widget buildDayRow(String day) {
    return pw.Row(
      children: [
        // pw.Expanded(child: pw.Text(day)),
        pw.Container(width: 70, child: pw.Text(day)),
        pw.Container(
          width: 1.0,
          height: 40,
          color: PdfColors.grey,
        ),
        // pw.Expanded(child: pw.Text('DATE')),
        pw.Container(width: 70, child: pw.Text('')),
        pw.Container(
          width: 1.0,
          height: 40,
          color: PdfColors.grey,
        ),
        // Add other widgets for date, time_s, time_f, break, hours as needed
        // pw.Expanded(child: pw.Text('TIME_S')),
        pw.Container(width: 70, child: pw.Text('')),
        pw.Container(
          width: 1.0,
          height: 40,
          color: PdfColors.grey,
        ),
        // pw.Expanded(child: pw.Text('TIME_F')),
        pw.Container(width: 70, child: pw.Text('')),
        pw.Container(
          width: 1.0,
          height: 40,
          color: PdfColors.grey,
        ),
        // pw.Expanded(child: pw.Text('BREAK')),
        pw.Container(width: 70, child: pw.Text('')),
        pw.Container(
          width: 1.0,
          height: 40,
          color: PdfColors.grey,
        ),
        // pw.Expanded(child: pw.Text('HOURS')),
        pw.Container(width: 70, child: pw.Text('')),
      ],
    );
  }
}
