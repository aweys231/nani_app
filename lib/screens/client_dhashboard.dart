// ignore_for_file: implementation_imports, avoid_unnecessary_containers, unnecessary_import, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClientDhashboard extends StatefulWidget {
  const ClientDhashboard(this.role_id, {super.key});
  final String? role_id;

  @override
  State<ClientDhashboard> createState() => _ClientDhashboardState();
}

class _ClientDhashboardState extends State<ClientDhashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(
          title: Text('welcome'),
        ),
        body: Container(
          child: Text(widget.role_id.toString()),
        ));
  }
}
