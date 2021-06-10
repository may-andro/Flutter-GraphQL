import 'package:common/mapper/entity_model_mapper.dart';
import 'package:data/model/character_response.dart';
import 'package:domain/entity/character.dart';

class CharacterResponseEntityMapper extends ObjectMapper<CharacterResponse, Character> {
  @override
  Character mapFromOriginalObject(CharacterResponse originalObject) {
    return Character(
      name: originalObject.name,
      image: originalObject.image,
    );
  }
}
