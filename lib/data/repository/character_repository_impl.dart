
import 'package:flutter_graphql/core/model/result/result.dart';
import 'package:flutter_graphql/core/network/connectivity_manager.dart';
import 'package:flutter_graphql/data/mapper/character_response_entity_mapper.dart';
import 'package:flutter_graphql/data/remote/datasource/remote_data_source.dart';
import 'package:flutter_graphql/domain/entity/character.dart';
import 'package:flutter_graphql/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectivityManager connectivityManager;
  final CharacterResponseEntityMapper characterResponseEntityMapper;

  CharacterRepositoryImpl(
      {required this.remoteDataSource,
      required this.connectivityManager,
      required this.characterResponseEntityMapper});

  @override
  Future<Result<Character>> getCharacter(String name) {
    return _checkNetworkAvailability<Result<Character>>(
        doCacheCall: () => _getRemoteCharacter(name), doNetworkCall: () => _getRemoteCharacter(name));
  }

  Future<T> _checkNetworkAvailability<T>({required Future<T> doNetworkCall(), required Future<T> doCacheCall()}) {
    return connectivityManager.isConnected.then((isNetworkAvailable) {
      return isNetworkAvailable ? doNetworkCall() : doCacheCall();
    }, onError: (e) {
      Error(error: Exception());
    });
  }


  Future<Result<Character>> _getRemoteCharacter(String name) async {
    try {
      final characterResponse = await remoteDataSource.getCharacter(name);
      return Success(data: characterResponseEntityMapper.mapFromOriginalObject(characterResponse));
    } catch (exception) {
      return Error(error: Exception());
    }
  }
}
