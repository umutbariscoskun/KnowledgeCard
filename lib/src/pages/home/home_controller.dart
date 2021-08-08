import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/pages/home/home_presenter.dart';
import 'package:knowledge_cards/src/pages/home/home_view.dart';
import 'package:knowledge_cards/src/pages/splash_screen/splash_screen_view.dart';

class HomeController extends Controller {
  final HomePresenter _homePresenter;
  HomeController(KnowledgeCardRepository cardRepository)
      : _homePresenter = HomePresenter(cardRepository),
        super();
  List<KnowledgeCard> cards = [];

  bool isFavorited = false;

  void onInitState() {
    _homePresenter.getCards();
    super.onInitState();
  }

  @override
  void initListeners() {
    _homePresenter.updateCardsFavoriteSituationOnComplete = () {
      print("updating favorite state succesfuly");
    };
    _homePresenter.updateCardsFavoriteSituationOnError = () {
      print("couldn't update favorite state");
    };

    _homePresenter.updateStarCountOnComplete = () {
      _homePresenter.getCards();
      print("Updating starCount complete succesfuly");
    };
    _homePresenter.updateStarCountOnError = (e) {
      print("couldnt update starCount");
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };

    _homePresenter.deleteKnowledgeCardOnComplete = () {
      print("deleting complete!");
      Navigator.push(
        getContext(),
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      refreshUI();
    };

    _homePresenter.deleteKnowledgeCardOnError = (e) {
      print(e);
    };

    _homePresenter.toggleKnowledgeCardsOnComplete = () {
      print("toggling cards complete succesfuly");
    };
    _homePresenter.toggleKnowledgeCardsOnError = (e) {
      print("cards couldn't toggle");
    };

    _homePresenter.getCardsOnNext = (List<KnowledgeCard> response) {
      cards = response;

      refreshUI();
      print("get cards onnext succesfuly");
    };
    _homePresenter.getCardsOnError = (e) {
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      print("get cards on error");
    };
  }

  @override
  void onDisposed() {
    _homePresenter.dispose();
    super.onDisposed();
  }

  void toggleKnowledgeCards(int index) {
    _homePresenter.toggleKnowledgeCards(index);
    refreshUI();
  }

  void updateStarCount(KnowledgeCard knowledgeCard, String starCount) {
    _homePresenter.updateStarCount(knowledgeCard, starCount);
    refreshUI();
  }

  void updateCardsFavoriteSituation(
      KnowledgeCard knowledgeCard, bool situation) {
    _homePresenter.updateCardsFavoriteSituation(knowledgeCard, situation);
    refreshUI();
  }

  void deleteKnowledgeCard(KnowledgeCard knowledgeCard) {
    _homePresenter.deleteKnowledgeCard(knowledgeCard);
    refreshUI();
  }

  void refreshScreen() {
    refreshUI();
  }
}
