import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';

abstract class KnowledgeCardRepository {
  List<KnowledgeCard> getCards();
  Future<void> initializeCards();
  Future<void> toggleKnowledgeCards(int index);
  List<KnowledgeCard> getFavoriteCards();
  Future<void> updateStarCount(KnowledgeCard knowledgeCard, String starCount);
  Future<void> updateCardsFavoriteSituation(
      KnowledgeCard knowledgeCard, bool situation);
  Future<void> createKnowledgeCard(KnowledgeCard knowledgeCard);
}
