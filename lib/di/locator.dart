import 'package:common/constants/network_constants.dart';
import 'package:common/network/connectivity_manager.dart';
import 'package:data/mapper/character_response_entity_mapper.dart';
import 'package:data/remote/api_provider/api_provider.dart';
import 'package:data/remote/datasource/remote_data_source.dart';
import 'package:data/repository/character_repository_impl.dart';
import 'package:domain/repository/character_repository.dart';
import 'package:domain/usecase/get_character_usecase.dart';
import 'package:flutter_graphql/presentation/feature/search_character/bloc/SearchCharacterBloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

final getIt = GetIt.instance;

void initialiseDI() {
  _provideGraphQlClient();

  getIt.registerSingleton<CharacterResponseEntityMapper>(CharacterResponseEntityMapper());

  getIt.registerSingleton<ConnectivityManager>(ConnectivityManagerImpl());

  getIt.registerSingleton<ApiProvider>(GraphQLApiProvider(graphQLClient: getIt()));

  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(apiProvider: getIt<ApiProvider>()));

  getIt.registerSingleton<CharacterRepository>(CharacterRepositoryImpl(
    remoteDataSource: getIt<RemoteDataSource>(),
    connectivityManager: getIt<ConnectivityManager>(),
    characterResponseEntityMapper: getIt<CharacterResponseEntityMapper>(),
  ));

  getIt.registerSingleton<GetCharacterUseCase>(GetCharacterUseCase(repository: getIt<CharacterRepository>()));

  getIt.registerFactory(() => SearchCharacterBloc(getCharacterUseCase: getIt<GetCharacterUseCase>()));
}

_provideGraphQlClient() {
  final _httpLink = HttpLink(BASE_URL);

  final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: _httpLink,
  );

  getIt.registerSingleton<GraphQLClient>(_client);
}
