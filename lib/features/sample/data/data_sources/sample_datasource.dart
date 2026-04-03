import 'package:injectable/injectable.dart';
import '../../../../core/api_endpoints/api_endpoints.dart';
import '../../../../core/network/network_client.dart';
import '../models/cli_details_model.dart';
import '../models/user_model.dart';

abstract class SampleDataSource {
  Future<UserModel> getUser(UserRequest request);
  Future<CliDetailsModel> getCliDetails();
}

@LazySingleton(as: SampleDataSource)
@injectable
class SampleDataSourceImpl implements SampleDataSource {
  final NetworkClient client;

  SampleDataSourceImpl(this.client);

  @override
  Future<UserModel> getUser(UserRequest request) async {
    try {
      final response = await client.post(
        path: ApiEndpoints.users,
        data: request.toJson(),
        requiresAuth: false,
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CliDetailsModel> getCliDetails() async {
    try {
      final response = await client.get(
        path: ApiEndpoints.cliDetails,
        requiresAuth: false,
      );
      return CliDetailsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
