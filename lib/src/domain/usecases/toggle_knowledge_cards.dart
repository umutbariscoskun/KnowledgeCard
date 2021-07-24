import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class ToggleKnowledgeCards extends UseCase<void, ToggleKnowledgeCardParams> {
  final KnowledgeCardRepository knowledgeCardRepository;
  ToggleKnowledgeCards(this.knowledgeCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      ToggleKnowledgeCardParams params) async {
    final controller = StreamController<void>();
    try {
      await knowledgeCardRepository.toggleKnowledgeCards(params.index);

      logger.finest('');
      controller.close();
    } catch (e) {
      logger.severe('');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

class ToggleKnowledgeCardParams {
  final int index;
  ToggleKnowledgeCardParams(this.index);
}
