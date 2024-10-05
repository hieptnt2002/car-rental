import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCarouselSliderShimmer extends StatelessWidget {
  final bool enable;
  const HomeCarouselSliderShimmer({super.key, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enable,
      child: SizedBox(
        height: 200,
        child: CarouselSlider.builder(
          itemCount: 1,
          itemBuilder: (context, index, realIndex) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Bone(width: double.maxFinite, height: 200),
            );
          },
          options: CarouselOptions(
            height: 200,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
