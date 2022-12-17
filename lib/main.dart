// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:nanirecruitment/screens/auth_screen.dart';
import 'package:nanirecruitment/screens/canidate_legal_info.dart';
import 'package:nanirecruitment/screens/client_dhashboard.dart';
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/jobs_screen.dart';
import 'package:nanirecruitment/screens/splashscreen.dart';
import 'package:nanirecruitment/widgets/file_upload.dart';
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
         ChangeNotifierProvider.value(
          value: Candidate(),
        ),
         ChangeNotifierProvider.value(
          value: Auth(),
        ),
         ChangeNotifierProvider.value(
          value: LegalInfo(),
        ),
      ],
      child:Consumer<Auth>(
        builder: (ctx, auth, _) =>
       MaterialApp(
        title: 'My Wallet',
        theme: ThemeData(
        primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                backgroundColor: Colors.purple,
          
        ),
        // home: Dhashboard(),
        home:  auth.isAuth
                ? ClientDhashboard(auth.role_id,auth.candidate_id)
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
        routes: {
          VerificationNumberScreen.routeName: (ctx) =>
              VerificationNumberScreen(),
              JobsScreen.routeName: (ctx) =>
              JobsScreen(),
              ClientRegistrationScreen.routeName: (ctx) =>
              ClientRegistrationScreen(),
              Dhashboard.routeName: (ctx) => Dhashboard(),
              CanidateLegalInfor.routeName: (ctx) => CanidateLegalInfor(auth.candidate_id),
               FilePickerDemo.routeName: (ctx) => FilePickerDemo(),
        },
      ),
      )
    );
  }
}
