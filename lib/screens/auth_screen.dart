// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use, use_key_in_widget_constructors, constant_identifier_names, unused_local_variable, unused_field, sort_child_properties_last, library_private_types_in_public_api, avoid_print, unused_import, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanirecruitment/models/http_exception.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/providers/notification_service.dart';
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/dashboard.dart';
import 'package:nanirecruitment/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timezone/data/latest.dart' as tz;

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(13, 30, 113, 1).withOpacity(0.9),
                  Color.fromRGBO(169, 31, 103, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child:
 
                     Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                     
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: 
                      
                       Image.asset('assets/logoimage/logon.png',
                  height: 50,
                  fit: BoxFit.fill,
                  scale: 3.5,
                  // color: Color.fromARGB(255, 15, 147, 59),
                  opacity:
                      const AlwaysStoppedAnimation<double>(0.5)), 
                      // Text(
                      //   'NANI RECRUITMENT',
                      //   style: TextStyle(
                      //     color: Theme.of(context)
                      //         .accentTextTheme
                      //         .headline6!
                      //         .color,
                      //     fontSize: 18,
                      //     fontFamily: 'Anton',
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  // const AuthCard({
  //   required Key key,
  // }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  late final NotificationService notificationService;
  var _isInit = true;
  var _isLoading = false;
  bool _isLoadingDrop_data = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  DateTime scheduleTime = DateTime.now();
  @override
  void initState() {

    super.initState();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    // _heightAnimation.addListener(() => setState(() {}));
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    setState(() {
      _isLoadingDrop_data = true;
    });
    await Provider.of<Candidate>(context, listen: false)
        .fetchAndSetnatinality()
        .then((_) {});
    await Provider.of<Category_Section>(context, listen: false)
        .fetchAndSetAllCategory()
        .then((_) {});
   
    setState(() {
      _isLoadingDrop_data = false;
    });
    super.didChangeDependencies();
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
      print('hello welocom');
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email .';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      } else if (error.toString().contains('INACTIVE_EMAIL')) {
        errorMessage = 'Your Email Is not Active.';
      }
      print(error.toString());
      print('hello welocom');
      _showErrorDialog(error.toString());
    } catch (error) {
      const erroreMssage =
          'Could not authenticate you. Please try again later.';
      // _showErrorDialog(error.toString());
      _showErrorDialog(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
       elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height:  260,
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(minHeight:  260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),

      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'User Name'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryTextTheme.button!.color,
                    onPrimary: Theme.of(context).primaryColor,
                    onSurface: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  ),
                  child: Text('LOGIN'),
                  onPressed: _submit,
                ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text('SIGNUP  INSTEAD'),
                onPressed: (() async {
      
                 debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotifications(
            title: 'Scheduled Notification',
            body: '$scheduleTime',
            );
                  Navigator.pushNamed(
                      context, ClientRegistrationScreen.routeName);
                }),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
