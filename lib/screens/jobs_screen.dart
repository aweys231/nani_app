// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, implementation_imports, unused_import, unused_field, prefer_final_fields, unused_local_variable, unused_element, prefer_const_constructors, avoid_print, dead_code, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:nanirecruitment/screens/verification_number_screen.dart';
import 'package:nanirecruitment/widgets/jobcontainer.dart';
import 'package:provider/provider.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});
  static const routeName = '/jobs-screen';

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String job_id() {
    final jobId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    return jobId;
  }

  late Future _jobsFuture;
  Future _obtainOrdersFuture(String id) {
    return Provider.of<job.Jobs_Section>(context, listen: false).fetchAndSetAllJobs(job_id());
  }

  // late final job.Jobs_Section jobs;
  List<Map<String, dynamic>> _alljobs = [];
  void getdata(BuildContext ctx) {
    final alljobs = Provider.of<job.Jobs_Section>(context);
    _alljobs = alljobs.jobs.cast<Map<String, dynamic>>();
  }

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundJob = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _jobsFuture = _obtainOrdersFuture('');
      SchedulerBinding.instance.addPostFrameCallback((_) {
  // Call your function
   getdata(context);
      _foundJob = _alljobs;
       
});  
    });

    super.didChangeDependencies();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _alljobs;
    } else {
      results = _alljobs
          .where((user) => user["jobrole"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundJob = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final loadedJobs = Provider.of<job.Jobs_Section>(
    //   context,
    //   listen: false,
    // ).fetchAndSetAllJobs(jobId);
print(_alljobs);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            // TextField(
            //   onChanged: (value) => _runFilter(value),
            //   decoration: const InputDecoration(
            //       labelText: 'Search', suffixIcon: Icon(Icons.search)),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Expanded(
                child:
                    // _foundJob.isNotEmpty
                    //     ?
                    FutureBuilder(
                        future: _jobsFuture,
                        builder: (ctx, dataSnapshot) {
                          if (dataSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (dataSnapshot.error != null) {
                              return Center(child: Text('An error Accour'));
                              print(dataSnapshot.error);
                            } else {
                              return Consumer<job.Jobs_Section>(
                                  builder: (ctx, jobData, child) => Expanded(
                                        child: jobData.jobs.isNotEmpty ? ListView.builder(                                          
                                          // scrollDirection: Axis.horizontal,
                                          itemCount: jobData.jobs.length,
                                          itemBuilder: (ctx, i) =>
                                              JobContainer(jobData.jobs[i]),
                                        )
                                        : Center(
                                          child: const Text(
                                             'No results found',
                                             style: TextStyle(fontSize: 24),
                                             ),
                                        ),
                                        // GridView.count(
                                        //         primary: true,
                                        //         crossAxisCount: 2,
                                        //         childAspectRatio: 0.80,
                                        //         children: List.generate(orderData.categories.length, (i) => CategoryCard(orderData.categories[i])),
                                        // ),
                                      ));
                            }
                          }
                        })
                ),
          ],
        ),
      ),
    );
  }
}
