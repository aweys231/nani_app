// ignore_for_file: non_constant_identifier_names, implementation_imports, unnecessary_import, prefer_const_constructors, avoid_unnecessary_containers, unused_field, avoid_print, sized_box_for_whitespace, prefer_final_fields, unused_local_variable, await_only_futures, unnecessary_null_comparison, unused_import, unused_element, dead_code, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:nanirecruitment/widgets/upload_canidate_document.dart';
import 'package:nanirecruitment/widgets/upload_required_documents.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../Showmodel.dart';
import '../downloadFile.dart';
import '../services/api_urls.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_input.dart';
import '../widgets/image_input.dart';
import '../widgets/license_type.dart';
import '../widgets/radio_button.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../widgets/my_input.dart';

import 'auth_screen.dart';

class CanidateLegalInfor extends StatefulWidget {
  static const routeName = '/canidate-legal-infor';
  CanidateLegalInfor(this.candidate_id, {super.key});
  final String? candidate_id;

  @override
  State<CanidateLegalInfor> createState() => _CanidateLegalInforState();
}

class _CanidateLegalInforState extends State<CanidateLegalInfor> {
  final _form = GlobalKey<FormState>();
  final _postcodeFocusNode = FocusNode();
  final _bank_nameFocusNode = FocusNode();
  final _account_numberFocusNode = FocusNode();
  final _sort_codeFocusNode = FocusNode();
  final _postcode = TextEditingController();
  final _have_license = TextEditingController();
  final _driver_licensetypeFocusNode = FocusNode();
  final _driver_licensetype = TextEditingController();
  final _member = TextEditingController();
  final _bodynameFocusNode = FocusNode();
  final _bodyname = TextEditingController();
  final _amountofcoverFocusNode = FocusNode();
  final _amountofcover = TextEditingController();
  final _policynumberFocusNode = FocusNode();
  final _policynumber = TextEditingController();
  final _expiry_dateFocusNode = FocusNode();
  final _expiry_date = TextEditingController();
  final _bank_name = TextEditingController();
  final _account_number = TextEditingController();
  final _sort_code = TextEditingController();

  final _dbs_certificate_numberFocusNode = FocusNode();
  final _dbs_certificate_number = TextEditingController();

  final _imageUrlControler = TextEditingController();

  var _editeLegalInfot = LegalInfo(
      postcode: '',
      have_license: '',
      driver_licensetype: '',
      member: '',
      bodyname: '',
      amountofcover: '',
      policynumber: '',
      expiry_date: '',
      dbs_certificate_number: '',
      Bank_Name: '',
      Account_Number: '',
      Sort_Code: '',
      imageUrl: null);

  var _initValues = {
    'postcode': '',
    'have_license': '',
    'driver_licensetype': '',
    'member': '',
    'bodyname': '',
    'amountofcover': '',
    'policynumber': '',
    'expiry_date': '',
    'dbs_certificate_number': '',
    'Bank_Name': '',
    'Account_Number': '',
    'Sort_Code': '',
    'imageUrl': ''
  };

  var _isInit = true;
  var _isLoading = false;
  final _titleControler = TextEditingController();
  final controller = TextEditingController();
  String? selectedfile;
  String have_license = 'yes';
  String member = 'yes';
  void selectFiles(String pickFile) {
    selectedfile = pickFile;
  }

