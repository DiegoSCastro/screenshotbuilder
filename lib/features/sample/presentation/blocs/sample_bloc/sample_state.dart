part of 'sample_bloc.dart';

@freezed
sealed class SampleState with _$SampleState {
  const factory SampleState({
    @Default(false) bool isUserLoading,
    String? userError,
    UserEntity? userResponse,
    @Default(false) bool isCliLoading,
    String? cliError,
    CliDetailsEntity? cliDetails,
  }) = _Initial;

  factory SampleState.initial() => const SampleState();
}
