// ignore_for_file: implementation_imports, avoid_unnecessary_containers, unnecessary_import, prefer_const_constructors, non_constant_identifier_names, unused_import, use_build_context_synchronously, unused_field, dead_code, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/screens/section_title.dart';
import 'package:nanirecruitment/widgets/daleel_banner.dart';
import 'package:nanirecruitment/widgets/image_slider.dart';
import 'package:nanirecruitment/widgets/jobcontainer.dart';
import 'package:provider/provider.dart';
import '../providers/legal_info_provider.dart';
import '../widgets/app_drawer.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

class ClientDhashboard extends StatefulWidget {
  const ClientDhashboard(this.role_id, this.candidate_id, {super.key});
  final String? role_id;
  final String? candidate_id;

  @override
  State<ClientDhashboard> createState() => _ClientDhashboardState();
}

class _ClientDhashboardState extends State<ClientDhashboard> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
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
          _jobsFuture = _obtainOrdersFuture(widget.role_id.toString(),widget.candidate_id.toString());
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  late Future _jobsFuture;
  Future _obtainOrdersFuture(String role_id,String candidate_id) {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .fetchAndSetVacuncy(role_id,candidate_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(
          title: Text('welcome'),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.all(5),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DaleelBanner(),
                          ImageSlider(),
                          SizedBox(
                            height: 11,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: SectionTitle(
                              title: "Available Jobs",
                              press: () {},
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FutureBuilder(
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
                                          print(dataSnapshot.error);
                                        } else {
                                          return Consumer<job.Jobs_Section>(
                                              builder: (ctx, jobData, child) =>
                                                  jobData.vcuncyjobs.isNotEmpty
                                                      ? Expanded(
                                                        child: ListView.builder(
                                                            // scrollDirection: Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                jobData.vcuncyjobs.length,
                                                            itemBuilder: (ctx, i) =>
                                                                JobContainer(
                                                                    jobData.vcuncyjobs[i]),
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
                              ),
                            ],
                          )
                        ]))));
  }
}
