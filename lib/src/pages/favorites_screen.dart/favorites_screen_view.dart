import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/data/repositories/data_card_repository.dart';
import 'package:knowledge_cards/src/pages/favorites_screen.dart/favorited_detail_view.dart';
import 'package:knowledge_cards/src/pages/favorites_screen.dart/favorites_screen_controller.dart';

class FavoritesScreen extends View {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState
    extends ViewState<FavoritesScreen, FavoritesScreenController> {
  _FavoriteScreenState()
      : super(FavoritesScreenController(DataCardRepository()));

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Favorilerim",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
        key: globalKey,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1489549132488-d00b7eee80f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80"),
                  fit: BoxFit.cover)),
          width: size.width,
          height: size.height,
          child: SafeArea(
            child: Column(
              children: [
                ControlledWidgetBuilder<FavoritesScreenController>(
                  builder: (context, controller) {
                    return Expanded(
                      child: ListView(
                        children: [
                          Wrap(
                            children: [
                              for (int i = 0;
                                  i < controller.favoriteCards.length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.grey[700],
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                              "Favorilerinizde gezinmek için ekranı kaydırın!",
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            )));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FavoritedDetailScreen(i),
                                      ),
                                    );
                                    controller.refreshScreen();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: 100,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                .favoriteCards[i].imageUrl),
                                            fit: BoxFit.cover)),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
