import 'package:dartz/dartz.dart';
import 'package:online_learning/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;