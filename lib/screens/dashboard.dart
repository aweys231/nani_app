// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:nanirecruitment/providers/category_section.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/widgets/category_item.dart';
import 'package:nanirecruitment/widgets/items.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/enums.dart';
import 'package:nanirecruitment/screens/section_title.dart';
import 'package:nanirecruitment/size_config.dart';
import 'package:nanirecruitment/widgets/coustom_bottom_nav_bar.dart';
import 'package:nanirecruitment/widgets/daleel_banner.dart';
import 'package:nanirecruitment/widgets/image_slider.dart';
import 'package:nanirecruitment/widgets/our_services.dart';

class Dhashboard extends StatefulWidget {
   static const routeName = '/dhashboard';
  const Dhashboard({Key? key}) : super(key: key);

  @override
  State<Dhashboard> createState() => _DhashboardState();
}

class _DhashboardState extends State<Dhashboard> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //  Provider.of<Category_Section>(context).fetchAndSetAllCategory().then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
      Provider.of<HomeSlider>(context).fetchAndSetHomeSlideImage().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
     Provider.of<Candidate>(context).fetchAndSetnatinality();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xfff0f0f6),
      appBar: AppBar(
        title: Text('Nani Recruitment'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :Padding(
            padding: EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DaleelBanner(),
               ImageSlider(),

                  SizedBox(
                      height: 11,
                    ),
                     Padding(padding: EdgeInsets.symmetric(
                    horizontal: 15),child:  SectionTitle(
                  title: "Available Jobs",
                  press: () {},
                ),),
            //  CategoryItem(),
            Item()
            ])),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
