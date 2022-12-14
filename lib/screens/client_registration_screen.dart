// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, implementation_imports, unnecessary_import, avoid_print, sized_box_for_whitespace, unused_field, unused_import, prefer_final_fields, use_build_context_synchronously, unused_element, avoid_web_libraries_in_flutter

import 'dart:io';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/widgets/custom_input.dart';
import 'package:nanirecruitment/widgets/dropdown_form_field.dart';
import 'package:nanirecruitment/widgets/image_input.dart';
import 'package:nanirecruitment/widgets/license_type.dart';
import 'package:nanirecruitment/widgets/password_input.dart';
import 'package:nanirecruitment/widgets/radio_button.dart';
import 'package:nanirecruitment/widgets/radio_yes_no.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:provider/provider.dart';

class ClientRegistrationScreen extends StatefulWidget {
  const ClientRegistrationScreen({super.key});
  static const routeName = '/client-registration-screen';

  @override
  State<ClientRegistrationScreen> createState() =>
      _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  final _fnameFocusNode = FocusNode();
  final _fname = TextEditingController();
  final _lnameFocusNode = FocusNode();
  final _lname = TextEditingController();
  final _genderFocusNode = FocusNode();
  final _gender = TextEditingController();
  final _locationFocusNode = FocusNode();
  final _location = TextEditingController();
  final _mobileFocusNode = FocusNode();
  final _mobile = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _title = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _email = TextEditingController();
  final _LanguagesFocusNode = FocusNode();
  final _Languages = TextEditingController();
  final _noknameFocusNode = FocusNode();
  final _nokname = TextEditingController();
  final _nokaddressFocusNode = FocusNode();
  final _nokaddress = TextEditingController();
  final _nokmobileFocusNode = FocusNode();
  final _nokmobile = TextEditingController();
  final _user_nameFocusNode = FocusNode();
  final _user_name = TextEditingController();
  final _passwdFocusNode = FocusNode();
  final _passwd = TextEditingController();
  final _imageUrlControler = TextEditingController();

  var _addcandidate = Candidate(
      role_id: '',
      fname: '',
      lname: '',
      gender: '',
      location: '',
      mobile: '',
      title: '',
      email: '',
      Languages: '',
      nokname: '',
      nokaddress: '',
      nokmobile: '',
      user_name: '',
      passwd: '',
      imageUrl: null);

  var _isInit = true;
  var _isLoading = false;
  final _titleControler = TextEditingController();
  final controller = TextEditingController();
  File? _pickImage;
  String selectedValue = 'Male';
  void selectImage(File pickImage) {
    _pickImage = pickImage;
  }

