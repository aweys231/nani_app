// ignore_for_file: implementation_imports, avoid_unnecessary_containers, unnecessary_import, prefer_const_constructors, non_constant_identifier_names, unused_import, use_build_context_synchronously, unused_field, dead_code, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/screens/section_title.dart';
import 'package:nanirecruitment/widgets/bottom_navigation_bar.dart';
import 'package:nanirecruitment/widgets/daleel_banner.dart';
import 'package:nanirecruitment/widgets/image_slider.dart';
import 'package:nanirecruitment/widgets/jobcontainer.dart';
import 'package:provider/provider.dart';
import '../providers/jobs.dart';
import '../providers/legal_info_provider.dart';
import '../widgets/app_drawer.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

import 'ourservices.dart';

class ClientDhashboard extends StatefulWidget {
  const ClientDhashboard(this.role_id, this.candidate_id, {super.key});
  final String? role_id;
  final String? candidate_id;
  // final AnimationController? animationController;


  @override
  State<ClientDhashboard> createState() => _ClientDhashboardState();
}

class _ClientDhashboardState extends State<ClientDhashboard> {
  // final animationController = AnimatedContainer();
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
  // final animationController = AnimationController(
  // duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<HomeSlider>(context).fetchAndSetHomeSlideImage().then((_) {
        setState(() {
          Provider.of<LegalInfo>(context, listen: false)
              .findByIdLegalInfo(widget.candidate_id.toString());
          _jobsFuture = _obtainOrdersFuture(
              widget.role_id.toString(), widget.candidate_id.toString());

          _isLoading = false;
        });
      });
      Provider.of<Jobs_Section>(context, listen: false)
          .requirement_documents()
          .then((_) {});
      Provider.of<job.Jobs_Section>(context, listen: false)
          .fetchAndSetVacuncyUpcoming(widget.candidate_id.toString());
      // Provider.of<job.Jobs_Section>(context, listen: false)
      //   .fetchAndSetVacuncyCompleted(widget.candidate_id.toString()).then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  late Future _jobsFuture;
  Future _obtainOrdersFuture(String role_id, String candidate_id) {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .fetchAndSetVacuncy(role_id, candidate_id);
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: txtcolor),
            toolbarHeight: 66,
            backgroundColor: bggcolor,
            elevation: 0,
            title: Text("Nani Recruitment ", style: GoogleFonts.abhayaLibre(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold

            )),
            centerTitle: true,
          ),
          drawer: AppDrawer(),
          body: ListView(
              children: [
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                    height: MediaQuery.of(context).size.height ,
                        padding: EdgeInsets.all(5),
                        // ignore: prefer_const_literals_to_create_immutables
                        child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // DaleelBanner(),
                              ImageSlider(),
                              SizedBox(
                                height: 15,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: SectionTitle(
                                  title: "Our Services",
                                  SectionColor: txtcolor,
                                  SectionSize: MediaQuery.of(context).size.width*0.035,
                                  press: () {},
                                ),
                              ),


                              Container(
                                // margin: EdgeInsets.only(top: 6),
                                height: MediaQuery.of(context).size.height / 6,
                                child: MealsListView(
                                  // mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
                                  //     CurvedAnimation(
                                  //         parent: animationController,
                                  //         curve: Interval((1 / 2) * 3, 1.0,
                                  //             curve: Curves.fastOutSlowIn))),
                                  // mainScreenAnimationController: widget.animationController,
                                )
                              ),

                              SizedBox(height: 10,),
                              // availibe jobs
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: SectionTitle(
                                  title: "Available Jobs",
                                  SectionColor: txtcolor,
                                  SectionSize: MediaQuery.of(context).size.width*0.035,
                                  press: () {},
                                ),
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                              return Center(
                                                  child: Text('An error Accour'));
                                              print(dataSnapshot.error);                                        } else {
                                              return Consumer<job.Jobs_Section>(
                                                  builder: (ctx, jobData, child) =>
                                                      jobData.vcuncyjobs.isNotEmpty
                                                          ? Expanded(
                                                              child: Container(
                                                                //  margin: EdgeInsets.only(bottom: 100),
                                                                child: ListView.builder(
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  itemCount: jobData
                                                                      .vcuncyjobs
                                                                      .length,
                                                                  itemBuilder: (ctx,
                                                                          i) =>
                                                                      JobContainer(jobData
                                                                          .vcuncyjobs[i]),
                                                                ),
                                                              ),
                                                            )
                                                          : Center(
                                                              child: const Text(
                                                                'No results found',
                                                                style: TextStyle(
                                                                    fontSize: 24),
                                                              ),
                                                            ));
                                            }
                                          }
                                        }),
                                  ],
                                ),
                              )
                            ])),
              ],
            ),
        );

        // bottomNavigationBar: BottomNavigationBars(),


  }
}
