import 'package:domain/entity/character.dart';
import 'package:domain/utils/result_state/result.dart';

abstract class CharacterRepository {
  Future<Result<Character>> getCharacter(String name);
}
