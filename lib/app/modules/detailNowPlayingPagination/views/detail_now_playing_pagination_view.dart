import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/detail_model.dart';
import '../../../data/image_const.dart';
import '../../../data/movie.dart';
import '../../detailBannerNowPlaying/views/youtube_widget.dart';
import '../controllers/detail_now_playing_pagination_controller.dart';

class DetailNowPlayingPaginationView
    extends GetView<DetailNowPlayingPaginationController> {
  const DetailNowPlayingPaginationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Movie data = Get.arguments;
    final currencyFormatter = NumberFormat.currency(locale: 'en_US');

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
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
                        "https://image.tmdb.org/t/p/w92${data.backdropPath}",
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
                                "https://image.tmdb.org/t/p/w92${data.posterPath}",
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
                                "${data.title}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Rating : ${data.voteAverage}",
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
                        ))
                  ],
                ),
              ),
              Container(
                height: 180,
                width: Get.width,
                child: FutureBuilder(
                    future: controller.trailerMovie(data.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
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
                            return const SizedBox(width: 5);
                          },
                          itemCount: snapshot.data!.results.length);
                    }),
              ),
              FutureBuilder<DetailMovie>(
                  future: controller.detailMovie(data.id),
                  builder: (context, snapshotCast) {
                    if (snapshotCast.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshotCast.hasData) {
                      return const Text(
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
                                  color: const Color.fromARGB(255, 216, 20, 6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "${e.name}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList();
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: Get.width,
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("RELEASE DATE:",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: Colors.white),
                                const SizedBox(width: 20),
                                Text(
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    "${snapshotCast.data!.releaseDate}"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text("GENRES",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: genre,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "OVERVIEWS",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                                "${snapshotCast.data!.overview}"),
                            const SizedBox(height: 10),
                            Text(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                                "${snapshotCast.data!.overview}"),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: Get.width,
                                height: 150,
                                color: Colors.green,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: Get.width,
                                        height: Get.height,
                                        color: Colors.black,
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.slideshow_outlined,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: Get.width,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  color: Colors.grey,
                                                  child: const Text(
                                                      "Budget Production",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  width: Get.width,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  color: Colors.grey,
                                                  child: Text(
                                                      currencyFormatter.format(
                                                          snapshotCast
                                                              .data!.budget),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: Get.width,
                                        height: Get.height,
                                        color: Colors.black,
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.monetization_on,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: Get.width,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  color: Colors.grey,
                                                  child: const Text("Revenue",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  width: Get.width,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  color: const Color.fromARGB(
                                                      255, 71, 70, 70),
                                                  child: Text(
                                                      currencyFormatter.format(
                                                          snapshotCast
                                                              .data!.revenue),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                      )),
                                                ),
                                              ],
                                            ),
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
                            backgroundColor:
                                const Color.fromARGB(255, 216, 20, 6)),
                        onPressed: () {},
                        icon: const Icon(Icons.book),
                        label: const Text("Favorites"))),
              )
            ]),
          ),
        ));
  }
}
