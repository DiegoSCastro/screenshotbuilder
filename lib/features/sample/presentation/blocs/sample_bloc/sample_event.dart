part of 'sample_bloc.dart';

@freezed
class SampleEvent with _$SampleEvent {
  const factory SampleEvent.started() = _Started;
  const factory SampleEvent.getUser(String username) = _GetUser;
  const factory SampleEvent.getCliDetails() = _GetCliDetails;
  const factory SampleEvent.clearUserResponse() = _ClearUserResponse;
}
