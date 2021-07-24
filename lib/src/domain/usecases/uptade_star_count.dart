import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class UpdateStarCount extends UseCase<void, UpdateStarCountParams> {
  final KnowledgeCardRepository knowledgeCardRepository;
  UpdateStarCount(this.knowledgeCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(UpdateStarCountParams params) async {
    final controller = StreamController<void>();
    try {
      await knowledgeCardRepository.updateStarCount(
          params.knowledgeCard, params.starCount);

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

class UpdateStarCountParams {
  final String starCount;
  final KnowledgeCard knowledgeCard;
  UpdateStarCountParams(this.knowledgeCard, this.starCount);
}
