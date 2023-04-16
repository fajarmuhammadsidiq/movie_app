import 'package:get/get.dart';

import '../modules/detailBannerNowPlaying/bindings/detail_banner_now_playing_binding.dart';
import '../modules/detailBannerNowPlaying/views/detail_banner_now_playing_view.dart';
import '../modules/detailNowPlayingPagination/bindings/detail_now_playing_pagination_binding.dart';
import '../modules/detailNowPlayingPagination/views/detail_now_playing_pagination_view.dart';
import '../modules/detailTV/bindings/detail_t_v_binding.dart';
import '../modules/detailTV/views/detail_t_v_view.dart';
import '../modules/explorePage/bindings/explore_page_binding.dart';
import '../modules/explorePage/views/explore_page_view.dart';
import '../modules/favoritesPage/bindings/favorites_page_binding.dart';
import '../modules/favoritesPage/views/favorites_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/personPage/bindings/person_page_binding.dart';
import '../modules/personPage/views/person_page_view.dart';
import '../modules/searchDetail/bindings/search_detail_binding.dart';
import '../modules/searchDetail/views/search_detail_view.dart';
import '../modules/searchPage/views/search_page_view.dart';
import '../modules/seeAllNowPlaying/bindings/see_all_now_playing_binding.dart';
import '../modules/seeAllNowPlaying/views/see_all_now_playing_view.dart';
import '../modules/settingPage/bindings/setting_page_binding.dart';
import '../modules/settingPage/views/setting_page_view.dart';
import '../modules/tvPage/bindings/tv_page_binding.dart';
import '../modules/tvPage/views/tv_page_view.dart';
import '../modules/webviewTV/bindings/webview_t_v_binding.dart';
import '../modules/webviewTV/views/webview_t_v_view.dart';

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
    GetPage(
      name: _Paths.SEE_ALL_NOW_PLAYING,
      page: () => const SeeAllNowPlayingView(),
      binding: SeeAllNowPlayingBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_NOW_PLAYING_PAGINATION,
      page: () => const DetailNowPlayingPaginationView(),
      binding: DetailNowPlayingPaginationBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE_PAGE,
      page: () => const ExplorePageView(),
      binding: ExplorePageBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES_PAGE,
      page: () => const FavoritesPageView(),
      binding: FavoritesPageBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_PAGE,
      page: () => const SettingPageView(),
      binding: SettingPageBinding(),
    ),
    GetPage(
      name: _Paths.PERSON_PAGE,
      page: () => const PersonPageView(),
      binding: PersonPageBinding(),
    ),
    GetPage(
      name: _Paths.TV_PAGE,
      page: () => const TvPageView(),
      binding: TvPageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_T_V,
      page: () => const DetailTVView(),
      binding: DetailTVBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW_T_V,
      page: () => const WebviewTVView(),
      binding: WebviewTVBinding(),
    ),
  ];
}
