
import 'package:common/exceptions/exceptions.dart';
import 'package:data/model/character_response.dart';
import 'package:data/remote/api_provider/api_provider.dart';

abstract class RemoteDataSource {
  Future<CharacterResponse> getCharacter(String name);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiProvider apiProvider;

  RemoteDataSourceImpl({required this.apiProvider});

  @override
  Future<CharacterResponse> getCharacter(String name) {
    try {
      return apiProvider.getCharacter(name);
    } catch (e) {
      throw ServerFailureException();
    }
  }
}
