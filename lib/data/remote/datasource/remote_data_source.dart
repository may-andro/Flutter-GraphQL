
import 'package:flutter_graphql/core/exceptions/exceptions.dart';
import 'package:flutter_graphql/data/model/character_response.dart';
import 'package:flutter_graphql/data/remote/api_provider/api_provider.dart';

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