  @override
  void initState() {
    setState(() {
      _documentsFuture = _obtainOrdersFuture();
    });
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (widget.candidate_id == null) {
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    }
    if (_isInit) {
      if (widget.candidate_id.toString() != null) {
        _editeLegalInfot = await Provider.of<LegalInfo>(context, listen: false)
            .findById(widget.candidate_id.toString());
        _initValues = {
          'postcode': _editeLegalInfot.postcode!,
          'have_license': _editeLegalInfot.have_license!,
          'driver_licensetype': _editeLegalInfot.driver_licensetype!,
          'member': _editeLegalInfot.member!,
          'bodyname': _editeLegalInfot.bodyname!,
          'amountofcover': _editeLegalInfot.amountofcover!,
          'policynumber': _editeLegalInfot.policynumber!,
          'expiry_date': _editeLegalInfot.expiry_date!,
          'dbs_certificate_number': _editeLegalInfot.dbs_certificate_number!,
          'imageUrl': ''
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int currentStep = 0;
  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      var message = await Provider.of<LegalInfo>(context, listen: false)
          .updateLegalInfo(_editeLegalInfot, selectedfile!, have_license,
              member, widget.candidate_id.toString());
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('success'),
                content: Text(message.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okay'),
                    onPressed: () {
                      // Navigator.of(ctx).pop();
                      Navigator.of(context).pushNamed('/');
                    },
                  )
                ],
              ));
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text(error.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okey'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  void _clearTextField(TextEditingController controller) {
    // Clear everything in the text field
    controller.clear();
    // Call setState to update the UI
    setState(() {});
  }

  late Future _documentsFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .requirement_documents();
  }

