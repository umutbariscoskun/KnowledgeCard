import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/pages/home/home_view.dart';
import 'package:knowledge_cards/src/pages/splash_screen/splash_screen_presenter.dart';

class SplashScreenController extends Controller {
  final SplashScreenPresenter _splashScreenPresenter;
  SplashScreenController(KnowledgeCardRepository cardRepository)
      : _splashScreenPresenter = SplashScreenPresenter(cardRepository),
        super();

  void onInitState() {
    _splashScreenPresenter.initializeCards();

    super.onInitState();
  }

  @override
  void initListeners() {
    _splashScreenPresenter.initializeCardsOnComplete = () {
      Future.delayed(Duration(seconds: 2)).then((_) => Navigator.push(
          getContext(), MaterialPageRoute(builder: (context) => HomePage())));

      print("initialize cards complete succesfuly");
    };

    _splashScreenPresenter.initializeCardsOnError = (e) {
      print("initialize cards uncomplete");
    };
  }

  @override
  void onDisposed() {
    _splashScreenPresenter.dispose();
    super.onDisposed();
  }
}
