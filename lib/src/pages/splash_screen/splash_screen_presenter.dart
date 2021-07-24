import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';
import 'package:knowledge_cards/src/domain/usecases/initialize_card_repository.dart';

class SplashScreenPresenter extends Presenter {
  Function initializeCardsOnComplete;
  Function initializeCardsOnError;

  final InitializeCards _initializeCards;

  SplashScreenPresenter(KnowledgeCardRepository cardRepository)
      : _initializeCards = InitializeCards(cardRepository);

  void initializeCards() {
    _initializeCards.execute(_InitializeCardsObserver(this));
  }

  @override
  void dispose() {
    _initializeCards.dispose();
  }
}

class _InitializeCardsObserver extends Observer<void> {
  final SplashScreenPresenter _presenter;
  _InitializeCardsObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.initializeCardsOnComplete != null);
    _presenter.initializeCardsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.initializeCardsOnError != null);
    _presenter.initializeCardsOnError(e);
  }

  @override
  void onNext(_) {}
}
