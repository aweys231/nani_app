import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/screens/auth_screen.dart';
import 'package:nanirecruitment/screens/client_dhashboard.dart';
import 'package:nanirecruitment/splash.dart';
import 'package:provider/provider.dart';

class checkseasion extends StatelessWidget {
  const checkseasion({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      body:  FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: (ctx, authResultSnapshot) {
          if (authResultSnapshot.connectionState == ConnectionState.waiting) {
            return AuthScreen();
          } else {
            return ClientDhashboard(auth.role_id, auth.candidate_id);
          }
        },
      ),
    );
  }
}
