import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:knowledge_cards/src/data/repositories/data_card_repository.dart';
import 'package:knowledge_cards/src/pages/create_knowledgecard/create_knowledgecard_view.dart';
import 'package:knowledge_cards/src/pages/favorites_screen/favorites_screen_view.dart';
import 'package:knowledge_cards/src/pages/home/home_controller.dart';

class HomePage extends View {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataCardRepository()));

  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return FloatingActionButton(
            backgroundColor: Color(0xFFca575e),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateKnowledgeCardScreen(),
                ),
              );
            },
          );
        },
      ),
      key: globalKey,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) {
                return PageView(
                  pageSnapping: true,
                  controller: pageController,
                  onPageChanged: (index) {
                    pageIndex = index;

                    controller.refreshScreen();
                  },
                  children: [
                    for (int index = 0;
                        index < controller.cards.length;
                        index++)
                      Scaffold(
                        extendBodyBehindAppBar: true,
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          actions: [
                            ControlledWidgetBuilder<HomeController>(
                              builder: (context, controller) {
                                return Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller
                                              .toggleKnowledgeCards(pageIndex);
                                          controller
                                              .updateCardsFavoriteSituation(
                                                  controller.cards[index],
                                                  controller
                                                      .cards[index].isFavorite);
                                        },
                                        icon: controller.cards[index].isFavorite
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
                                      IconButton(
                                        onPressed: () =>
                                            controller.deleteKnowledgeCard(
                                                controller.cards[index]),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 43,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.grey[700],
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Text(
                                                      "Detay için fotoğrafa tıklayın!",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    )));
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FavoritesScreen(),
                                              ),
                                            );
                                            controller.refreshScreen();
                                          },
                                          icon: Icon(
                                            Icons.list,
                                            size: 43,
                                          )),
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
                                      controller.cards[index].imageUrl),
                                  fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, bottom: 100),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.8,
                                          child: Text(
                                            controller.cards[index].name,
                                            style: TextStyle(fontSize: 40),
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
                                          initialRating: double.parse(controller
                                              .cards[index].starCount),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            controller.updateStarCount(
                                              controller.cards[index],
                                              rating.toString(),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.cards[index].description,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
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
        ],
      ),
    );
  }
}
