
import 'package:flutter_graphql/core/model/result/result.dart';
import 'package:flutter_graphql/core/usecase/usecase.dart';
import 'package:flutter_graphql/domain/entity/character.dart';
import 'package:flutter_graphql/domain/repository/character_repository.dart';

class GetCharacterUseCase extends UseCase<GetCharacterParam, Character> {
  final CharacterRepository repository;

  GetCharacterUseCase({required this.repository});

  @override
  Future<Result<Character>> call(GetCharacterParam param) async {
    return await repository.getCharacter(param.name);
  }
}

class GetCharacterParam {
  final String name;

  GetCharacterParam({required this.name});
}
