// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:provider/provider.dart';

class UploadRequiredDocuments extends StatelessWidget {
  final IconData icon;
  // final String text;
  final VoidCallback onClicked;
  final job.DocumentsModel documents;
  const UploadRequiredDocuments({
    Key? key,
    required this.documents,
    // required this.text,
    required this.onClicked,
    required this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
     Container(
       
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          padding: const EdgeInsets.all(15.0),
        child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            //  Color.fromRGBO(29, 194, 95, 1),
                            minimumSize: Size.fromHeight(50),
                          ),
                          child: buildContent(documents.name),
                          onPressed: onClicked,
                        )
                   
               );
  }

  Widget buildContent(String documentName) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 8),
          Text(
            documentName,
            // "imgae",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      );
}
