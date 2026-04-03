import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  factory Failure.apiRequestFailure(String error) = ApiRequestFailure;
}
