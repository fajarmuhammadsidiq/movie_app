import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/app/data/const.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/image_const.dart';
import '../../../data/tv_model.dart';
import '../../../routes/app_pages.dart';
import '../../detailBannerNowPlaying/views/youtube_widget.dart';
import '../controllers/detail_t_v_controller.dart';
import 'button_widget.dart';

class DetailTVView extends GetView<DetailTVController> {
  const DetailTVView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Results? movie = Get.arguments;
    print(movie?.id);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: Get.width,
              child: Stack(
                children: [
                  Container(
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black]),
                    ),
                    height: 300,
                    width: Get.width,
                    child: Image.network(
                      "${Url.imageLw500}${movie?.backdropPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 20,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              "${Url.imageLw500}${movie?.posterPath}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 20,
                      bottom: 10,
                      child: Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${movie?.name}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Rating : ${movie?.voteAverage}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                  const Positioned(
                    top: 50,
                    child: BackButton(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 30,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_add_outlined,
                            color: Colors.yellow,
                            size: 35,
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 150,
                width: Get.width,
                child: FutureBuilder(
                    future: controller.trailerMovie(movie!.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.red,
                            color: Colors.white,
                          ),
                        );
                      }

                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final trailer = snapshot.data!.results[index];

                            return Stack(
                              children: [
                                ImageNetworkWidget(
                                  radius: 12,
                                  type: TypeSrcImg.external,
                                  imageSrc: YoutubePlayer.getThumbnail(
                                    videoId: trailer.key,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          6.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          YoutubePlayerWidget(
                                            youtubeKey: trailer.key,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          itemCount: snapshot.data!.results.length);
                    }),
              ),
            ),
            FutureBuilder(
              future: controller.detailTV(movie.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.red,
                      color: Colors.white,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text(
                    "NO DATA ",
                    style: TextStyle(color: Colors.white),
                  ));
                } else {
                  final genre = snapshot.data!.genres!
                      .map((e) => Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "${e.name}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList();
                  final item = snapshot.data;
                  String dateString = "${item?.seasons!.last.airDate}";
                  DateTime? date =
                      dateString != null ? DateTime.tryParse(dateString) : null;
                  String formattedDate =
                      date != null ? DateFormat.y().format(date) : 'N/A';
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: genre,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.justify,
                            "${item?.overview}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Current Season",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.WEBVIEW_T_V,
                                        arguments: item);
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.yellow,
                                    size: 35,
                                  )),
                            ],
                          ),
                          Container(
                            width: Get.width,
                            height: 200,
                            color: Colors.black,
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${Url.imageLw500}${item!.seasons!.last.posterPath}"),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.seasons!.last.name}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${formattedDate} | ${item.seasons!.last.episodeCount} Episode",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.justify,
                                            "${item.seasons!.last.overview == "" ? "No description for this season" : item.seasons!.last.overview}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<TvModels>(
              future: controller.recomTV(movie.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.yellow,
                      color: Colors.grey,
                    ),
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recommendations",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 280,
                        width: Get.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.results!.length,
                          itemBuilder: (context, index) {
                            var dataUp = snapshot.data?.results![index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${Url.imageLw500}${dataUp?.posterPath}"),
                                            fit: BoxFit.cover),
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "${dataUp?.name}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
