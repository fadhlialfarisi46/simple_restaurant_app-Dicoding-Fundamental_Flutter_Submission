import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/common/navigation_route.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';

import '../data/api/api_service.dart';
import '../ui/detail_page.dart';

class ItemRestaurants extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurants({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(DetailPage.routeName, restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Card(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Hero(
                            tag: restaurant.pictureId,
                            child: Image.network(
                              ApiService().urlSmallImage + restaurant.pictureId,
                              fit: BoxFit.fill,
                            )),
                      )),
                  Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
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
