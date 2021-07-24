import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/data/repositories/data_card_repository.dart';
import 'package:knowledge_cards/src/pages/splash_screen/splash_screen_controller.dart';

class SplashScreenPage extends View {
  SplashScreenPage();

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState
    extends ViewState<SplashScreenPage, SplashScreenController> {
  _SplashScreenPageState()
      : super(SplashScreenController(DataCardRepository()));
  SplashScreenController splashScreenController;

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1489549132488-d00b7eee80f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: Container(
              child: CircularProgressIndicator(
                color: Color(0xFFca575e),
              ),
            ),
          )
        ],
      ),
    );
  }
}
