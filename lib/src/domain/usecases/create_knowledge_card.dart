import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class CreateKnowledgeCard extends UseCase<void, CreateKnowledgeCardParams> {
  final KnowledgeCardRepository knowledgeCardRepository;
  CreateKnowledgeCard(this.knowledgeCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      CreateKnowledgeCardParams param) async {
    final controller = StreamController<void>();
    try {
      await knowledgeCardRepository.createKnowledgeCard(param.knowledgeCard);
      logger.finest('Create  UseCase succesful');
      controller.close();
    } catch (e) {
      logger.severe('Create UseCase unsuccesful');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

class CreateKnowledgeCardParams {
  final KnowledgeCard knowledgeCard;
  CreateKnowledgeCardParams(this.knowledgeCard);
}
