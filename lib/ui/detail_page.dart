import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/data/model/customer_review.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';
import 'package:simple_restaurant_app/provider/detail_restaurant_provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;
  final String pictureId;

  const DetailPage({
    Key? key,
    required this.id,
    required this.pictureId,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  bool _formVisible = false;

  void setFormVisible(bool value){
    setState(() {
      _formVisible = value;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantsProvider>(
        create: (_) =>
            DetailRestaurantsProvider(apiService: ApiService(), id: widget.id),
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Consumer<DetailRestaurantsProvider>(
                    builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    Future.delayed(Duration.zero, () async {
                      setFormVisible(true);
                    });
                    return _buildDetailBody(state.result.restaurant);
                  } else if (state.state == ResultState.NoData) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state.state == ResultState.Error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(child: Text(''));
                  }
                }),
                if(_formVisible) _buildFormReview(),
                if(_formVisible) Consumer<DetailRestaurantsProvider>(builder: (context, state, _){
                  if(state.customerReview.isNotEmpty){
                    return _buildReview(state.customerReview);
                  }else{
                    return const Center(child: Text('No review'),);
                  }
                })
              ],
            ),
          ),
        )));
  }

  Widget _buildHeader() => Stack(
        children: [
          Hero(
            tag: widget.pictureId,
            child: Image.network(ApiService().urlLargeImage + widget.pictureId),
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
      );

  Widget _buildDetailBody(Restaurant restaurant) {
    return Padding(
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
                Expanded(
                  child: Column(
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
                      ),
                      restaurant.address!.isNotEmpty
                          ? Text(
                              restaurant.address!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : const Text('')
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(restaurant.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
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
                  style: Theme.of(context).textTheme.headline6)),
          const SizedBox(
            height: 8.0,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                restaurant.description,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.justify,
              )),
          const SizedBox(
            height: 16.0,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Text('Categories',
                  style: Theme.of(context).textTheme.headline6)),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: restaurant.categories!.map((category) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(category.name),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.green)),
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
              child:
                  Text('Foods', style: Theme.of(context).textTheme.headline6)),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: restaurant.menus!.foods.map((foods) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(foods.name),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.red)),
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
              child:
                  Text('Drinks', style: Theme.of(context).textTheme.headline6)),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: restaurant.menus!.drinks.map((drinks) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(drinks.name),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormReview() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomLeft,
                child: Text('Add review',
                    style: Theme.of(context).textTheme.headline6)),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your name...',
                    prefixIcon: Icon(Icons.person, color: Colors.black)),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
            const SizedBox(
              height: 4.0,
            ),
            TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your review...',
                    prefixIcon: Icon(Icons.comment, color: Colors.black)),
                controller: _reviewController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                }),
            const SizedBox(
              height: 4.0,
            ),
            Consumer<DetailRestaurantsProvider>(builder: (context, state, _) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 54,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await state.postReview(widget.id, _nameController.text,
                            _reviewController.text);
                        if (state.postState == PostState.Loading) {
                          const CircularProgressIndicator();
                        } else if (state.postState == PostState.Error) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(state.postMessage),
                                  actions: [
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        } else if (state.postState == PostState.Success) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Your review added'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                        _clearFormTextField();
                      }
                    },
                    child: const Text('Add review')),
              );
            }),
          ],
        )),
  );

  Widget _buildReview(List<CustomerReview> customerReview) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
              alignment: Alignment.bottomLeft,
              child: Text('Review from users',
                  style: Theme.of(context).textTheme.headline6)),
          ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var review = customerReview[index];
              return cardReview(review: review);
            },
            itemCount: customerReview.length,
          ),
        ],
      ),
    );
  }

  Widget cardReview({required CustomerReview review}) {
    return Material(
        child: Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.circular(8.0)),
            child: ListTile(
              title: Text(review.name),
              subtitle: Text(review.review + '\n' + review.date),
            )),
      ],
    ));
  }

  void _clearFormTextField() {
    _nameController.clear();
    _reviewController.clear();
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
