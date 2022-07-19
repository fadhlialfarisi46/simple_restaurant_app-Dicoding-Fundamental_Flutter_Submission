import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';

import '../data/api/api_service.dart';
import '../data/model/detail_page_arguments.dart';
import '../ui/detail_page.dart';

class ItemRestaurants extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurants({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: DetailPageArguments(
                restaurant.id, restaurant.pictureId));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            ApiService().urlSmallImage + restaurant.pictureId,
                            fit: BoxFit.cover,
                          ))),
                  Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: Colors.green,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      restaurant.city,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
