import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class UpdateCardsFavoriteSituation
    extends UseCase<void, UpdateCardsFavoriteSituationParams> {
  final KnowledgeCardRepository knowledgeCardRepository;
  UpdateCardsFavoriteSituation(this.knowledgeCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      UpdateCardsFavoriteSituationParams params) async {
    final controller = StreamController<void>();
    try {
      await knowledgeCardRepository.updateCardsFavoriteSituation(
          params.knowledgeCard, params.situation);

      logger.finest('UpdateStarCountUseCase successful');
      controller.close();
    } catch (e) {
      logger.severe('UpdateStarCountUseCase unsuccessful');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

class UpdateCardsFavoriteSituationParams {
  final bool situation;
  final KnowledgeCard knowledgeCard;
  UpdateCardsFavoriteSituationParams(this.knowledgeCard, this.situation);
}
