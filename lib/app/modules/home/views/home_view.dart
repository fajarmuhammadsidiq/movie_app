import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/data/const.dart';

import 'package:movie_app/app/routes/app_pages.dart';

import '../../../data/noplaying_model.dart';

import '../../../data/popularMovie.dart';
import '../../../data/upComing_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(Routes.SEARCH_PAGE),
                icon: const Icon(
                  Icons.search,
                  color: Colors.red,
                ))
          ],
          title: const Text('What do you want to watch?'),
          backgroundColor: Colors.black),
      body: ListView(
        children: [
          FutureBuilder<NowPlaying>(
            future: controller.getDiscover(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text(
                  "Tidak ada data ",
                  style: TextStyle(color: Colors.white),
                ));
              } else {
                final nextPage = snapshot.data?.results;
                return ListView(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Now Playing",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.SEE_ALL_NOW_PLAYING,
                                    arguments: nextPage);
                              },
                              child: const Text(
                                "See all",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: snapshot.data?.results.length,
                        options: CarouselOptions(
                            height: 300,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal),
                        itemBuilder: (ctx, index, realIdx) {
                          final movie = snapshot.data?.results[index];

                          return Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_BANNER_NOW_PLAYING,
                                      arguments: movie);
                                },
                                child: Container(
                                  foregroundDecoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black
                                        ]),
                                  ),
                                  height: 300,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Image.network(
                                      fit: BoxFit.cover,
                                      "${Url.imageLw500}${movie?.backdropPath}"),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 100,
                                    "${Url.imageLw500}${movie?.posterPath}"),
                              ),
                            ),
                            Positioned(
                                left: 20,
                                bottom: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " Rating : ${movie?.voteAverage}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${movie?.title}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ]);
                        },
                      ),
                    ]);
              }
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: Get.width,
            child: FutureBuilder(
              future: controller.getGenreMovie(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.genres.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 41, 41, 41),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.genres[index].name,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 236, 48, 35),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ));
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<UpComingMovie>(
            future: controller.upComingMovie(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
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
                          "Up Coming Movies",
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
                                color: Colors.red,
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
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (context, index) {
                          final dataUp = snapshot.data!.results[index];
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
                                              "${Url.imageLw500}${dataUp.posterPath}"),
                                          fit: BoxFit.cover),
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      dataUp.title,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                  FutureBuilder<PopularfMovie>(
                    future: controller.popularMovie(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
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
                                  "Populars Movies",
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
                                        color: Colors.red,
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
                                itemCount: snapshot.data?.results.length,
                                itemBuilder: (context, index) {
                                  var dataUp = snapshot.data?.results[index];
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
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${dataUp?.title}",
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
              );
            },
          ),
        ],
      ),
    );
  }
}

class ContainerCategory extends StatelessWidget {
  const ContainerCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 100,
      height: 50,
      color: Colors.red,
    );
  }
}
