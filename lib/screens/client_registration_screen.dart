// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, implementation_imports, unnecessary_import, avoid_print, sized_box_for_whitespace, unused_field, unused_import

import 'dart:io';

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


class ClientRegistrationScreen extends StatefulWidget {
  const ClientRegistrationScreen({super.key});
  static const routeName = '/client-registration-screen';
  
  @override
  State<ClientRegistrationScreen> createState() =>
      _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  final _titleControler = TextEditingController();
  final controller = TextEditingController();
  File? _pickImage;
  void selectImage(File pickImage) {
    _pickImage = pickImage;
  }
  int currentStep = 0;
  String job_role_id() {
    final jobId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    return jobId;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  setState(() {
    //     job_role_id();
    print(job_role_id());
    //   });
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Screen'),
        ),
        body:
        //  Container(
        //   child: Text(
        //     job_role_id(),
        //     style: TextStyle(fontSize: 24),
        //   ),
        // )
         Container(
          width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(3),
            child: Stepper(
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context, ControlsDetails controls) {
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
                bool isLastStep = (currentStep == getSteps(selectImage).length - 1);
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
    return  <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Info "),
        content: Container(
          height: MediaQuery.of(context).size.height - 250,
          child: SingleChildScrollView(
            child: Column(
                children:  [
                CustomInput(
                  hint: "Enter First Name",
                  label: "First Name",
                   icon: Icon(Icons.person_outline),
                  controller: controller,
                ),
                CustomInput(
                  hint: "Enter Last Name",
                  label: "Middle Name",
                   icon: Icon(Icons.person_outline),
                  controller: controller,
                ),
                 CustomInput(
                  hint: "Enter Last Name",
                  label: "Last Name",
                   icon: Icon(Icons.person_outline),
                 controller: controller,
                ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
       Text('Gender',  style: TextStyle(  fontSize: 16, color: Colors.black,)), 
      ],
    ),

                RadioButton(radio_one: 'Male', radio_two: 'Female', radio_one_value: 'Male', radio_two_value: 'Female'),
                
                 CustomInput(
                  hint: "Enter Location",
                  label: "Location",
                  keyboardtype: TextInputType.streetAddress,
                  icon: Icon(Icons.location_on_outlined),
                  controller: controller,
                ),
                 CustomInput(
                  keyboardtype: TextInputType.phone,            
                  hint: "Enter Phone Number",
                  label: "Phone Number",
                  icon: Icon(Icons.phone),
                  controller: controller,
                ),
                
                 CustomInput(
                  keyboardtype: TextInputType.emailAddress, 
                  hint: "Enter Email Address",
                  label: "Email",
                  icon: Icon(Icons.email_outlined),
                 controller: controller,
                ), 
                //  CustomInput(
                //   hint: "Enter Last Name",
                //   label: "Last Name",
                //   inputBorder: OutlineInputBorder(),
                // ), 
                //   CustomInput(
                //   hint: "Enter Last Name",
                //   label: "Last Name",
                //   inputBorder: OutlineInputBorder(),
                // ), 
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
              children:  [
                TitleDropdownFormField(),
                ImageInput(selectImage),
                 CustomInput(
                  hint: "Languges your",                  
                        maxlines: 3,
                        maxlength: 100,
                        icon: Icon(Icons.language_outlined),
                        keyboardtype: TextInputType.multiline,
                  label: "Language",
                  controller: controller,
                ), 

               
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
      //  Text('Next of kin Info',  style: TextStyle(  fontSize: 18, color: Colors.black,)), 
      Text('Next of kin Info below...',
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
      ],
    ),
                CustomInput(
                  hint: "Enter Full Name",
                  label: "Full Name",
                  controller: controller,
                  icon: Icon(Icons.person_outline),
                ),
                 CustomInput(
                  hint: "Enter Location",
                  keyboardtype: TextInputType.streetAddress,
                  label: "Location",
                  icon: Icon(Icons.location_on_outlined),
                  controller: controller,
                ),
                 CustomInput(
                  keyboardtype: TextInputType.phone,            
                  hint: "Enter Phone Number",
                  label: "Phone Number",
                  icon: Icon(Icons.phone),
                  controller: controller,
                ),
    //              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: const [
    //    Text('Have license',  style: TextStyle(  fontSize: 16, color: Colors.black,)), 
    //   ],
    // ),
             

            // RadioYesNo(),
            
    //      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: const [
    //    Text('license type',  style: TextStyle(  fontSize: 16, color: Colors.black,)), 
    //   ],
    // ),

                // LicenseType(),
              
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
              children:  [
               
                
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        CustomInput(
                  hint: "User Name",                  
                        keyboardtype: TextInputType.emailAddress,
                  label: "Enter User Name",
                  icon: Icon(Icons.person_outline),
                  
                ),
               
                PasswordInput(text:'Type your password below...'),
                PasswordInput(text:'Confirm password'),
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
     foregroundColor:Theme.of(context).primaryTextTheme.button!.color,  
     backgroundColor: Theme.of(context).primaryColor,
      
    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),        
  ),
                    onPressed: (){},
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

