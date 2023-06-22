// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;
import 'package:nanirecruitment/screens/client_registration_screen.dart';
import 'package:nanirecruitment/screens/job_details.dart';
import 'package:provider/provider.dart';

class JobContainer extends StatelessWidget {
  final job.VacuncyModel jobs;
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
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Container(
                          height:  MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/sliderimages/placeholder.png'),
                              fit: BoxFit.cover,
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    jobs.name,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  SizedBox(height: 8,),
                                  Text(
                                    jobs.jobtitile.toUpperCase(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.black87
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                     overflow: TextOverflow.ellipsis,
                                      maxLines: 3,

                                    jobs.description,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      color: HexColor('#0C2857')
                                    ),),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 5)
                      ,child: Icon(Icons.arrow_forward_ios, color: HexColor('#1e4a68'), size: 28,))
                ],
              ),
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
