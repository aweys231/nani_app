// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nanirecruitment/helpers/custom_route.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/availability_process.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/providers/great_places.dart';
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:nanirecruitment/providers/notification_service.dart';
import 'package:nanirecruitment/screens/Availabilities.dart';
import 'package:nanirecruitment/screens/add_place_screen.dart';
import 'package:nanirecruitment/screens/attandance.dart';
import 'package:nanirecruitment/screens/auth_screen.dart';
import 'package:nanirecruitment/screens/availability.dart';
import 'package:nanirecruitment/screens/canidate_legal_info.dart';
import 'package:nanirecruitment/screens/client_dhashboard.dart';
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/job_details.dart';
import 'package:nanirecruitment/screens/jobs_screen.dart';
import 'package:nanirecruitment/screens/my_shifts.dart';
import 'package:nanirecruitment/screens/scan_attandance.dart';
import 'package:nanirecruitment/screens/splashscreen.dart';
import 'package:nanirecruitment/splash.dart';
import 'package:nanirecruitment/widgets/bottom_navigation_bar.dart';
import 'package:nanirecruitment/widgets/file_upload.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/screens/dashboard.dart';
import 'package:nanirecruitment/screens/verification_number_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NotificationService notificationService;
@override
 initState()  {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
 
  NotificationService().requestIOSPermissions(); // 
  tz.initializeTimeZones();
        super.initState();
}


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
          ChangeNotifierProvider.value(
            value: Availability_Section(),
          ),
          ChangeNotifierProvider.value(
            value: GreatPlaces(),
          ),
          ChangeNotifierProvider.value(
            value: NotificationService(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'My Nani',
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                backgroundColor: Colors.purple,
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                })),
            home: auth.isAuth
                ?
                // BottomNavigationBars(auth.role_id, auth.candidate_id)
                 ClientDhashboard(auth.role_id, auth.candidate_id)
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ?
                             splash()
                            : AuthScreen(),
                  ),
            // initialRoute: splash.id,
            routes: {
              VerificationNumberScreen.routeName: (ctx) =>
                  VerificationNumberScreen(),
              JobsScreen.routeName: (ctx) => JobsScreen(),
              ClientRegistrationScreen.routeName: (ctx) =>
                  ClientRegistrationScreen(),
              Dhashboard.routeName: (ctx) => Dhashboard(),
              CanidateLegalInfor.routeName: (ctx) =>
                  CanidateLegalInfor(auth.candidate_id),
              FilePickerDemo.routeName: (ctx) => FilePickerDemo(),
              Availability.routeName: (ctx) => Availability(auth.candidate_id),
              AddPlaceScreen.routeName: (ctx) =>
                  AddPlaceScreen(auth.candidate_id),
              CanidateAttandance.routeName: (ctx) =>
                  CanidateAttandance(candidate_id: auth.candidate_id),
              ScanAttandance.routeName: (ctx) =>
                  ScanAttandance(auth.candidate_id),
                  MyShifts.routeName: (ctx) =>
                  MyShifts(auth.role_id, auth.candidate_id),
              // splash.id: (_) => splash(),
            },
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
