import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/data/character.dart';
import 'package:rick_and_morty/data/db/characters_hive_service.dart';
import 'package:rick_and_morty/data/network/rick_morty_api.dart';
import 'package:rick_and_morty/feature/common/character_controller.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character, required this.tag});

  final Character character;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: FittedBox(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Character image
                CharacterImage(character: character),

                SizedBox.square(dimension: 10),
                // Character info
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    character.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    character.status,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    "Gender: ${character.gender}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Text(
                    "Species: ${character.species}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),

            // Favorite icon
            Positioned(
              right: 12,
              top: 6,
              child: IconButton(
                onPressed: () {
                  character.isFavorite.value = !character.isFavorite.value;
                  Get.find<CharacterController>(tag: tag).setCharacterFavorite(
                    character.id,
                    character.isFavorite.value,
                  );
                },
                iconSize: 40,
                icon: Icon(
                  character.isFavorite.value
                      ? Icons.star_outlined
                      : Icons.star_border_outlined,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterImage extends StatefulWidget {
  const CharacterImage({super.key, required this.character});

  final Character character;

  @override
  State<CharacterImage> createState() => _CharacterImageState();
}

class _CharacterImageState extends State<CharacterImage> {
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    if (widget.character.imageUrl != null &&
            widget.character.imageFile.value == null ||
        (widget.character.imageFile.value != null &&
            widget.character.imageFile.value!.isEmpty)) {
      final image = await Get.find<RickMortyApi>().loadImage(
        widget.character.imageUrl!,
      );

      widget.character.imageFile.value = image;
      await saveCharacter();
    }
  }

  Future<void> saveCharacter() async {
    Get.find<CharactersHiveService>().saveCharacter(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox.square(
        dimension: 300,
        child: Center(
          child: ObxValue((image) {
            if (image.value == null) {
              return Container(
                color: Get.theme.splashColor,
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            if (image.value != null && image.value!.isEmpty) {
              return Container(
                color: Get.theme.splashColor,
                child: Icon(Icons.person_2_outlined),
              );
            }

            return Image.memory(image.value!);
          }, widget.character.imageFile),
        ),
      ),
    );
  }
}
