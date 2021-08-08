import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class DeleteKnowledgeCard extends UseCase<void, DeleteKnowledgeCardParams> {
  final KnowledgeCardRepository knowledgeCardRepository;
  DeleteKnowledgeCard(this.knowledgeCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      DeleteKnowledgeCardParams params) async {
    final controller = StreamController<void>();
    try {
      await knowledgeCardRepository.deleteKnowledgeCard(params.knowledgeCard);

      logger.finest('Delete successful');
      controller.close();
    } catch (e) {
      logger.severe('Delete unsuccessful');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

class DeleteKnowledgeCardParams {
  final KnowledgeCard knowledgeCard;
  DeleteKnowledgeCardParams(this.knowledgeCard);
}
