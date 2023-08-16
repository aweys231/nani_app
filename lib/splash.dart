// ignore_for_file: camel_case_types, library_private_types_in_public_api, annotate_overrides, unused_import

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/screens/auth_screen.dart';
import 'package:nanirecruitment/screens/client_dhashboard.dart';
import 'package:provider/provider.dart';

class splash extends StatefulWidget {
  static const String id = "splash.id";
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AuthScreen(),
      //     ));
    });
  }

  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: auth.isAuth
          ? ClientDhashboard(auth.role_id, auth.candidate_id)
          : Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120,
              child: Image.asset(
                'assets/logoimage/logon.png',
                height: 60,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Platform.isIOS
                ? const CupertinoActivityIndicator(
                    radius: 20,
                  )
                : const CircularProgressIndicator(
                    color: Colors.grey,
                  )
          ],
        ),
      ),
    );
  }
}



