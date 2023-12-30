import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/screens/my_shifts.dart';
import 'package:nanirecruitment/services/api_urls.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

class BottomPopupModal extends StatefulWidget {
  final String? availabilityid;
  // final TextEditingController? reason;
  final String? cand_id;

  const BottomPopupModal(
     this.availabilityid,
     // this.reason,
     this.cand_id,
  );

  @override
  State<BottomPopupModal> createState() => _BottomPopupModalState();
}

class _BottomPopupModalState extends State<BottomPopupModal> {
  late final TextEditingController? reason;
   String reasons = '';
  // void CancelSift(){
  @override
  Widget build(BuildContext context) {


    final job = Provider.of<Jobs_Section>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'why are you canceling thhis shift!!',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextField(
            onChanged:  (value) {
              setState(() {
                reasons = value;
              });
            },
            keyboardType: TextInputType.multiline,
            // controller: reason,
            decoration: InputDecoration(
              labelText: 'Reason',
            ),
          ),
          SizedBox(height: 10.0),
          // Text(
          //   'Client_Id $cid',
          //   style: TextStyle(fontSize: 16.0),
          // ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            color: bggcolor,
            child: ElevatedButton(
              child: Text('Cancel'),
              onPressed: () async {
                var message = await Provider.of<Jobs_Section>(
                    context,
                    listen: false)
                    .shift_cancelation(widget.availabilityid!,reasons ,widget.cand_id! );
                print(message.toString());

                await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('success'),
                  content: Text(message.toString()),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Okey'),
                      onPressed: () {
                        // Navigator.of(ctx).pop();
                        Navigator.of(context).pushReplacementNamed(MyShifts.routeName);
                      },
                    )
                  ],
                ));            // Send the JSON data to the server.
              },
            ),
          ),
        ],
      ),
    );
  }
}