
import 'package:common/network/connectivity_manager.dart';
import 'package:data/mapper/character_response_entity_mapper.dart';
import 'package:data/remote/datasource/remote_data_source.dart';
import 'package:domain/entity/character.dart';
import 'package:domain/repository/character_repository.dart';
import 'package:domain/utils/result_state/result.dart';

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
