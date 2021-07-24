import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class InitializeCards extends UseCase<void, void> {
  final KnowledgeCardRepository cardRepository;

  InitializeCards(this.cardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    final StreamController<void> controller = StreamController<void>();
    try {
      await cardRepository.initializeCards();

      logger.finest('InitializeCards UseCase successful');
      controller.close();
    } catch (e) {
      logger.severe('InitializeCards UseCase unsuccessful');
      print(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}
