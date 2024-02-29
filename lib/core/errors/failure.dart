
import 'package:equatable/equatable.dart';
import 'package:online_learning/core/errors/exception.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  const Failure({required this.message, required this.statusCode});

  String getMessage() => '$statusCode Error: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}