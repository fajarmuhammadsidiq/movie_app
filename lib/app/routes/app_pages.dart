import 'package:get/get.dart';

import '../modules/detailBannerNowPlaying/bindings/detail_banner_now_playing_binding.dart';
import '../modules/detailBannerNowPlaying/views/detail_banner_now_playing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/searchDetail/bindings/search_detail_binding.dart';
import '../modules/searchDetail/views/search_detail_view.dart';
import '../modules/searchPage/views/search_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BANNER_NOW_PLAYING,
      page: () => const DetailBannerNowPlayingView(),
      binding: DetailBannerNowPlayingBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPage(),
    ),
    GetPage(
      name: _Paths.SEARCH_DETAIL,
      page: () => const SearchDetailView(),
      binding: SearchDetailBinding(),
    ),
  ];
}
