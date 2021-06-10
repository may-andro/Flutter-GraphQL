import 'package:domain/entity/character.dart';
import 'package:domain/usecase/get_character_usecase.dart';
import 'package:domain/utils/result_state/result.dart';
import 'package:flutter_graphql/presentation/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchCharacterBloc extends BlocBase {
  final GetCharacterUseCase getCharacterUseCase;

  SearchCharacterBloc({required this.getCharacterUseCase});

  final _characterSubject = PublishSubject<Result<Character>>();

  Stream<Result<Character>> get characterStream => _characterSubject.stream;

  Sink<Result<Character>> get characterSink => _characterSubject.sink;

  final _characters = <Character>[];

  searchCharacter(String name) async {
    characterSink.add(Loading());
    final Result<Character> result = await getCharacterUseCase(GetCharacterParam(name: name));
    if(result is Success) _characters.add((result as Success).data);
    characterSink.add(result);
  }

  getCachedList() => _characters;

  @override
  void dispose() {
    _characterSubject.close();
  }
}
