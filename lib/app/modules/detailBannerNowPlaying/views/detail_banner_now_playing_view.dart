import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/const.dart';
import 'package:movie_app/app/data/detail_model.dart';
import 'package:movie_app/app/modules/detailBannerNowPlaying/views/youtube_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/cast_model.dart';
import '../../../data/discover_model.dart';
import '../../../data/image_const.dart';
import '../controllers/detail_banner_now_playing_controller.dart';

class DetailBannerNowPlayingView
    extends GetView<DetailBannerNowPlayingController> {
  const DetailBannerNowPlayingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Result? movie = Get.arguments;
    final currencyFormatter = NumberFormat.currency(locale: 'en_US');
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [
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
            Container(
              height: 180,
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
            FutureBuilder<DetailMovie>(
                future: controller.detailMovie(movie.id),
                builder: (context, snapshotCast) {
                  if (snapshotCast.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshotCast.hasData) {
                    return Text(
                      "Tidak ada data",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  final genre = snapshotCast.data!.genres!
                      .map((e) => Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 216, 20, 6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "${e.name}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 400,
                      width: Get.width,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("RELEASE DATE:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_month, color: Colors.white),
                              SizedBox(width: 20),
                              Text(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  "${snapshotCast.data!.releaseDate}"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text("GENRES",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: genre,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "OVERVIEWS",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 10),
                          Text(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                              "${snapshotCast.data!.overview}"),
                          SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              width: Get.width,
                              height: 70,
                              color: Colors.green,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Get.width,
                                      height: Get.height,
                                      color: Colors.yellow,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Budget Production",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                          SizedBox(height: 5),
                                          Text(
                                              "${currencyFormatter.format(snapshotCast.data!.budget)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Get.width,
                                      height: Get.height,
                                      color: Colors.green,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Revenue",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                          SizedBox(height: 5),
                                          Text(
                                              "${currencyFormatter.format(snapshotCast.data!.revenue)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                        ],
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
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                  height: 50,
                  width: Get.width,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Color.fromARGB(255, 216, 20, 6)),
                      onPressed: () {},
                      icon: Icon(Icons.book),
                      label: Text("Favorites"))),
            )
          ]),
        ));
  }
}
