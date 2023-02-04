// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanirecruitment/widgets/image_input.dart';
import 'package:nanirecruitment/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../models/palce.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLcation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLcation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            // elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // color: Theme.of(context).accentColor,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
