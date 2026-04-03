import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/cli_details_entity.dart';
import '../repositories/sample_repository.dart';

@lazySingleton
@injectable
class GetCliDetailsUseCase implements UseCase<CliDetailsEntity, NoParams> {
  final SampleRepository repository;

  GetCliDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, CliDetailsEntity>> call(NoParams params) async {
    return await repository.getCliDetails();
  }
}
