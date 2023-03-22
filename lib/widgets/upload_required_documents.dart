// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, avoid_unnecessary_containers, deprecated_member_use, unused_field, unused_element, prefer_final_fields, avoid_web_libraries_in_flutter, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:nanirecruitment/providers/legal_info_provider.dart';
import 'package:provider/provider.dart';

import '../providers/jobs.dart';

class UploadRequiredDocuments extends StatefulWidget {
  final IconData icon;
  final Function onSelectFile;
  // final String text;
  // final VoidCallback onClicked;
  final job.DocumentsModel documents;
  const UploadRequiredDocuments({
    Key? key,
    required this.documents,
    // required this.text,
    required this.onSelectFile,
    required this.icon,
  }) : super(key: key);

  @override
  State<UploadRequiredDocuments> createState() =>
      _UploadRequiredDocumentsState();
}

class _UploadRequiredDocumentsState extends State<UploadRequiredDocuments> {
  String? _fileName;
  String? _filePath;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  List<File>? files;
  String? _directoryPath;
  String? _extension = 'pdf';
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

      print('fileName');

      widget.onSelectFile(_paths?.first.path);

      print(_paths?.first.path.toString());

      _filePath =_paths != null ?  _paths!.first.path.toString() : '...';
      Provider.of<LegalInfo>(context, listen: false)
          .removeSingleDocument(widget.documents.id.toString());
      // // this will add the model the new selection of the user
      Provider.of<LegalInfo>(context, listen: false)
          .addIDocument(widget.documents.id,_filePath!);
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _filePath = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      // padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          //  Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(40),
        ),
        child: buildContent(widget.documents.name),
        onPressed: (() {
          print('documents');
          _pickFiles();
          //_saveFile();
          print('file picked');
        }),
      ),
    );
  }

  Widget buildContent(String documentName) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 25),
          SizedBox(width: 5),
          Text(
            documentName,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      );
}
