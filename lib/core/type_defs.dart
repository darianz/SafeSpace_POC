import 'package:fpdart/fpdart.dart';
import 'package:safe_space_01/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef FuturVoid = Future<void>;
