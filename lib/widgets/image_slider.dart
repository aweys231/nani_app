// ignore_for_file: avoid_print, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, unused_import, dead_code, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:nanirecruitment/providers/home_slider.dart';
import 'package:nanirecruitment/models/home_slider_model.dart';
import 'package:nanirecruitment/size_config.dart';

class ImageSlider extends StatefulWidget {
  
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  var _imageUrls = [];

  int activiteIndex = 0;

  @override
  Widget build(BuildContext context) {
    final imageUrls = Provider.of<HomeSlider>(context);

    _imageUrls = imageUrls.images;
    return Container(
      
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: getProportionateScreenHeight(190),
        height: MediaQuery.of(context).size.height / 4,
      
      padding: const EdgeInsets.all(0.0),
       
          child: Column(
            mainAxisSize:MainAxisSize.min,
            children: [
            Expanded(
              child:
               CarouselSlider.builder(
                itemCount: imageUrls.images.length,
                itemBuilder: (context, index, realIndex) =>
                    ChangeNotifierProvider.value(
                        value: imageUrls.images[index], child: ImageItem()),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 900),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.1,
                    initialPage: 0,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) =>
                        setState(() => activiteIndex = index)),
              ),
            ),
            // const SizedBox(height: 5),
            buildIndicator(),
          ])),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activiteIndex,
        count: _imageUrls.length,
        effect: JumpingDotEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: Colors.red,
          dotColor: Colors.blueAccent,
          // jumpScale: .7,
          // verticalOffset: 15,
        ),
      );
}

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<HomeSliderModel>(context, listen: false);
    return Container(
      width: double.infinity,
      
        child: FadeInImage(
          width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
              placeholder: AssetImage('assets/sliderimages/placeholder.png'), image: NetworkImage(
        image.imageUrl,
          )
      ),
    );
  }
}
