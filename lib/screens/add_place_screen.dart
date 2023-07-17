// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, depend_on_referenced_packages, library_private_types_in_public_api, unused_import, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:nanirecruitment/widgets/image_input.dart';
import 'package:nanirecruitment/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../models/palce.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen(this.candidate_id, {super.key});
  final String? candidate_id;

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // final _titleController = TextEditingController();
  // File? _pickedImage;
  PlaceLcation? _pickedLocation;

  // void _selectImage(File pickedImage) {
  //   _pickedImage = pickedImage;
  // }

  void _selectPlace(double lat, double lng, String? addres) {
    _pickedLocation =
        PlaceLcation(latitude: lat, longitude: lng, address: addres);
  }

  void _savePlace() {
    if (_pickedLocation == null) {
      print('data maleh');
      return;
    }
     print('data maleh');
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_pickedLocation!, widget.candidate_id!);
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bggcolor,
        centerTitle: true,
        title: Text('Add a New Place'),
      ),
       drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    // TextField(
                    //   decoration: InputDecoration(labelText: 'Title'),
                    //   controller: _titleController,
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ImageInput(_selectImage),
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
            label: Text('Add Location'),
            onPressed: _savePlace,
            // elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // color: Theme.of(context).accentColor,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: bggcolor),
          ),
        ],
      ),
    );
  }
}
