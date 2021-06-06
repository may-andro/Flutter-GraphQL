
import 'package:flutter_graphql/core/model/result/result.dart';
import 'package:flutter_graphql/domain/entity/character.dart';

abstract class CharacterRepository {
  Future<Result<Character>> getCharacter(String name);
}
