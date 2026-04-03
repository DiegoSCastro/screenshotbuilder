import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../entities/cli_details_entity.dart';
import '../entities/user_entity.dart';

abstract class SampleRepository {
  Future<Either<Failure, UserEntity>> getUser(String username);
  Future<Either<Failure, CliDetailsEntity>> getCliDetails();
}