  Future<String> fetchDocumentUrl(String candidateId) async {
    int candidateIdInt = int.tryParse(candidateId) ?? 0; // Convert to int

    var response = await http.post(
      Uri.parse('${ApiUrls.BASE_URL}client_app/getApplication'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'candidate_id': candidateIdInt}),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data is List && data.isNotEmpty && data[0]['application_file'] is String) {
        return data[0]['application_file']; // Access the first element of the array
      } else {
        throw Exception('Unexpected data format or empty list');
      }
    } else {
      throw Exception('Failed to load document with status code ${response.statusCode}');
    }
  }

  // final pdfUrl = 'https://manage.nanirecruitment.com/img/candoc/20230822123141119.pdf';
  // final pdfUrl =
  //     'https://manage.nanirecruitment.com/img/candoc/20230822123141119.pdf';

  //preview after download ...
  Future<void> _showPdfPreview(BuildContext context, String pdfUrl) async {
    try {
      // Download the PDF from the provided URL
      final pdfData = await http.get(Uri.parse(pdfUrl));

      // Get a temporary directory to store the downloaded PDF
      final tempDir = await getTemporaryDirectory();

      // Create a File instance for the downloaded PDF
      final pdfFile = File('${tempDir.path}/downloaded_document.pdf');

      // Write the PDF bytes (from the response) to the file
      await pdfFile.writeAsBytes(pdfData.bodyBytes);

      // Use Navigator to push a new route that displays the PDF
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('PDF Preview')),
            body: PDFView(
              filePath: pdfFile.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageSnap: true,
            ),
          ),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during download or display
      print('Error displaying PDF: $e');
    }
  }
  // Future<void> _showPdfPreview(BuildContext context) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Scaffold(
  //         appBar: AppBar(
  //           title: Text('PDF Preview'),
  //         ),
  //         body: PDFView(
  //           filePath: pdfUrl, // Provide the URL of the PDF file
  //           enableSwipe: true,
  //           swipeHorizontal: true,
  //           autoSpacing: false,
  //           pageSnap: true,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: Scaffold(
      backgroundColor: Color(0xfff0f0f6),
      appBar: AppBar(
        title: Text('welcome'),
        backgroundColor: bggcolor,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              try {
                String candidateId = widget.candidate_id!; // Ensure this is non-null
                print('Candidate ID: $candidateId');
                String docUrl = await fetchDocumentUrl(candidateId);
                print('Document URL: $docUrl');
                _showPdfPreview(context, docUrl);
              } catch (e) {
                print('Error fetching document: $e');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Text(
                    'Application Form',
                    style: TextStyle(color: txtcolor, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        String candidateId = widget.candidate_id!; // Retrieve signed-in candidate's ID again
                        String docUrl = await fetchDocumentUrl(candidateId);
                        _showPdfPreview(context, docUrl);
                        FileDownloader.downloadFile(url: docUrl); // Use the fetched URL here
                      } catch (e) {
                        // Handle errors
                        print('Error: $e');
                      }
                    },
                    icon: Icon(
                      Icons.download,
                      color: txtcolor,
                      size: 33,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(3),
              child: Stepper(
                physics: ClampingScrollPhysics(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (currentStep < 2)
                          ElevatedButton(
                            onPressed: controls.onStepContinue,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: bggcolor),
                            child: const Text('NEXT'),
                          ),
                        if (currentStep > 0)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: bggcolor),
                            onPressed: controls.onStepCancel,
                            child: Text(
                              'BACK',
                            ),
                          ),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepCancel: () => currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      }),
                onStepContinue: () {
                  bool isLastStep =
                      (currentStep == getSteps(selectFiles).length - 1);
                  if (isLastStep) {
                    //Do something with this information
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
                steps: getSteps(selectFiles),
              )),
    ));
  }

  List<Step> getSteps(void Function(String pickImage) selectImage) {
    return <Step>[
      //first screen profile stepper content....
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Profile "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  mCustomInput(
                    hint: "Enter Post code",
                    label: "Post code",
                    icon: Icon(Icons.person_outline),
                    controller: _postcode,
                    textInputAction: TextInputAction.next,
                    focusNode: _postcodeFocusNode,
                    suffixIcon: _postcode.text.isEmpty
                        ? null // Show nothing if the text field is empty
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _clearTextField(_postcode);
                            },
                          ),
                    onSubmitted: (value) {
                      print(value);
                      _editeLegalInfot = LegalInfo(
                          postcode: value,
                          have_license: have_license,
                          driver_licensetype: '',
                          member: '',
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                      setState(() {});
                    },
                    onChanged: (value) {
                      print(value);
                      print(value);
                      _editeLegalInfot = LegalInfo(
                          postcode: value,
                          have_license: have_license,
                          driver_licensetype: '',
                          member: '',
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                    },
                    // onValidate: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Filed is Required';
                    //   }
                    //   return null;
                    // },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Have license',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  RadioButton(
                    radio_one: 'Yes',
                    radio_one_value: 'Yes',
                    radio_two: 'No',
                    radio_two_value: 'No',
                    onChanged: (value) {
                      setState(() {
                        have_license = value;
                        print('this is $have_license');
                        _editeLegalInfot = LegalInfo(
                            postcode: _editeLegalInfot.postcode,
                            have_license: have_license,
                            driver_licensetype:
                                _editeLegalInfot.driver_licensetype,
                            member: member,
                            bodyname: _editeLegalInfot.bodyname,
                            amountofcover: _editeLegalInfot.amountofcover,
                            policynumber: _editeLegalInfot.policynumber,
                            expiry_date: _editeLegalInfot.expiry_date,
                            dbs_certificate_number:
                                _editeLegalInfot.dbs_certificate_number,
                            imageUrl: null);
                      });
                    },
                    selectedValue: have_license,
                  ),
                  have_license == 'yes' || have_license == 'Yes'
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('license type',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            LicenseType(
                              onChanged: (value) {
                                print(value);
                                _editeLegalInfot = LegalInfo(
                                    postcode: _editeLegalInfot.postcode,
                                    have_license: _editeLegalInfot.have_license,
                                    driver_licensetype: value,
                                    member: _editeLegalInfot.member,
                                    bodyname: _editeLegalInfot.bodyname,
                                    amountofcover:
                                        _editeLegalInfot.amountofcover,
                                    policynumber: _editeLegalInfot.policynumber,
                                    expiry_date: _editeLegalInfot.expiry_date,
                                    dbs_certificate_number:
                                        _editeLegalInfot.dbs_certificate_number,
                                    imageUrl: null);
                              },
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Member',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  RadioButton(
                    radio_one: 'Yes',
                    radio_one_value: 'Yes',
                    radio_two: 'No',
                    radio_two_value: 'NO',
                    onChanged: (value) {
                      setState(() {
                        member = value;
                        print(member);
                        _editeLegalInfot = LegalInfo(
                            postcode: _editeLegalInfot.postcode,
                            have_license: have_license,
                            driver_licensetype:
                                _editeLegalInfot.driver_licensetype,
                            member: member,
                            bodyname: _editeLegalInfot.bodyname,
                            amountofcover: _editeLegalInfot.amountofcover,
                            policynumber: _editeLegalInfot.policynumber,
                            expiry_date: _editeLegalInfot.expiry_date,
                            dbs_certificate_number:
                                _editeLegalInfot.dbs_certificate_number,
                            imageUrl: null);
                      });
                    },
                    selectedValue: member,
                  ),
                  member == 'yes' || member == 'Yes'
                      ? Column(
                          children: [
                            mCustomInput(
                              hint: "Enter Member Name",
                              label: "Member name",
                              keyboardtype: TextInputType.text,
                              icon: Icon(Icons.business_outlined),
                              controller: _bodyname,
                              textInputAction: TextInputAction.next,
                              focusNode: _bodynameFocusNode,
                              onSubmitted: (value) {},
                              // onValidate: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Field is Required';
                              //   }
                              //   return null;
                              // },
                              onChanged: (value) {
                                _editeLegalInfot = LegalInfo(
                                    postcode: _editeLegalInfot.postcode,
                                    have_license: have_license,
                                    driver_licensetype:
                                        _editeLegalInfot.driver_licensetype,
                                    member: _editeLegalInfot.member,
                                    bodyname: value,
                                    amountofcover:
                                        _editeLegalInfot.amountofcover,
                                    policynumber: _editeLegalInfot.policynumber,
                                    expiry_date: _editeLegalInfot.expiry_date,
                                    dbs_certificate_number:
                                        _editeLegalInfot.dbs_certificate_number,
                                    imageUrl: null);
                              },
                            ),
                            mCustomInput(
                              keyboardtype: TextInputType.number,
                              hint: "Enter Amount to cover",
                              label: "over amount",
                              icon: Icon(Icons.money),
                              controller: _amountofcover,
                              textInputAction: TextInputAction.next,
                              focusNode: _amountofcoverFocusNode,
                              onSubmitted: (value) {},
                              // onValidate: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Filed is Required';
                              //   }
                              //   return null;
                              // },
                              onChanged: (value) {
                                _editeLegalInfot = LegalInfo(
                                    postcode: _editeLegalInfot.postcode,
                                    have_license: have_license,
                                    driver_licensetype:
                                        _editeLegalInfot.driver_licensetype,
                                    member: _editeLegalInfot.member,
                                    bodyname: _editeLegalInfot.bodyname,
                                    amountofcover: value,
                                    policynumber: _editeLegalInfot.policynumber,
                                    expiry_date: _editeLegalInfot.expiry_date,
                                    dbs_certificate_number:
                                        _editeLegalInfot.dbs_certificate_number,
                                    imageUrl: null);
                              },
                            ),
                            mCustomInput(
                              keyboardtype: TextInputType.emailAddress,
                              hint: "Enter Policy Number",
                              label: "Policy Number",
                              icon: Icon(Icons.policy_outlined),
                              controller: _policynumber,
                              textInputAction: TextInputAction.next,
                              focusNode: _policynumberFocusNode,
                              onSubmitted: (value) {},
                              // onValidate: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Filed is Required';
                              //   }
                              //   return null;
                              // },
                              onChanged: (value) {
                                _editeLegalInfot = LegalInfo(
                                    postcode: _editeLegalInfot.postcode,
                                    have_license: have_license,
                                    driver_licensetype:
                                        _editeLegalInfot.driver_licensetype,
                                    member: _editeLegalInfot.member,
                                    bodyname: _editeLegalInfot.bodyname,
                                    amountofcover:
                                        _editeLegalInfot.amountofcover,
                                    policynumber: value,
                                    expiry_date: _editeLegalInfot.expiry_date,
                                    dbs_certificate_number:
                                        _editeLegalInfot.dbs_certificate_number,
                                    imageUrl: null);
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              child: TextField(
                                keyboardType: TextInputType.datetime,
                                controller: _expiry_date,
                                textInputAction: TextInputAction.next,
                                focusNode: _expiry_dateFocusNode,
                                onTap: () async {
                                  //when click we have to show the datepicker
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime
                                          .now(), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    //get the picked date in the format => 2022-07-04 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    //formatted date output using intl package =>  2022-07-04
                                    //You can format date as per your need

                                    setState(() {
                                      _expiry_date.text =
                                          formattedDate; //set foratted date to TextField value.
                                      _editeLegalInfot = LegalInfo(
                                          postcode: _editeLegalInfot.postcode,
                                          have_license: have_license,
                                          driver_licensetype: _editeLegalInfot
                                              .driver_licensetype,
                                          member: _editeLegalInfot.member,
                                          bodyname: _editeLegalInfot.bodyname,
                                          amountofcover:
                                              _editeLegalInfot.amountofcover,
                                          policynumber:
                                              _editeLegalInfot.policynumber,
                                          expiry_date: formattedDate,
                                          dbs_certificate_number:
                                              _editeLegalInfot
                                                  .dbs_certificate_number,
                                          imageUrl: null);
                                    });
                                  } else {}
                                },
                                onChanged: (value) {
                                  _editeLegalInfot = LegalInfo(
                                      postcode: _editeLegalInfot.postcode,
                                      have_license: have_license,
                                      driver_licensetype:
                                          _editeLegalInfot.driver_licensetype,
                                      member: _editeLegalInfot.member,
                                      bodyname: _editeLegalInfot.bodyname,
                                      amountofcover:
                                          _editeLegalInfot.amountofcover,
                                      policynumber:
                                          _editeLegalInfot.policynumber,
                                      expiry_date: value,
                                      dbs_certificate_number: _editeLegalInfot
                                          .dbs_certificate_number,
                                      imageUrl: null);
                                },
                                onSubmitted: (value) {},
                                decoration: InputDecoration(
                                  hintText: 'Enter Date',
                                  labelText: 'Expire date',
                                  hintStyle: TextStyle(color: txtcolor),
                                  labelStyle: TextStyle(color: txtcolor),
                                  prefixIcon: Icon(Icons.date_range_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            mCustomInput(
                              keyboardtype: TextInputType.emailAddress,
                              hint: "Enter Certificate Number",
                              label: "Certificate  Number",
                              icon: Icon(Icons.numbers_rounded),
                              suffixIcon: _dbs_certificate_number.text.isEmpty
                                  ? null // Show nothing if the text field is empty
                                  : IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: (() {
                                        _clearTextField(
                                            _dbs_certificate_number);
                                      }),
                                    ), // Show the clear button if the text field has something
                              controller: _dbs_certificate_number,
                              textInputAction: TextInputAction.next,
                              focusNode: _dbs_certificate_numberFocusNode,
                              onSubmitted: (value) {},
                              // onValidate: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Filed is Required';
                              //   }
                              //   return null;
                              // },
                              onChanged: (value) {
                                _editeLegalInfot = LegalInfo(
                                    postcode: _editeLegalInfot.postcode,
                                    have_license: have_license,
                                    driver_licensetype:
                                        _editeLegalInfot.driver_licensetype,
                                    member: _editeLegalInfot.member,
                                    bodyname: _editeLegalInfot.bodyname,
                                    amountofcover:
                                        _editeLegalInfot.amountofcover,
                                    policynumber: _editeLegalInfot.policynumber,
                                    expiry_date: _editeLegalInfot.expiry_date,
                                    dbs_certificate_number: value,
                                    imageUrl: null);
                                setState(() {});
                              },
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
      // second screen account info stepper content....
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Account Info "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  CustomInput(
                    hint: "Enter Bank Name",
                    label: "Bank Name",
                    icon: Icon(Icons.person_outline),
                    controller: _bank_name,
                    textInputAction: TextInputAction.next,
                    focusNode: _bank_nameFocusNode,
                    suffixIcon: _bank_name.text.isEmpty
                        ? null // Show nothing if the text field is empty
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _clearTextField(_bank_name);
                            },
                          ),
                    onSubmitted: (value) {
                      print(value);
                      _editeLegalInfot = LegalInfo(
                          postcode: value,
                          have_license: have_license,
                          driver_licensetype: '',
                          member: '',
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                      setState(() {});
                    },
                    onChanged: (value) {
                      print(value);
                      print(value);
                      _editeLegalInfot = LegalInfo(
                          postcode: value,
                          have_license: have_license,
                          driver_licensetype: '',
                          member: '',
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                    },
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Filed is Required';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    keyboardtype: TextInputType.number,
                    hint: "Enter Account Number",
                    label: "Account Number",
                    icon: Icon(Icons.money),
                    controller: _account_number,
                    textInputAction: TextInputAction.next,
                    focusNode: _account_numberFocusNode,
                    onSubmitted: (value) {},
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Filed is Required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _editeLegalInfot = LegalInfo(
                          postcode: _editeLegalInfot.postcode,
                          have_license: have_license,
                          driver_licensetype:
                              _editeLegalInfot.driver_licensetype,
                          member: _editeLegalInfot.member,
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: value,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                    },
                  ),
                  CustomInput(
                    keyboardtype: TextInputType.emailAddress,
                    hint: "Enter Sort Code",
                    label: "Sort  Code",
                    icon: Icon(Icons.numbers_rounded),
                    suffixIcon: _sort_code.text.isEmpty
                        ? null // Show nothing if the text field is empty
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: (() {
                              _clearTextField(_sort_code);
                            }),
                          ), // Show the clear button if the text field has something
                    controller: _sort_code,
                    textInputAction: TextInputAction.next,
                    focusNode: _sort_codeFocusNode,
                    onSubmitted: (value) {},
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Filed is Required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _editeLegalInfot = LegalInfo(
                          postcode: _editeLegalInfot.postcode,
                          have_license: have_license,
                          driver_licensetype:
                              _editeLegalInfot.driver_licensetype,
                          member: _editeLegalInfot.member,
                          bodyname: _editeLegalInfot.bodyname,
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: _editeLegalInfot.expiry_date,
                          dbs_certificate_number: value,
                          imageUrl: null);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // thrid screeen document stepper content ...
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text("Document", style: TextStyle(color: txtcolor)),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    //  Text('Next of kin Info',  style: TextStyle(  fontSize: 18, color: Colors.black,)),
                    Text('Candidate document...',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left),
                  ],
                ),
                // UploadDocument(selectFiles),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Row(children: [
                    Expanded(
                      child: FutureBuilder(
                          future: _documentsFuture,
                          builder: (ctx, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (dataSnapshot.error != null) {
                                return Center(child: Text('An error Accour'));
                                print(dataSnapshot.error);
                              } else {
                                return Consumer<job.Jobs_Section>(
                                    builder: (ctx, jobData, child) => jobData
                                            .document.isNotEmpty
                                        ? ListView.builder(
                                            // scrollDirection: Axis.horizontal,
                                            itemCount: jobData.document.length,
                                            itemBuilder: (ctx, i) => Container(
                                                  child:
                                                      UploadRequiredDocuments(
                                                    onSelectFile: selectFiles,
                                                    documents:
                                                        jobData.document[i],
                                                    icon: Icons
                                                        .cloud_upload_outlined,
                                                    candidate_id: widget
                                                        .candidate_id
                                                        .toString(),
                                                  ),
                                                  // Text(i.toString()),
                                                ))
                                        : Center(
                                            child: const Text(
                                              'No results found',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ));
                              }
                            }
                          }),
                    )
                  ]),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10, top: 20),
                  // color: Colors.blue,
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context)
                            .primaryTextTheme
                            .labelLarge!
                            .color,
                        backgroundColor: bggcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ];
  }
}

// The DismissKeybaord widget (it's reusable)
class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
