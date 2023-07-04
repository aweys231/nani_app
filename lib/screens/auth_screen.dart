// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use, use_key_in_widget_constructors, constant_identifier_names, unused_local_variable, unused_field, sort_child_properties_last, library_private_types_in_public_api, avoid_print, unused_import, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanirecruitment/constants.dart';
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
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as dt;
import 'package:timezone/data/latest.dart' as tz;
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    bool hidePassword = true;

    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F7F9'),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: deviceSize.height,
                width: deviceSize.width,

                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      height: MediaQuery.of(context).size.height / 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Text('Login Form', style: GoogleFonts.abhayaLibre(
                          fontSize: deviceSize.width * 0.10,
                          color: txtcolor,
                          fontWeight: FontWeight.bold)),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      height: MediaQuery.of(context).size.height / 1.5 ,

                      width: deviceSize.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20)
                          )
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),

                          Flexible(
                            flex: deviceSize.width > 600 ? 2 : 1,
                            child: AuthCard(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
    debugPrint('Notification Scheduled for $scheduleTime');
        // NotificationService().scheduleNotifications(
        //     title: 'Scheduled Notification',
        //     body: '$scheduleTime',
        //     );
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
      //Invalid!
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
      print('hello welcome');
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
      print('hello welcome');
      _showErrorDialog(error.toString());
    } catch (error) {
      const erroreMssage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }
  bool hidePassword = true;
  bool isremmeber = false;




  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: Image(
                    image: AssetImage('assets/logoimage/logon.png'),
                  ),

                ),
                SizedBox(height: 15),
                TextFormField(


                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: HexColor('#64717d')),
                      prefixIcon: Icon(Icons.email, color: HexColor('#64717d')),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
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
                SizedBox(height: 20),
                TextFormField(
                  obscureText: hidePassword,

                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter your Password',
                      hintStyle: TextStyle(color: HexColor('#64717d')),
                      prefixIcon: Icon(Icons.vpn_key, color: HexColor('#64717d')),
                      suffixIcon: IconButton(
                        icon: hidePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  // obscureText: true,
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
                Container(
                  width: deviceSize.width*0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon( !isremmeber ? Icons.check_box_outline_blank : Icons.check_box, size: 30,),
                          onPressed: ()=> {
                            setState(() {
                              isremmeber = !isremmeber;
                              print(isremmeber);
                            })
                          },
                          ),
                          SizedBox(width: 5,),
                          Text('Remember me', style: GoogleFonts.lato(
                              color: txtcolor,
                              fontSize: deviceSize.width * 0.035,
                              fontWeight: FontWeight.bold
                          )),
                        ],
                      ),
                      TextButton(
                        child: Text('Forget Password?', style: GoogleFonts.abhayaLibre(
                            color: bggcolor,
                            fontSize: deviceSize.width * 0.035,
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: () {  },)
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
                    height: deviceSize.height * 0.06 ,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bggcolor,
                        minimumSize: Size(double.infinity, 50),
                        maximumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      ),
                      child: Text('LOGIN ', style: TextStyle(fontSize: 18),),
                      onPressed: _submit,
                    ),
                  ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('I Don\'t Have An Account?', style: GoogleFonts.abhayaLibre(
                        color: txtcolor,
                        letterSpacing: 1.2,
                        fontSize: deviceSize.width * 0.045)),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric( vertical: 10, horizontal: 6),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text("Sign Up",
                          style: GoogleFonts.abhayaLibre(color: bggcolor, fontWeight: FontWeight.bold, fontSize: deviceSize.width * 0.045)),
                      onPressed: (() async {

                        //          debugPrint('Notification Scheduled for $scheduleTime');
                        // NotificationService().scheduleNotifications(
                        //     title: 'Scheduled Notification',
                        //     body: '$scheduleTime',
                        //     );
                        Navigator.pushNamed(
                            context, ClientRegistrationScreen.routeName);
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
