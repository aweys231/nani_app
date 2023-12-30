// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, avoid_unnecessary_containers, unused_local_variable, empty_catches, unused_import, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, await_only_futures, use_build_context_synchronously, unused_element, unused_field


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'dart:io';

import '../widgets/image_input.dart';


class CanidateAttandance extends StatefulWidget {
  static const routeName = '/candidate-attandance';
  const CanidateAttandance({this.candidate_id, this.jobvacancy_id, super.key});
  final String? candidate_id;
  final String? jobvacancy_id;

  @override
  State<CanidateAttandance> createState() => _CanidateAttandanceState();
}

class _CanidateAttandanceState extends State<CanidateAttandance> {
  double screenHeight = 0;
  double screenWidth = 0;


  String checkInt = '--/--';
  String checkOut = '--/--';
  var


  checkdat;
  var candidateid;
  File? _selectedImage;


  void getRecode() async {
    try {
      checkdat = await Provider.of<Jobs_Section>(context, listen: false)
          .timeSheetChecking(
              widget.candidate_id.toString(),
              widget.jobvacancy_id.toString(),
              DateFormat('yyyy-MM-dd').format(DateTime.now()));

      print(checkdat[0]['time_in'].toString());
      if (checkdat[0]['time_in'].toString() != '' &&
          checkdat[0]['time_out'] != '') {
        setState(() {
          print('hello1');
          checkInt = checkdat[0]['time_in'].toString();
          checkOut = checkdat[0]['time_out'].toString();
        });
      } else if (checkdat[0]['time_in'] != '' &&
          checkdat[0]['time_out'] == '') {
        setState(() {
          print('hello2');
          checkInt = checkdat[0]['time_in'].toString();
          checkOut = '--/--';
        });
      }
    } catch (e) {
      setState(() {
        // checkInt = '--/--';
        // checkOut = '--/--';
        print('error ayaa jiro');
        print(e.toString());
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  var _isLoading = false;

  void _handleImage(File image) {
    setState(() {
      _selectedImage = image;
    });
    // You can add additional logic if needed
  }


  Future<File> getDefaultImageFile() async {
    final byteData = await rootBundle.load('assets/logoimage/icon01.png');
    final file = File('${(await getTemporaryDirectory()).path}/default_image.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }




  Future<void> _saveAttandance() async {
    // Check for null or empty string for candidate_id and jobvacancy_id
    if (widget.candidate_id == null || widget.candidate_id!.isEmpty ||
        widget.jobvacancy_id == null || widget.jobvacancy_id!.isEmpty) {
      print('data maleh');
      return;
    }

    // ... inside your async function where you make the provider call ...

    File imageFile = _selectedImage ?? await getDefaultImageFile();

    var message;
    setState(() {
      _isLoading = true;
    });

    try {
      // if (_selectedImage != null) {
        // Only proceed if _selectedImage is not null
        message = await Provider.of<Jobs_Section>(context, listen: false)
            .attandance_registration(
          widget.candidate_id!,
          widget.jobvacancy_id!,
          DateFormat('hh:mm:ss a').format(DateTime.now()).toString(),
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
            imageFile
        );

        // Dialog to show success message
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Success'),
              content: Text(message.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                )
              ],
            ));
      // } else {
      //   // Handle scenario when _selectedImage is null
      //   print('No image selected');
      //   // Optionally, show a dialog to inform the user
      // }
    } catch (error) {
      print(error);
      // Dialog to show error message
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
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
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    getRecode();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    candidateid = Provider.of<Auth>(context, listen: false);






    return Scaffold(
      appBar: AppBar(
        title: Text('Attandance'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                candidateid.candidate_id.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth / 20,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.jobvacancy_id.toString(),
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 73, 73),
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Today`s Status",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              "Check In",
                              style: TextStyle(
                                fontSize: screenWidth / 20,
                                fontFamily: 'Lato',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              checkInt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth / 20,
                                  fontFamily: 'Lato',
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              "Check Out",
                              style: TextStyle(
                                fontSize: screenWidth / 20,
                                fontFamily: 'Lato',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              checkOut,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth / 20,
                                  fontFamily: 'Lato',
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(color: Colors.purple),
                      children: [
                        TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        )
                      ]),
                )),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontFamily: 'Lato',
                          color: Colors.black54),
                    ),
                  );
                }),

            if (checkInt != '--/--' && checkOut == '--/--')
              // Show only after check-in
              ImageInput(_handleImage),
              // Additionally, display the selected image if available
            // if (_selectedImage != null)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Image.file(_selectedImage!),
            //   ),

            checkOut == '--/--'
                ? Container(
              margin: EdgeInsets.only(top: 24),
              child: Builder(builder: (context) {
                final GlobalKey<SlideActionState> key = GlobalKey();
                return SlideAction(
                  text: checkInt == '--/--'
                      ? "Slide To check In"
                      : "Slide To check Out",
                  textStyle: TextStyle(
                      fontSize: screenWidth / 20,
                      fontFamily: 'Lato',
                      color: Colors.black54),
                  outerColor: Colors.white,
                  innerColor: Colors.purple,
                  key: key,
                  onSubmit: (() {
                    setState(() {
                      _saveAttandance();
                    });
                    key.currentState!.reset();
                  }),
                );
              }),
            )
                : Container(
              child: Text('You have already checked out'),
            ),
          ],
        )

      ),
    );
  }
}
