import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_usecase/base_usecase.dart';
import '../../../../../core/failures/failures.dart';
import '../../../domain/entities/cli_details_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_cli_details_usecase.dart';
import '../../../domain/usecases/get_user_usecase.dart';

part 'sample_event.dart';
part 'sample_state.dart';
part 'sample_bloc.freezed.dart';

@injectable
class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final GetUserUseCase getUserUseCase;
  final GetCliDetailsUseCase getCliDetailsUseCase;

  SampleBloc(this.getUserUseCase, this.getCliDetailsUseCase)
    : super(SampleState.initial()) {
    on<_GetUser>((event, emit) async {
      emit(state.copyWith(isUserLoading: true, userError: null));
      final result = await getUserUseCase(event.username);
      result.fold(
        (failure) => emit(
          state.copyWith(
            isUserLoading: false,
            userError: failure.map(apiRequestFailure: (e) => e.error),
          ),
        ),
        (success) =>
            emit(state.copyWith(isUserLoading: false, userResponse: success)),
      );
    });

    on<_GetCliDetails>((event, emit) async {
      emit(state.copyWith(isCliLoading: true, cliError: null));
      final result = await getCliDetailsUseCase(NoParams());
      result.fold(
        (failure) => emit(
          state.copyWith(
            isCliLoading: false,
            cliError: failure.map(apiRequestFailure: (e) => e.error),
          ),
        ),
        (success) =>
            emit(state.copyWith(isCliLoading: false, cliDetails: success)),
      );
    });

    on<_ClearUserResponse>((event, emit) {
      emit(state.copyWith(userResponse: null));
    });
  }
}
