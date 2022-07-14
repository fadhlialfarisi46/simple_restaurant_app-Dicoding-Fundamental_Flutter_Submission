import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: restaurant.name,
                      child: Image.network(restaurant.pictureId),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ),
                            const FavoriteButton()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        restaurant.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Staatliches'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.place,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  restaurant.city,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(restaurant.rating.toString(),
                                    style: const TextStyle(fontWeight: FontWeight
                                        .bold))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text('Description',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6)),
                      const SizedBox(height: 8.0,),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(restaurant.description,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2, textAlign: TextAlign.justify,)),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text('Foods',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6)),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: restaurant.menus.foods.map((foods) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(foods.name),
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(side: BorderSide(color: Colors.red)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: Text('Drinks',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6)),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: restaurant.menus.drinks.map((drinks) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(drinks.name),
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(side: BorderSide(color: Colors.blue)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ));
  }
}
