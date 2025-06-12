import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/character.dart';
import 'package:rick_and_morty/feature/common/character_card.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({
    super.key,
    required this.characters,
    required this.tag,
  });

  final List<Character> characters;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: characters.length,
        (context, index) {
          return CharacterCard(
            key: ValueKey(characters.elementAt(index).id),
            tag: tag,
            character: characters.elementAt(index),
          );
        },
      ),
    );
  }
}
