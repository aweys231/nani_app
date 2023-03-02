// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, implementation_imports, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/screens/attandance.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanAttandance extends StatefulWidget {
  static const routeName = '/scan-attandance';
  const ScanAttandance(this.candidate_id, {super.key});
  final String? candidate_id;

  @override
  State<ScanAttandance> createState() => _ScanAttandanceState();
}

class _ScanAttandanceState extends State<ScanAttandance> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var check_qrcode;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
              onQRViewCreated: _onQRViewCreated,
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),
          Expanded(
            child: Center(
              // alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
                  Icons.camera,
                  //  size: 72
                ),
                onPressed: () {
                  setState(() async {
                    await controller!.resumeCamera();
                    print('object');
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
  
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData;
        this.controller!.pauseCamera();
        this.controller!.resumeCamera();
        check_qrcode = await Provider.of<Jobs_Section>(context, listen: false)
            .get_check_qrcode(widget.candidate_id.toString(), result!.code.toString());
        
        // result = check_qrcode[0]['result']['qr_no'];
       
        check_qrcode['result'].isNotEmpty?
        // _showErrorDialog(check_qrcode['result'][0]['qr_no'].toString()):
        // Navigator.of(context).pushReplacementNamed(CanidateAttandance("")):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => CanidateAttandance(candidate_id:widget.candidate_id.toString(),jobvacancy_id:check_qrcode['result'][0]['jobvacancy_id'].toString())
          )):
          _showErrorDialog('you dont have premission this work');
       
      
      });
    });
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
