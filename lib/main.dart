// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import, depend_on_referenced_packages

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:fl/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as nt;
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nanirecruitment/NetworkCheck.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/helpers/custom_route.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/availability_process.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/providers/great_places.dart';
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:nanirecruitment/providers/notification_service.dart';
import 'package:nanirecruitment/screens/Availabilities.dart';
import 'package:nanirecruitment/screens/Candidate_profile_screen.dart';
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
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/screens/dashboard.dart';
import 'package:nanirecruitment/screens/verification_number_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' ;
import 'package:timezone/data/latest.dart' as tz;

import 'Notification.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool hasNetwork = await checkNetworkStatus();
  runApp(MyApp(hasNetwork: hasNetwork));
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.initialize();


  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();

  print(firebaseMessagingService.initialize().toString());

  // nt.FirebaseMessaging.onMessage.listen((nt.RemoteMessage message) {
  //   // Handle the push notification.
  //   print('this is mnessage'+ message.data.toString());
  // });
  //
  final token = await nt.FirebaseMessaging.instance.getToken();
  print('this is token $token');



//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//
//   OneSignal.shared.setAppId("5347870d-798f-48fa-9e1a-db37fe097793");
//
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     print("Accepted permission: $accepted");
//   });

}


class MyApp extends StatefulWidget {

  final bool hasNetwork;

  MyApp({required this.hasNetwork});



  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> checkNetworkStatus() async {
  print('connection works fine ');
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
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
    // Handle incoming messages when the app is in the background or terminated
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: Text('New Message'),
    //       content: Text(message.notification?.body ?? ''),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // });


  }

  // Handle incoming messages when the app is in the background or terminated
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  // showDialog(
  // context: context,
  // builder: (BuildContext context) => AlertDialog(
  // title: Text('New Message'),
  // content: Text(message.notification?.body ?? ''),
  // actions: [
  // TextButton(
  // onPressed: () => Navigator.of(context).pop(),
  // child: Text('OK'),
  // ),
  // ],
  // ),
  // );
  // });


  @override
  Widget build(BuildContext context) {
    // String? token =  FirebaseMessaging.instance.getToken() as String?;
    // print(token);
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
                primarySwatch: buildMaterialColor(Color(0xFFB04C68)),
                hintColor: Colors.deepOrange,
                fontFamily: 'Lato',
                backgroundColor: bggcolor,
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                })),
            home:
            widget.hasNetwork ? auth.isAuth
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
            )
                : NetworkCheckPage() ,
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
              CandidateProfileScreen.routeName: (ctx) =>
                  CandidateProfileScreen( auth.candidate_id),
              // splash.id: (_) => splash(),
            },
            // builder: (context, child) => MediaQuery(
            //   child: child!,
            //   data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            // ),
            // },
          ),
        )

    );
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