  late Future _jobsFuture;
  int currentStep = 0;
  String job_role_id() {
    final jobId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    return jobId;
  }

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
      await Provider.of<Candidate>(context, listen: false).addCandidate(_addcandidate, _pickImage!, job_role_id(), selectedValue);
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error accurred!'),
                content: Text('Something went wrong!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okey'),
                    onPressed: () {
                      // Navigator.of(ctx).pop();
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // setState(() {
    //   job_role_id();
      print(job_role_id());
    //   // _jobsFuture = _saveForm();
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Screen'),
      ),
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
                      (currentStep == getSteps(selectImage).length - 1);
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
                steps: getSteps(selectImage),
              )),
    );
  }

  List<Step> getSteps(void Function(File pickImage) selectImage) {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Info "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInput(
                  hint: "Enter First Name",
                  label: "First Name",
                  icon: Icon(Icons.person_outline),
                  controller: _fname,
                  textInputAction: TextInputAction.next,
                  focusNode: _fnameFocusNode,
                  onSubmitted: (value) {
                    print(value);
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: value,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                  onChanged: (value) {
                    print(value);
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: value,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                CustomInput(
                  hint: "Enter Last Name",
                  label: "Last Name",
                  icon: Icon(Icons.person_outline),
                  controller: _lname,
                  textInputAction: TextInputAction.next,
                  focusNode: _lnameFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: value,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Gender',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ],
                ),
                RadioButton(
                  radio_one: 'Male',
                  radio_one_value: 'Male',
                  radio_two: 'Female',
                  radio_two_value: 'Female',
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      print(selectedValue);
                      _addcandidate = Candidate(
                          role_id: _addcandidate.role_id,
                          fname: _addcandidate.fname,
                          lname: _addcandidate.lname,
                          gender: selectedValue,
                          location: _addcandidate.location,
                          mobile: _addcandidate.mobile,
                          title: _addcandidate.title,
                          email: _addcandidate.email,
                          Languages: _addcandidate.Languages,
                          nokname: _addcandidate.nokname,
                          nokaddress: _addcandidate.nokaddress,
                          nokmobile: _addcandidate.nokmobile,
                          user_name: _addcandidate.user_name,
                          passwd: _addcandidate.passwd,
                          imageUrl: _addcandidate.imageUrl);
                    });
                  },
                  selectedValue: selectedValue,
                ),
                CustomInput(
                  hint: "Enter Location",
                  label: "Location",
                  keyboardtype: TextInputType.streetAddress,
                  icon: Icon(Icons.location_on_outlined),
                  controller: _location,
                  textInputAction: TextInputAction.next,
                  focusNode: _locationFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: value,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                CustomInput(
                  keyboardtype: TextInputType.phone,
                  hint: "Enter Phone Number",
                  label: "Phone Number",
                  icon: Icon(Icons.phone),
                  controller: _mobile,
                  textInputAction: TextInputAction.next,
                  focusNode: _mobileFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: value,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                CustomInput(
                  keyboardtype: TextInputType.emailAddress,
                  hint: "Enter Email Address",
                  label: "Email",
                  icon: Icon(Icons.email_outlined),
                  controller: _email,
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: value,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
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
        title: const Text("Profile "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TitleDropdownFormField(
                  onChanged: (value) {
                    setState(() {
                      // selectedValue = value;

                      _addcandidate = Candidate(
                          role_id: _addcandidate.role_id,
                          fname: _addcandidate.fname,
                          lname: _addcandidate.lname,
                          gender: _addcandidate.gender,
                          location: _addcandidate.location,
                          mobile: _addcandidate.mobile,
                          title: value,
                          email: _addcandidate.email,
                          Languages: _addcandidate.Languages,
                          nokname: _addcandidate.nokname,
                          nokaddress: _addcandidate.nokaddress,
                          nokmobile: _addcandidate.nokmobile,
                          user_name: _addcandidate.user_name,
                          passwd: _addcandidate.passwd,
                          imageUrl: _addcandidate.imageUrl);
                    });
                  },
                ),
                ImageInput(selectImage),
                CustomInput(
                  hint: "Languges your",
                  maxlines: 3,
                  maxlength: 100,
                  icon: Icon(Icons.language_outlined),
                  keyboardtype: TextInputType.multiline,
                  label: "Language",
                  controller: _Languages,
                  textInputAction: TextInputAction.next,
                  focusNode: _LanguagesFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: value,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                    print(value);
                    print(_addcandidate.imageUrl);
                    print(_addcandidate.fname);
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    //  Text('Next of kin Info',  style: TextStyle(  fontSize: 18, color: Colors.black,)),
                    Text('Next of kin Info below...',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left),
                  ],
                ),
                CustomInput(
                  hint: "Enter Full Name",
                  label: "Full Name",
                  controller: _nokname,
                  icon: Icon(Icons.person_outline),
                  textInputAction: TextInputAction.next,
                  focusNode: _noknameFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: value,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                CustomInput(
                  hint: "Enter Location",
                  keyboardtype: TextInputType.streetAddress,
                  label: "Location",
                  icon: Icon(Icons.location_on_outlined),
                  controller: _nokaddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _nokaddressFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: value,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                CustomInput(
                  keyboardtype: TextInputType.phone,
                  hint: "Enter Phone Number",
                  label: "Phone Number",
                  icon: Icon(Icons.phone),
                  controller: _nokmobile,
                  textInputAction: TextInputAction.next,
                  focusNode: _nokmobileFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: value,
                        user_name: _addcandidate.user_name,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("credentials"),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomInput(
                  hint: "User Name",
                  keyboardtype: TextInputType.emailAddress,
                  label: "Enter User Name",
                  controller: _user_name,
                  icon: Icon(Icons.person_outline),
                  textInputAction: TextInputAction.next,
                  focusNode: _user_nameFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: value,
                        passwd: _addcandidate.passwd,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                PasswordInput(
                  text: 'Type your password below...',
                  textInputAction: TextInputAction.next,
                  focusNode: _passwdFocusNode,
                  onSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    _addcandidate = Candidate(
                        role_id: _addcandidate.role_id,
                        fname: _addcandidate.fname,
                        lname: _addcandidate.lname,
                        gender: _addcandidate.gender,
                        location: _addcandidate.location,
                        mobile: _addcandidate.mobile,
                        title: _addcandidate.title,
                        email: _addcandidate.email,
                        Languages: _addcandidate.Languages,
                        nokname: _addcandidate.nokname,
                        nokaddress: _addcandidate.nokaddress,
                        nokmobile: _addcandidate.nokmobile,
                        user_name: _addcandidate.user_name,
                        passwd: value,
                        imageUrl: _addcandidate.imageUrl);
                  },
                ),
                PasswordInput(text: 'Confirm password'),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
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
      //   Step(
      //   state: currentStep > 3 ? StepState.complete : StepState.indexed,
      //   isActive: currentStep >= 3,
      //   title: const Text("hh"),
      //   content: Container(
      //     height: MediaQuery.of(context).size.height - 250,
      //     child: Column(
      //       children: const [
      //         CustomInput(
      //           hint: "Bio",
      //           inputBorder: OutlineInputBorder(),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      //   Step(
      //   state: currentStep > 4 ? StepState.complete : StepState.indexed,
      //   isActive: currentStep >= 4,
      //   title:
      //   const Text("Misc"),
      //   content: Container(
      //     height: MediaQuery.of(context).size.height - 250,
      //     child: Column(
      //       children: const [
      //         CustomInput(
      //           hint: "Bio",
      //           inputBorder: OutlineInputBorder(),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ];
  }
}
