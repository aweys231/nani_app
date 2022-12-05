// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/jobs_screen.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/screens/dashboard.dart';
import 'package:nanirecruitment/screens/verification_number_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeSlider(),
        ),
         ChangeNotifierProvider.value(
          value: Category_Section(),
        ),
          ChangeNotifierProvider.value(
          value: Jobs_Section(),
        ),
      ],
      child: MaterialApp(
        title: 'My Wallet',
        theme: ThemeData(
        primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                backgroundColor: Colors.purple,
          
        ),
        home: Dhashboard(),
        routes: {
          VerificationNumberScreen.routeName: (ctx) =>
              VerificationNumberScreen(),
              JobsScreen.routeName: (ctx) =>
              JobsScreen(),
              ClientRegistrationScreen.routeName: (ctx) =>
              ClientRegistrationScreen(),
        },
      ),
    );
  }
}
