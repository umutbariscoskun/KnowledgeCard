import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/pages/create_knowledgecard/create_knowledgecard_presenter.dart';
import 'package:knowledge_cards/src/pages/home/home_view.dart';
import 'package:knowledge_cards/src/pages/splash_screen/splash_screen_view.dart';

class CreateKnowledgeCardController extends Controller {
  final CreateKnowledgeCardPresenter _knowledgeCardPresenter;
  CreateKnowledgeCardController(KnowledgeCardRepository cardRepository)
      : _knowledgeCardPresenter = CreateKnowledgeCardPresenter(cardRepository),
        super();
  List<KnowledgeCard> cards = [];

  String name;
  String description;
  String imageUrl;
  String starCount;
  String id;
  bool isFavorite = false;
  bool isCreatingFieldsNull = false;

  void onInitState() {
    _knowledgeCardPresenter.getCards();
    super.onInitState();
  }

  @override
  void initListeners() {
    _knowledgeCardPresenter.createKnowledgeCardOnComplete = () {
      Navigator.push(
        getContext(),
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      print("creating knowledge card is succesfuly");
    };

    _knowledgeCardPresenter.createKnowledgeCardOnError = (e) {
      print("creating knowledge card is unsuccesfuly");
    };

    _knowledgeCardPresenter.getCardsOnNext = (List<KnowledgeCard> response) {
      cards = response;

      refreshUI();
      print("get cards onnext succesfuly");
    };
    _knowledgeCardPresenter.getCardsOnError = (e) {
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      print("get cards on error");
    };
  }

  @override
  void onDisposed() {
    _knowledgeCardPresenter.dispose();
    super.onDisposed();
  }

  void createKnowledgeCard() {
    _knowledgeCardPresenter.createKnowledgeCard(KnowledgeCard(
        name: name,
        imageUrl: imageUrl,
        starCount: '3',
        description: description,
        isFavorite: isFavorite,
        id: id));
    refreshUI();
  }

  void refreshScreen() {
    refreshUI();
  }
}
