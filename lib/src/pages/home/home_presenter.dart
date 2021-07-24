import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/get_cards.dart';
import 'package:knowledge_cards/src/domain/usecases/initialize_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/toggle_knowledge_cards.dart';
import 'package:knowledge_cards/src/domain/usecases/update_cards_favorite_situation.dart';
import 'package:knowledge_cards/src/domain/usecases/uptade_star_count.dart';

class HomePresenter extends Presenter {
  Function getCardsOnNext;
  Function getCardsOnError;

  // Function initializeCardsOnComplete;
  // Function initializeCardsOnError;

  Function toggleKnowledgeCardsOnComplete;
  Function toggleKnowledgeCardsOnError;

  Function updateStarCountOnComplete;
  Function updateStarCountOnError;

  Function updateCardsFavoriteSituationOnComplete;
  Function updateCardsFavoriteSituationOnError;

  final GetCards _getCards;
  // final InitializeCards _initializeCards;
  final ToggleKnowledgeCards _toggleKnowledgeCards;
  final UpdateStarCount _updateStarCount;
  final UpdateCardsFavoriteSituation _updateCardsFavoriteSituation;

  HomePresenter(KnowledgeCardRepository cardRepository)
      : _getCards = GetCards(cardRepository),
        // _initializeCards = InitializeCards(cardRepository),
        _toggleKnowledgeCards = ToggleKnowledgeCards(cardRepository),
        _updateStarCount = UpdateStarCount(cardRepository),
        _updateCardsFavoriteSituation =
            UpdateCardsFavoriteSituation(cardRepository);

  // void initializeCards() {
  //   _initializeCards.execute(_InitializeCardsObserver(this));
  // }

  void getCards() {
    _getCards.execute(_GetCardsObserver(this));
  }

  void toggleKnowledgeCards(int index) {
    _toggleKnowledgeCards.execute(
        _ToggleKnowledgeCardsObserver(this), ToggleKnowledgeCardParams(index));
  }

  void updateStarCount(KnowledgeCard knowledgeCard, String starCount) {
    _updateStarCount.execute(_UpdateStarCountObserver(this),
        UpdateStarCountParams(knowledgeCard, starCount));
  }

  void updateCardsFavoriteSituation(
      KnowledgeCard knowledgeCard, bool situation) {
    _updateCardsFavoriteSituation.execute(
        _UpdateCardsFavoriteSituationObserver(this),
        UpdateCardsFavoriteSituationParams(knowledgeCard, situation));
  }

  @override
  void dispose() {
    _getCards.dispose();
    // _initializeCards.dispose();
    _toggleKnowledgeCards.dispose();
    _updateStarCount.dispose();
    _updateCardsFavoriteSituation.dispose();
  }
}

class _ToggleKnowledgeCardsObserver extends Observer<void> {
  final HomePresenter _presenter;
  _ToggleKnowledgeCardsObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.toggleKnowledgeCardsOnComplete != null);
    _presenter.toggleKnowledgeCardsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.toggleKnowledgeCardsOnError != null);
    _presenter.toggleKnowledgeCardsOnError(e);
  }

  @override
  void onNext(_) {}
}

// class _InitializeCardsObserver extends Observer<void> {
//   final HomePresenter _presenter;
//   _InitializeCardsObserver(this._presenter);

//   @override
//   void onComplete() {
//     assert(_presenter.initializeCardsOnComplete != null);
//     _presenter.initializeCardsOnComplete();
//   }

//   @override
//   void onError(e) {
//     assert(_presenter.initializeCardsOnError != null);
//     _presenter.initializeCardsOnError(e);
//   }

//   @override
//   void onNext(_) {}
// }

class _GetCardsObserver extends Observer<List<KnowledgeCard>> {
  final HomePresenter _presenter;
  _GetCardsObserver(this._presenter);
  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getCardsOnError != null);
    _presenter.getCardsOnError(e);
  }

  @override
  void onNext(List<KnowledgeCard> cards) {
    assert(_presenter.getCardsOnNext != null);
    _presenter.getCardsOnNext(cards);
  }
}

class _UpdateStarCountObserver extends Observer<void> {
  final HomePresenter _presenter;
  _UpdateStarCountObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.updateStarCountOnComplete != null);
    _presenter.updateStarCountOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.updateStarCountOnError != null);
    _presenter.updateStarCountOnError(e);
  }

  @override
  void onNext(_) {}
}

class _UpdateCardsFavoriteSituationObserver extends Observer<void> {
  final HomePresenter _presenter;
  _UpdateCardsFavoriteSituationObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.updateCardsFavoriteSituationOnComplete != null);
    _presenter.updateCardsFavoriteSituationOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.updateCardsFavoriteSituationOnError != null);
    _presenter.updateCardsFavoriteSituationOnError(e);
  }

  @override
  void onNext(_) {}
}
