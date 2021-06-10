import 'package:domain/entity/character.dart';
import 'package:domain/repository/character_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/utils/result_state/result.dart';

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
