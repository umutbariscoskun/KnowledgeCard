import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/create_knowledge_card.dart';
import 'package:knowledge_cards/src/domain/usecases/get_cards.dart';

class CreateKnowledgeCardPresenter extends Presenter {
  Function createKnowledgeCardOnComplete;
  Function createKnowledgeCardOnError;

  Function getCardsOnNext;
  Function getCardsOnError;

  final CreateKnowledgeCard _createKnowledgeCard;
  final GetCards _getCards;

  CreateKnowledgeCardPresenter(KnowledgeCardRepository knowledgeCardRepository)
      : _createKnowledgeCard = CreateKnowledgeCard(
          knowledgeCardRepository,
        ),
        _getCards = GetCards(knowledgeCardRepository);

  void createKnowledgeCard(KnowledgeCard knowledgeCard) {
    _createKnowledgeCard.execute(_CreateKnowledgeCardObserver(this),
        CreateKnowledgeCardParams(knowledgeCard));
  }

  void getCards() {
    _getCards.execute(_GetCardsObserver(this));
  }

  @override
  void dispose() {
    _createKnowledgeCard.dispose();
    _getCards.dispose();
  }
}

class _CreateKnowledgeCardObserver extends Observer<void> {
  final CreateKnowledgeCardPresenter _presenter;
  _CreateKnowledgeCardObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.createKnowledgeCardOnComplete != null);
    _presenter.createKnowledgeCardOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.createKnowledgeCardOnError != null);
    _presenter.createKnowledgeCardOnError(e);
  }

  @override
  void onNext(_) {}
}

class _GetCardsObserver extends Observer<List<KnowledgeCard>> {
  final CreateKnowledgeCardPresenter _presenter;
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
