// ignore_for_file: implementation_imports, sort_child_properties_last, deprecated_member_use, deprecated_member_use, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, unused_field, prefer_final_fields, duplicate_ignore, unnecessary_import, must_be_immutable, unused_element, use_key_in_widget_constructors, avoid_web_libraries_in_flutter

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class UploadDocument extends StatefulWidget {
  final Function onSelectFile;

  const UploadDocument(this.onSelectFile);

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  List<File>? files;
  String? _directoryPath;
  String? _extension ='pdf';
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

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
      ))?.files;
          print('fileName');
         
          widget.onSelectFile(_paths?.first.path);
          
          print(_paths?.first.path.toString());
      
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

  Future<void> _saveFile() async {
    _resetState();
    try {
      File? fileName = (await FilePicker.platform.saveFile(
        allowedExtensions: ['pdf', 'doc'],
        type: FileType.custom,
      )) as File?;
      print(fileName);
      print('fileName');
      setState(() {
        _saveAsFileName = fileName.toString();
        widget.onSelectFile(fileName);
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Builder(
            builder: (BuildContext context) => _isLoading
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: const CircularProgressIndicator(),
                  )
                : _userAborted
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const Text(
                          'User has aborted the dialog',
                        ),
                      )
                    : _directoryPath != null
                        ? ListTile(
                            title: const Text('Directory path'),
                            subtitle: Text(_directoryPath!),
                          )
                        : _paths != null
                            ? Container(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Scrollbar(
                                    child: ListView.separated(
                                  itemCount:
                                      _paths != null && _paths!.isNotEmpty
                                          ? _paths!.length
                                          : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final bool isMultiPath =
                                        _paths != null && _paths!.isNotEmpty;
                                    final String name = 'File $index: ' +
                                        (isMultiPath
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...');
                                    final path = kIsWeb
                                        ? null
                                        : _paths!
                                            .map((e) => e.path)
                                            .toList()[index]
                                            .toString();

                                    return ListTile(
                                      title: Text(
                                        name,
                                      ),
                                      subtitle: Text(path ?? ''),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                )),
                              )
                            : _saveAsFileName != null
                                ? ListTile(
                                    title: const Text('Save file'),
                                    subtitle: Text(_saveAsFileName!),
                                  )
                                : const SizedBox(),
          ),
          // _storedImage != null
          //     ? Image.file(
          //         _storedImage!,
          //         fit: BoxFit.cover,
          //         width: double.infinity,
          //       )
          //     // ignore: prefer_const_constructors
          //     : Text(
          //         'No File Taken',
          //         textAlign: TextAlign.center,
          //       ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              icon: Icon(Icons.upload_file_outlined),
              label: Text('UPLOAD DOCUMENT'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onSurface: Colors.red,
              ),
              // textColor: Theme.of(context).primaryColor,
              onPressed: (() {
                _pickFiles();
                // _saveFile();
              })),
        ),
      ],
    );
  }
}
