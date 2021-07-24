import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/get_favorite_cards.dart';

class FavoritesScreenPresenter extends Presenter {
  Function getFavoriteCardsOnNext;
  Function getFavoriteCardsOnError;

  final GetFavoriteCards _getFavoriteCards;

  FavoritesScreenPresenter(KnowledgeCardRepository knowledgeCardRepository)
      : _getFavoriteCards = GetFavoriteCards(knowledgeCardRepository);

  void getFavoriteCards() {
    _getFavoriteCards.execute(_GetFavoriteCardsObserver(this));
  }

  @override
  void dispose() {
    _getFavoriteCards.dispose();
  }
}

class _GetFavoriteCardsObserver extends Observer<List<KnowledgeCard>> {
  final FavoritesScreenPresenter _presenter;
  _GetFavoriteCardsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getFavoriteCardsOnError != null);
    _presenter.getFavoriteCardsOnError(e);
  }

  @override
  void onNext(List<KnowledgeCard> favoriteCards) {
    assert(_presenter.getFavoriteCardsOnNext != null);
    _presenter.getFavoriteCardsOnNext(favoriteCards);
  }
}
