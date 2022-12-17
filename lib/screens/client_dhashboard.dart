// ignore_for_file: implementation_imports, avoid_unnecessary_containers, unnecessary_import, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../providers/legal_info_provider.dart';
import '../widgets/app_drawer.dart';

class ClientDhashboard extends StatefulWidget {
  const ClientDhashboard(this.role_id,  this.candidate_id, {super.key});
  final String? role_id;
  final String? candidate_id;

  @override
  State<ClientDhashboard> createState() => _ClientDhashboardState();
}

class _ClientDhashboardState extends State<ClientDhashboard> {
  @override
  void initState() {
    Provider.of<LegalInfo>(context, listen: false).findByIdLegalInfo(widget.candidate_id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(
          title: Text('welcome'),
        ),
        drawer: AppDrawer(),
        body: Container(
          child: Text(widget.role_id.toString()),
        ));
  }
}
