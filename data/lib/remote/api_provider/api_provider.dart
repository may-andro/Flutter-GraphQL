
import 'package:common/exceptions/exceptions.dart';
import 'package:data/model/character_response.dart';
import 'package:graphql/client.dart';

import 'graphql_queries.dart';

abstract class ApiProvider {
  Future<CharacterResponse> getCharacter(String name);
}

class GraphQLApiProvider extends ApiProvider {
  final GraphQLClient graphQLClient;

  GraphQLApiProvider({required this.graphQLClient});

  @override
  Future<CharacterResponse> getCharacter(String name) async {
    final QueryOptions queryOptions = QueryOptions(
      document: gql(searchCharacter),
      variables: {'character': name},
    );
    final QueryResult result = await graphQLClient.query(queryOptions);
    if (result.hasException) {
      throw ServerFailureException();
    }
    if (result.data != null) {
	    return CharacterResponse.fromJson(result.data!);
    }
	throw EmptyResponseException();
  }
}
