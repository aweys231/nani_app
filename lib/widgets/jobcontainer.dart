// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/job_details.dart';
import 'package:provider/provider.dart';

class JobContainer extends StatelessWidget {
  final job.JobsModel jobs;
  const JobContainer(this.jobs);
  // const JobContainer({
  //   required this.id,
  //   required this.iconUrl,
  //   required this.title,
  //   required this.location,
  //   required this.description,
  //   required this.salary,
  //   required this.onTap,
  // });
  // final String iconUrl, title, location, description, salary;
  // final int id;
  // final Function onTap;
  @override
  Widget build(BuildContext context) {
   var candidateid=  Provider.of<Auth>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => JobDetails(id: jobs.id.toString(), candidate_id: candidateid.candidate_id!),
          )),
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 5.0,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage(
                        height: 71,
                        width: 71,
                        placeholder: AssetImage('assets/sliderimages/00.jpg'),
                        image: NetworkImage(
                          jobs.imageUrl,
                        ),
                      )),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          jobs.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          jobs.jobtitile,
                          style: Theme.of(context).textTheme.subtitle1!.apply(
                                color: Colors.grey,
                              ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text(
                jobs.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(color: Colors.grey),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 9),
              // Text(
              //   "Salary 200",
              //   style: Theme.of(context)
              //       .textTheme
              //       .subtitle1!
              //       .apply(fontWeightDelta: 2),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
