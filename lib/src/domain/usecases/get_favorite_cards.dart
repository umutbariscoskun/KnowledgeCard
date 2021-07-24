import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class GetFavoriteCards extends UseCase<List<KnowledgeCard>, void> {
  final KnowledgeCardRepository cardRepository;

  GetFavoriteCards(this.cardRepository);

  @override
  Future<Stream<List<KnowledgeCard>>> buildUseCaseStream(void params) async {
    final StreamController<List<KnowledgeCard>> controller =
        StreamController<List<KnowledgeCard>>();
    try {
      final List<KnowledgeCard> favoriteCards =
          cardRepository.getFavoriteCards();
      controller.add(favoriteCards);
      logger.finest('GetFavoriteCards UseCase successful');
      controller.close();
    } catch (e) {
      logger.severe('GetFavoriteCards UseCase unsuccessful');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}
