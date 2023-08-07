import 'package:flutter/material.dart';

class NetworkCheckPage extends StatefulWidget {
  @override
  _NetworkCheckPageState createState() => _NetworkCheckPageState();
}

class _NetworkCheckPageState extends State<NetworkCheckPage> {
  
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Network'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('You don\'t have network connection.'),
      ),
    );
  }
}




