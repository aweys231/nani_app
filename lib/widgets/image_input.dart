// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, deprecated_member_use, unused_element, unused_local_variable, unused_import, use_key_in_widget_constructors, empty_constructor_bodies, prefer_const_constructors_in_immutables, sort_child_properties_last, sized_box_for_whitespace, unused_field

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageInput extends StatefulWidget {
  // const ImageInput({Key? key}) : super(key: key);
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture(ImageSource media) async {
    final picker = ImagePicker();
    // File _image;
    final imageFile = await picker.getImage(source: media, maxHeight: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    // _image = File(imageFile.path);
    final saveImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(saveImage);
    
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      _takePicture(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      _takePicture(ImageSource.camera);
                      // _takePicture();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onSurface: Colors.red,
            ),
            // textColor: Theme.of(context).primaryColor,
            onPressed: myAlert,
          ),
        ),
      ],
    );
  }
}
