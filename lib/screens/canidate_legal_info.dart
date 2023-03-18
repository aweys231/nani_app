// ignore_for_file: non_constant_identifier_names, implementation_imports, unnecessary_import, prefer_const_constructors, avoid_unnecessary_containers, unused_field, avoid_print, sized_box_for_whitespace, prefer_final_fields, unused_local_variable, await_only_futures, unnecessary_null_comparison, unused_import, unused_element, dead_code

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:nanirecruitment/widgets/upload_canidate_document.dart';
import 'package:nanirecruitment/widgets/upload_required_documents.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_input.dart';
import '../widgets/image_input.dart';
import '../widgets/license_type.dart';
import '../widgets/radio_button.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

class CanidateLegalInfor extends StatefulWidget {
  static const routeName = '/canidate-legal-infor';
  const CanidateLegalInfor(this.candidate_id, {super.key});
  final String? candidate_id;

  @override
  State<CanidateLegalInfor> createState() => _CanidateLegalInforState();
}

class _CanidateLegalInforState extends State<CanidateLegalInfor> {
  final _postcodeFocusNode = FocusNode();
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
    // final isValid = _form.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<LegalInfo>(context, listen: false).updateLegalInfo(
          _editeLegalInfot,
          selectedfile!,
          have_license,
          member,
          widget.candidate_id.toString());
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error accurred!'),
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

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: Scaffold(
      backgroundColor: Color(0xfff0f0f6),
      appBar: AppBar(
        title: Text('welcome'),
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
                        ElevatedButton(
                          onPressed: controls.onStepContinue,
                          child: const Text('NEXT'),
                        ),
                        if (currentStep != 0)
                          TextButton(
                            onPressed: controls.onStepCancel,
                            child: const Text(
                              'BACK',
                              style: TextStyle(color: Colors.grey),
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
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Profile "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInput(
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
                      print(have_license);
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
                        amountofcover: _editeLegalInfot.amountofcover,
                        policynumber: _editeLegalInfot.policynumber,
                        expiry_date: _editeLegalInfot.expiry_date,
                        dbs_certificate_number:
                            _editeLegalInfot.dbs_certificate_number,
                        imageUrl: null);
                  },
                ),
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
                CustomInput(
                  hint: "Enter Member Name",
                  label: "Member name",
                  keyboardtype: TextInputType.text,
                  icon: Icon(Icons.business_outlined),
                  controller: _bodyname,
                  textInputAction: TextInputAction.next,
                  focusNode: _bodynameFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _editeLegalInfot = LegalInfo(
                        postcode: _editeLegalInfot.postcode,
                        have_license: have_license,
                        driver_licensetype: _editeLegalInfot.driver_licensetype,
                        member: _editeLegalInfot.member,
                        bodyname: value,
                        amountofcover: _editeLegalInfot.amountofcover,
                        policynumber: _editeLegalInfot.policynumber,
                        expiry_date: _editeLegalInfot.expiry_date,
                        dbs_certificate_number:
                            _editeLegalInfot.dbs_certificate_number,
                        imageUrl: null);
                  },
                ),
                CustomInput(
                  keyboardtype: TextInputType.number,
                  hint: "Enter Amount to cover",
                  label: "over amount",
                  icon: Icon(Icons.money),
                  controller: _amountofcover,
                  textInputAction: TextInputAction.next,
                  focusNode: _amountofcoverFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _editeLegalInfot = LegalInfo(
                        postcode: _editeLegalInfot.postcode,
                        have_license: have_license,
                        driver_licensetype: _editeLegalInfot.driver_licensetype,
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
                  hint: "Enter Policy Number",
                  label: "Policy Number",
                  icon: Icon(Icons.policy_outlined),
                  controller: _policynumber,
                  textInputAction: TextInputAction.next,
                  focusNode: _policynumberFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _editeLegalInfot = LegalInfo(
                        postcode: _editeLegalInfot.postcode,
                        have_license: have_license,
                        driver_licensetype: _editeLegalInfot.driver_licensetype,
                        member: _editeLegalInfot.member,
                        bodyname: _editeLegalInfot.bodyname,
                        amountofcover: _editeLegalInfot.amountofcover,
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
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime
                              .now(), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          _expiry_date.text =
                              formattedDate; //set foratted date to TextField value.
                          _editeLegalInfot = LegalInfo(
                              postcode: _editeLegalInfot.postcode,
                              have_license: have_license,
                              driver_licensetype:
                                  _editeLegalInfot.driver_licensetype,
                              member: _editeLegalInfot.member,
                              bodyname: _editeLegalInfot.bodyname,
                              amountofcover: _editeLegalInfot.amountofcover,
                              policynumber: _editeLegalInfot.policynumber,
                              expiry_date: formattedDate,
                              dbs_certificate_number:
                                  _editeLegalInfot.dbs_certificate_number,
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
                          amountofcover: _editeLegalInfot.amountofcover,
                          policynumber: _editeLegalInfot.policynumber,
                          expiry_date: value,
                          dbs_certificate_number:
                              _editeLegalInfot.dbs_certificate_number,
                          imageUrl: null);
                    },
                    onSubmitted: (value) {
                      _saveForm();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Date',
                      labelText: 'Expire date',
                      prefixIcon: Icon(Icons.date_range_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                CustomInput(
                  keyboardtype: TextInputType.emailAddress,
                  hint: "Enter Certificate Number",
                  label: "Certificate  Number",
                  icon: Icon(Icons.numbers_rounded),
                  suffixIcon: _dbs_certificate_number.text.isEmpty
                      ? null // Show nothing if the text field is empty
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: (() {
                            _clearTextField(_dbs_certificate_number);
                          }),
                        ), // Show the clear button if the text field has something
                  controller: _dbs_certificate_number,
                  textInputAction: TextInputAction.next,
                  focusNode: _dbs_certificate_numberFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _editeLegalInfot = LegalInfo(
                        postcode: _editeLegalInfot.postcode,
                        have_license: have_license,
                        driver_licensetype: _editeLegalInfot.driver_licensetype,
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
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Document"),
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
                                            documents:
                                                jobData.document[i],
                                            onClicked: (() {}),
                                            icon: Icons
                                                .cloud_upload_outlined,
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
                        foregroundColor:
                            Theme.of(context).primaryTextTheme.button!.color,
                        backgroundColor: Theme.of(context).primaryColor,
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
