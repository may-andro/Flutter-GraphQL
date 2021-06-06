import 'package:flutter_graphql/core/mapper/entity_model_mapper.dart';
import 'package:flutter_graphql/data/model/character_response.dart';
import 'package:flutter_graphql/domain/entity/character.dart';

class CharacterResponseEntityMapper extends ObjectMapper<CharacterResponse, Character> {
  @override
  Character mapFromOriginalObject(CharacterResponse originalObject) {
    return Character(
      name: originalObject.name,
      image: originalObject.image,
    );
  }
}
