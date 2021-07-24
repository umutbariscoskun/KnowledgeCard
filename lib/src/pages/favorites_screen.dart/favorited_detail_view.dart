import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:knowledge_cards/src/data/repositories/data_card_repository.dart';
import 'package:knowledge_cards/src/pages/favorites_screen.dart/favorites_screen_controller.dart';

class FavoritedDetailScreen extends View {
  FavoritedDetailScreen(this.selectedIndex);

  @override
  _FavoritedDetailScreenState createState() => _FavoritedDetailScreenState();
  final int selectedIndex;
}

class _FavoritedDetailScreenState
    extends ViewState<FavoritedDetailScreen, FavoritesScreenController> {
  _FavoritedDetailScreenState()
      : super(FavoritesScreenController(DataCardRepository()));
  PageController pageController;

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          Scaffold(
            body: Container(
              width: size.width,
              height: size.height,
              child: ControlledWidgetBuilder<FavoritesScreenController>(
                builder: (context, controller) {
                  return PageView(
                    controller: pageController =
                        PageController(initialPage: widget.selectedIndex + 1),
                    pageSnapping: true,
                    children: [
                      for (int i = 0; i < controller.favoriteCards.length; i++)
                        Scaffold(
                          extendBodyBehindAppBar: true,
                          backgroundColor: Colors.transparent,
                          appBar: AppBar(
                            actions: [
                              ControlledWidgetBuilder<
                                  FavoritesScreenController>(
                                builder: (context, controller) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: controller
                                                  .favoriteCards[i].isFavorite
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 43,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  size: 43,
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                          body: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        controller.favoriteCards[i].imageUrl),
                                    fit: BoxFit.cover)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 10, bottom: 100),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.width * 0.8,
                                            child: Text(
                                              controller.favoriteCards[i].name,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            initialRating: double.parse(
                                                controller.favoriteCards[i]
                                                    .starCount),
                                            itemSize: 25,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: null,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        controller.favoriteCards[i].description,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
