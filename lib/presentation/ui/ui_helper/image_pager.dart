import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum PagerType { Assets,Online }
class ImagePager extends StatelessWidget {
  List<String> pages;
  PagerType pagerType = PagerType.Assets;

  ImagePager({Key? key,required this.pages,this.pagerType = PagerType.Assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.90);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children: [...pages.map((e) => SizedBox())],
            ),
            CarouselSlider(

              items: [
                ...pages.map(
                      (e) => Container(
                        width: double.infinity,
                      margin: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15)),
                        child: pagerType == PagerType.Assets ? Image(image: AssetImage(e),fit: BoxFit.cover,) : CachedNetworkImage(imageUrl: e,fit: BoxFit.cover,),
                      )),
                )
              ], options: CarouselOptions(
              height: 300,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index,carousel){
                pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              scrollDirection: Axis.horizontal,
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(

                  controller: pageController,
                  count: pages.length,
                  effect: CustomizableEffect(

                      spacing: 6,
                      activeDotDecoration: DotDecoration(

                        width: 10,
                        height: 10,
                        color: Colors.indigo,
                        rotationAngle: 240,
                        dotBorder: const DotBorder(
                          padding: 2,
                          width: 2,
                          color: Colors.indigo,
                        ),
                        borderRadius: BorderRadius.circular(2),
                        verticalOffset: -5,
                      ),
                      dotDecoration: DotDecoration(
                        width: 10,
                        height: 10,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                        verticalOffset: 0,
                      )),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
