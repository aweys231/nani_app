// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, implementation_imports, unnecessary_import, unused_import, avoid_print, unused_element, non_constant_identifier_names, unused_field, prefer_const_literals_to_create_immutables, unnecessary_new



import "package:flutter/src/widgets/container.dart";
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jobs.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key, this.id, this.candidate_id});
  final String? id;
  final String? candidate_id;
  static const routeName = '/job-details';
  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
   LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }
  var _isLoading = false;
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  double? fieldLatitude;
  double? fieldLogitude;
  var _isInit = true;
  var _isLoadingm = false;
  @override
  void initState() {
    
      if (_isInit) {
      setState(() {
        _isLoadingm = true;
      });
     
      getfieldlocation().then((_){
        setState(() {
          _isLoadingm = false;
        });
      });
     
    }
    _isInit = false;
    super.initState();
  }
   @override
  void didChangeDependencies() {
  
    super.didChangeDependencies();
  }
   Future<void> getfieldlocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      fieldLatitude = _locationData?.latitude;
      fieldLogitude = _locationData?.longitude;
      
      print(fieldLatitude);
      print(fieldLogitude);
    });
  }
  Future<void> _savePlace() async {
    if (widget.candidate_id == '' || widget.id == '') {
      print('data maleh');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Jobs_Section>(context, listen: false)
          .vacuncy_booking(widget.candidate_id!, widget.id.toString());
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error accurred!'),
                content: Text(error.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okey'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      print(widget.candidate_id);
                    },
                  )
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('success'),
              content: Text('successfully Booking Submited'),
              actions: <Widget>[
                TextButton(
                  child: Text('Okey'),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.of(context).pushNamed('/');
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<Jobs_Section>(context, listen: false)
        .findVacuncyById(widget.id.toString());
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child:

                    _isLoadingm
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :
        GoogleMap(
        initialCameraPosition: 
                   CameraPosition(
          target: LatLng(jobList.
            fieldLatitude!,jobList.fieldLogitude!
          ),
          zoom: 16,
        ),
        // onTap: widget.isSelecting ? _selectLocation : null,
        markers:
             {
                Marker(
                  markerId: MarkerId('m1'),
                  position: LatLng(jobList.
            fieldLatitude!,jobList.fieldLogitude!),
            infoWindow: InfoWindow( //popup info 
          title: jobList.company_name,
          snippet: jobList.jv_address,
        ),
                ),
              },
      ),
                    //  Image.network(
                    //   jobList.imageUrl,
                    //   // "https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg",
                    //   fit: BoxFit.cover,
                    //   color: Colors.black38,
                    //   colorBlendMode: BlendMode.darken,
                    // ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Spacer(),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.favorite,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.file_upload,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${jobList.jobtitile}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                    visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.location_on,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${jobList.jv_address}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      // textScaleFactor: 2.5,
                                      textAlign: TextAlign.start,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                     visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.calendar_view_day_outlined,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${jobList.shift_type}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      // textScaleFactor: 2.5,
                                      textAlign: TextAlign.start,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                     visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.directions_walk,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${jobList.km}km",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      // textScaleFactor: 2.5,
                                      textAlign: TextAlign.start,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                     visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.bus_alert_rounded,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${jobList.minut} minutes",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      // textScaleFactor: 2.5,
                                      textAlign: TextAlign.start,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                     visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.date_range_outlined,
                                      size: 30,
                                    ),
                                    title: Text(
                                      " star date ${jobList.start_date}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      // textScaleFactor: 2.5,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),
 Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset.infinite,
                                        color: Colors.white10,
                                      ),
                                    ],
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    dense:true, 
                                     visualDensity: VisualDensity(vertical: -3),
                                    leading: Icon(
                                      Icons.date_range_outlined,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "End date ${jobList.end_date}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      // textScaleFactor: 2.5,
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                    iconColor: Colors.blue,
                                    textColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            //     SizedBox(
                            //       height: 5,
                            //     ),
                            //     ListTile(
                            //   leading: Icon(Icons.share_arrival_time_outlined, size: 15,),
                            //   title: Text("${jobList.minut} minutes",
                            //   style: TextStyle(fontSize: 15,
                            //   fontWeight: FontWeight.bold,
                            //   ),
                            //   textAlign:TextAlign.start,
                            //   ),
                            // ),

                            //   SizedBox(
                            //       height: 5,
                            //     ),
                            //     ListTile(
                            //   leading: Icon(Icons.bus_alert_outlined, size: 15,),
                            //   title: Text("${jobList.minut} minutes",
                            //   style: TextStyle(fontSize: 15,
                            //   fontWeight: FontWeight.bold,
                            //   ),
                            //   textAlign:TextAlign.start,
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Overview",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${jobList.description}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.apply(color: Colors.grey),
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            // Text(
                            //   "Photos",
                            //   style: Theme.of(context).textTheme.subtitle1,
                            // ),
                            // SizedBox(height: 5),
                            // Container(
                            //   height: 80,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: jobList[id].photos.length,
                            //     itemBuilder: (ctx, i) {
                            //       return Padding(
                            //         padding:
                            //             const EdgeInsets.symmetric(horizontal: 9.0),
                            //         child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(15.0),
                            //           child:
                            //               Image.network("${jobList[id].photos[i]}"),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * .7,
                              height: 45,
                              child: ElevatedButton(
                                // ignore: sort_child_properties_last
                                child: Text(
                                  "Booking Inquiry",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .apply(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  _savePlace();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
