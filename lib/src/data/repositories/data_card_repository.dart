import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:knowledge_cards/src/domain/entities/knowledge_card.dart';
import 'package:knowledge_cards/src/domain/repository/knowledge_card_repository.dart';

class DataCardRepository implements KnowledgeCardRepository {
  static final DataCardRepository _instance = DataCardRepository._internal();
  DataCardRepository._internal();

  factory DataCardRepository() => _instance;
  final firestoreInstance = FirebaseFirestore.instance;

  List<KnowledgeCard> cards = [];
  List<KnowledgeCard> favoriteCards = [];

  @override
  List<KnowledgeCard> getCards() {
    return cards.toList();
  }

  @override
  Future<void> initializeCards() async {
    try {
      final value = await firestoreInstance.collection("cards").get();
      value.docs.forEach((element) {
        KnowledgeCard card = KnowledgeCard(
            id: element.id,
            name: element.data()['name'],
            imageUrl: element.data()['imageUrl'],
            starCount: element.data()['starCount'],
            description: element.data()['description'],
            isFavorite: element.data()['isFavorited']);
        cards.add(card);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> toggleKnowledgeCards(int index) async {
    if (cards[index].isFavorite) {
      cards[index].isFavorite = false;
    } else {
      cards[index].isFavorite = true;
    }
  }

  @override
  List<KnowledgeCard> getFavoriteCards() {
    return cards
        .where((KnowledgeCard knowledgeCard) => knowledgeCard.isFavorite)
        .toList();
  }

  @override
  Future<void> updateStarCount(
      KnowledgeCard knowledgeCard, String starCount) async {
    try {
      await firestoreInstance
          .collection("cards")
          .doc(knowledgeCard.id)
          .update({"starCount": starCount});
      int index = cards.indexWhere((element) => element.id == knowledgeCard.id);
      cards.elementAt(index).starCount = starCount;
    } catch (e) {}
  }

  @override
  Future<void> updateCardsFavoriteSituation(
      KnowledgeCard knowledgeCard, bool situation) async {
    final CollectionReference collectionReference =
        firestoreInstance.collection("cards");
    collectionReference
        .doc(knowledgeCard.id)
        .update({"isFavorited": situation}).whenComplete(() async {
      print("favorite state Completed");
    }).catchError((e) => print(e));
  }

  @override
  Future<void> createKnowledgeCard(KnowledgeCard knowledgeCard) async {
    try {
      print(UniqueKey());
      await firestoreInstance.collection("cards").add(
            knowledgeCard.toMap(),
          );
      cards.add(knowledgeCard);
    } catch (e) {
      print(e);
    }
  }
}
