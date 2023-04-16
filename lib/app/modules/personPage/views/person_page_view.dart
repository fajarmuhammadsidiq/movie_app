import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/app/data/person_model.dart';

import '../../../data/const.dart';
import '../controllers/person_page_controller.dart';

class PersonPageView extends GetView<PersonPageController> {
  const PersonPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Popular Person ",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.red,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: PagedGridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 4 / 6),
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<PersonModel>(
                itemBuilder: (context, item, index) {
              PersonModel data = item;
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Image.network(
                            fit: BoxFit.cover,
                            '${Url.imageLw500}${item.profilePath}'),
                        Positioned(
                            left: 5,
                            bottom: 10,
                            child: Text(
                              item.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
