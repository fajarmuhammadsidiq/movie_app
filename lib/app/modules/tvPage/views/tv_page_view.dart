import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/const.dart';
import '../../../data/tv_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/tv_page_controller.dart';

class TvPageView extends GetView<TvPageController> {
  const TvPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          title: const Text('TV Series , enjoy with Family'),
          backgroundColor: Colors.black),
      body: ListView(
        children: [
          FutureBuilder<TvModels>(
            future: controller.getDiscover(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.yellow,
                    color: Colors.grey,
                  ),
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
                              "Popular TV ",
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
                      CarouselSlider.builder(
                        itemCount: snapshot.data?.results!.length,
                        options: CarouselOptions(
                            height: 300,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal),
                        itemBuilder: (ctx, index, realIdx) {
                          final movie = snapshot.data?.results![index];

                          return Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_T_V,
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
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${Url.imageLw500}${movie?.backdropPath}"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 100,
                                    "${Url.imageLw500}${movie?.posterPath == null ? movie?.backdropPath : movie?.posterPath}"),
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
                                      "${movie?.name}",
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
          FutureBuilder<TvModels>(
            future: controller.upComingMovie(),
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
                          "Top Rated TV",
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
                          final dataUp = snapshot.data?.results![index];
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
                                              "${Url.imageLw500}${dataUp!.posterPath}"),
                                          fit: BoxFit.cover),
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      dataUp.name!,
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
                  FutureBuilder<TvModels>(
                    future: controller.popularMovie(),
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
                                  "On Air TV ",
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
                                        SizedBox(height: 10),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
