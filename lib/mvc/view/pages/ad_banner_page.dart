import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import '../../controller/banner_controller.dart';
import '../../model/banner_model.dart';
import 'package:shurjopay2/utils/web_handler.dart';

class AdBannerPage extends StatefulWidget {
  const AdBannerPage({super.key});

  @override
  State<AdBannerPage> createState() => _AdBannerPageState();
}

class _AdBannerPageState extends State<AdBannerPage> {
  final BannerController _controller = BannerController();
  int _currentIndex = 0;

  late Future<List<PromotionalBanner>> _bannerFuture;

  @override
  void initState() {
    super.initState();
    _bannerFuture = _controller.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PromotionalBanner>>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const SizedBox(
            height: 180,
            child: Center(child: Text("Failed to load banners")),
          );
        }

        final banners = snapshot.data!;
        return Column(
          children: [
            FlutterCarousel(
              items: banners.map((banner) {
                return GestureDetector(
                  onTap: () {
                    if (banner.redirectUrl != null &&
                        banner.redirectUrl!.isNotEmpty) {
                      WebHandler.open(banner.redirectUrl!);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        banner.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/banner_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 180,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: banners.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(
                          _currentIndex == entry.key ? 0.9 : 0.4,
                        ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
