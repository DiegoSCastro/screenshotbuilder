// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:screenshotbuilder/core/dependency_injection/modules/dio_module.dart'
    as _i288;
import 'package:screenshotbuilder/core/network/network_client.dart' as _i97;
import 'package:screenshotbuilder/features/sample/data/data_sources/sample_datasource.dart'
    as _i923;
import 'package:screenshotbuilder/features/sample/data/repositories_impl/sample_repository_impl.dart'
    as _i386;
import 'package:screenshotbuilder/features/sample/domain/repositories/sample_repository.dart'
    as _i188;
import 'package:screenshotbuilder/features/sample/domain/usecases/get_cli_details_usecase.dart'
    as _i622;
import 'package:screenshotbuilder/features/sample/domain/usecases/get_user_usecase.dart'
    as _i780;
import 'package:screenshotbuilder/features/sample/presentation/blocs/sample_bloc/sample_bloc.dart'
    as _i686;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dioInstance);
    gh.lazySingleton<_i97.NetworkClient>(
      () => _i97.NetworkClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i923.SampleDataSource>(
      () => _i923.SampleDataSourceImpl(gh<_i97.NetworkClient>()),
    );
    gh.lazySingleton<_i188.SampleRepository>(
      () => _i386.SampleRepositoryImpl(gh<_i923.SampleDataSource>()),
    );
    gh.lazySingleton<_i622.GetCliDetailsUseCase>(
      () => _i622.GetCliDetailsUseCase(gh<_i188.SampleRepository>()),
    );
    gh.lazySingleton<_i780.GetUserUseCase>(
      () => _i780.GetUserUseCase(gh<_i188.SampleRepository>()),
    );
    gh.factory<_i686.SampleBloc>(
      () => _i686.SampleBloc(
        gh<_i780.GetUserUseCase>(),
        gh<_i622.GetCliDetailsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
