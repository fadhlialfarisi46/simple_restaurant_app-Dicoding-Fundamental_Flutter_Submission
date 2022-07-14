import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';
import 'package:simple_restaurant_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              final List<Restaurant> restaurants =
                  parseRestos(snapshot.data!);
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                },
                itemCount: restaurants.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
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
                          tag: restaurant.name,
                          child: Image.network(restaurant.pictureId, fit: BoxFit.cover,))),
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
                                    const Icon(Icons.place, color: Colors.green, size: 12,),
                                    const SizedBox(width: 8.0,),
                                    Text(restaurant.city, style: const TextStyle(fontSize: 12),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.yellow, size: 12,),
                                    const SizedBox(width: 8.0,),
                                    Text(restaurant.rating.toString(),  style: const TextStyle(fontSize: 12),)
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
