import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/cli_details_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/sample_repository.dart';
import '../data_sources/sample_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: SampleRepository)
@injectable
class SampleRepositoryImpl implements SampleRepository {
  final SampleDataSource dataSource;

  SampleRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> getUser(String username) async {
    try {
      final request = UserRequest(username: username);
      final result = await dataSource.getUser(request);
      return Right(result);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    } catch (e) {
      return Left(Failure.apiRequestFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, CliDetailsEntity>> getCliDetails() async {
    try {
      final result = await dataSource.getCliDetails();
      return Right(result);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    } catch (e) {
      return Left(Failure.apiRequestFailure("Something went wrong"));
    }
  }
}
