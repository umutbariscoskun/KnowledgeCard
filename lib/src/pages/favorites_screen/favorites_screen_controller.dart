import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/pages/favorites_screen/favorites_screen_presenter.dart';

class FavoritesScreenController extends Controller {
  final FavoritesScreenPresenter _favoriteScreenPresenter;
  FavoritesScreenController(KnowledgeCardRepository cardRepository)
      : _favoriteScreenPresenter = FavoritesScreenPresenter(cardRepository),
        super();

  int pageIndex;
  List<KnowledgeCard> favoriteCards = [];

  void onInitState() {
    _favoriteScreenPresenter.getFavoriteCards();

    super.onInitState();
  }

  @override
  void initListeners() {
    _favoriteScreenPresenter.getFavoriteCardsOnNext =
        (List<KnowledgeCard> response) {
      favoriteCards = response;

      refreshUI();
      print("get favorite cards on next succesfuly");
    };

    _favoriteScreenPresenter.getFavoriteCardsOnError = (e) {
      print("get favorite cards uncomplete");
    };
  }

  @override
  void onDisposed() {
    _favoriteScreenPresenter.dispose();
    super.onDisposed();
  }

  void initializePageViewSpesificScreen(int initialIndex) {
    PageController(initialPage: initialIndex);
  }

  void refreshScreen() {
    refreshUI();
  }
}
