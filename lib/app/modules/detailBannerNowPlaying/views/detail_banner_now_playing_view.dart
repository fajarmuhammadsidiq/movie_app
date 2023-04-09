import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/data/const.dart';
import 'package:movie_app/app/modules/detailBannerNowPlaying/views/youtube_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/discover_model.dart';
import '../../../data/image_const.dart';
import '../controllers/detail_banner_now_playing_controller.dart';

class DetailBannerNowPlayingView
    extends GetView<DetailBannerNowPlayingController> {
  const DetailBannerNowPlayingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Result? movie = Get.arguments;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black,
          child: Column(children: [
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black]),
                      ),
                      height: Get.height,
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
                                "${movie?.title}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Rating : ${movie?.voteAverage}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 50,
                        child: BackButton(
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              height: 150,
              width: Get.width,
              child: FutureBuilder(
                  future: controller.trailerMovie(movie!.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final trailer = snapshot.data!.results;
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
                          return SizedBox(width: 5);
                        },
                        itemCount: snapshot.data!.results.length);
                  }),
            ),
            Expanded(
                child: Container(
              color: Colors.black,
            ))
          ]),
        ));
  }
}
