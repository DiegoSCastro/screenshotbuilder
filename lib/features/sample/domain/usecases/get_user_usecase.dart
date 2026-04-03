import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/sample_repository.dart';

@lazySingleton
@injectable
class GetUserUseCase implements UseCase<UserEntity, String> {
  final SampleRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await repository.getUser(params);
  }
}
