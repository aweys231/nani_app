// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, use_key_in_widget_constructors, unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/job_details.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/category_section.dart';

class JobContainer extends StatefulWidget {
  final job.VacuncyModel jobs;
  JobContainer(this.jobs);

  @override
  State<JobContainer> createState() => _JobContainerState();
}

class _JobContainerState extends State<JobContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
  super.initState();
  _animationController = AnimationController(
  vsync: this,
  duration: Duration(milliseconds: 500),
  );
  _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
  CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );
  }

  @override
  void dispose() {
  _animationController.dispose();
  super.dispose();
  }


  // const JobContainer({
  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    var candidateid=  Provider.of<Auth>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => JobDetails(id: widget.jobs.id.toString(), candidate_id: candidateid.candidate_id!),
          )),
      child: AnimatedContainer(
        duration: Duration(seconds: 500),
        curve: Curves.easeInOut,
        child: Container(
          padding: EdgeInsets.all(2.0),
          margin: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              FadeTransition(
                opacity: _animation,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.width*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/sliderimages/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        widget.jobs.name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.030,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        widget.jobs.jobtitile,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.033,),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        widget.jobs.description,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025,),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
