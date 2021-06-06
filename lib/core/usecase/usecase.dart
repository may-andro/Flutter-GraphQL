import 'package:flutter_graphql/core/model/result/result.dart';

abstract class UseCase<Param, T> {
	Future<Result<T>> call(Param param);
}