// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, implementation_imports, unnecessary_import, unused_import, avoid_print, unused_element, non_constant_identifier_names, unused_field

import "package:flutter/src/widgets/container.dart";
import 'package:flutter/src/widgets/framework.dart';
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
  var _isLoading = false;
  
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
        .vacuncy_booking(widget.candidate_id!,widget.id.toString());
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
        .findById(widget.id.toString());
    return SafeArea(
      child: Scaffold(
        body:  _isLoading
          ? Center(child: CircularProgressIndicator())
          :
         Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                "https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg",
                fit: BoxFit.cover,
                color: Colors.black38,
                colorBlendMode: BlendMode.darken,
              ),
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
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: MediaQuery.of(context).size.height / 2,
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
                      Text(
                        "bondhere",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.apply(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "shaqadaan waa shaqo brograming ah",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.apply(color: Colors.grey),
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Photos",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 5),
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
