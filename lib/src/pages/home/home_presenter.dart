import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/delete_knowledge_card.dart';
import 'package:knowledge_cards/src/domain/usecases/get_cards.dart';
import 'package:knowledge_cards/src/domain/usecases/toggle_knowledge_cards.dart';
import 'package:knowledge_cards/src/domain/usecases/update_cards_favorite_situation.dart';
import 'package:knowledge_cards/src/domain/usecases/uptade_star_count.dart';

class HomePresenter extends Presenter {
  Function getCardsOnNext;
  Function getCardsOnError;

  Function toggleKnowledgeCardsOnComplete;
  Function toggleKnowledgeCardsOnError;

  Function updateStarCountOnComplete;
  Function updateStarCountOnError;

  Function updateCardsFavoriteSituationOnComplete;
  Function updateCardsFavoriteSituationOnError;

  Function deleteKnowledgeCardOnComplete;
  Function deleteKnowledgeCardOnError;

  final GetCards _getCards;

  final ToggleKnowledgeCards _toggleKnowledgeCards;
  final UpdateStarCount _updateStarCount;
  final UpdateCardsFavoriteSituation _updateCardsFavoriteSituation;
  final DeleteKnowledgeCard _deleteKnowledgeCard;

  HomePresenter(KnowledgeCardRepository cardRepository)
      : _getCards = GetCards(cardRepository),
        _toggleKnowledgeCards = ToggleKnowledgeCards(cardRepository),
        _updateStarCount = UpdateStarCount(cardRepository),
        _updateCardsFavoriteSituation =
            UpdateCardsFavoriteSituation(cardRepository),
        _deleteKnowledgeCard = DeleteKnowledgeCard(cardRepository);

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

  void deleteKnowledgeCard(KnowledgeCard knowledgeCard) {
    _deleteKnowledgeCard.execute(
      _DeleteKnowledgeCardObserver(this),
      DeleteKnowledgeCardParams(knowledgeCard),
    );
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

    _toggleKnowledgeCards.dispose();
    _updateStarCount.dispose();
    _updateCardsFavoriteSituation.dispose();
    _deleteKnowledgeCard.dispose();
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

class _DeleteKnowledgeCardObserver extends Observer<void> {
  final HomePresenter _presenter;
  _DeleteKnowledgeCardObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.deleteKnowledgeCardOnComplete != null);
    _presenter.deleteKnowledgeCardOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.deleteKnowledgeCardOnError != null);
    _presenter.deleteKnowledgeCardOnError(e);
  }

  @override
  void onNext(_) {}
}
