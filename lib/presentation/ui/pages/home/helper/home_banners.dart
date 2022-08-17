import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_app/data/models/banner_model.dart';
import 'package:crypto_app/logic/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/data_source/base_model.dart';
import '../../../ui_helper/image_pager.dart';

class HomeBanners extends StatefulWidget {
  const HomeBanners({Key? key}) : super(key: key);

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetBannersEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
      buildWhen: (preState,newState){
        return preState.bannerData != newState.bannerData;
      },
      builder: (context,state){
        BaseModel<BannerModel> bannerData = state.bannerData;
        switch (bannerData.status) {
          case ResponseStatus.Loading:
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 150,
                child: Shimmer.fromColors(
                  child: CarouselSlider(
                    items: List.generate(3, (index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: const Duration(seconds: 5),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.white,
                ),
              ),
            );
          case ResponseStatus.Success:
            return ImagePager(
              pages:
              bannerData.data.data.map((e) => e.imgSrc).toList(),
              pagerType: PagerType.Online,
            );
          case ResponseStatus.Failed:
            return const Text("Failed...");
          default: return Container();
        }
      },
    );
  }
}
