import 'package:flutter/material.dart';

class KnowledgeCard {
  final String id;
  final String name;
  String starCount;
  final String imageUrl;
  final String description;
  bool isFavorite;

  KnowledgeCard(
      {@required this.name,
      @required this.imageUrl,
      @required this.starCount,
      @required this.description,
      @required this.isFavorite,
      @required this.id});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "starCount": '3',
      "imageUrl": imageUrl,
      "description": description,
      "isFavorited": false,
    };
  }
}
