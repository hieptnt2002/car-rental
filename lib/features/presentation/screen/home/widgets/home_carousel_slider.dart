import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatefulWidget {
  final List<CarouselImage> carouselImages;

  const HomeCarouselSlider({super.key, required this.carouselImages});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  var _activeIndex = 0;
  final _carouselController = CarouselController();

  void jumpToNextSlide() => _carouselController.nextPage();
  void jumpToPreviousSlide() => _carouselController.previousPage();
  void jumpToSlide(int index) => _carouselController.jumpToPage(index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _activeIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return _buildImage(widget.carouselImages[index].image);
                },
                itemCount: widget.carouselImages.length,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: jumpToPreviousSlide,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black38,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: jumpToNextSlide,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black38,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildIndicator(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _activeIndex,
      count: widget.carouselImages.length,
      effect: const JumpingDotEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: AppColors.white,
        dotColor: AppColors.gray500,
      ),
      onDotClicked: (index) {
        jumpToSlide(index);
      },
    );
  }
}
