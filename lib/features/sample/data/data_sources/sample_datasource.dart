import 'package:injectable/injectable.dart';

import '../models/cli_details_model.dart';
import '../models/user_model.dart';

abstract class SampleDataSource {
  Future<UserModel> getUser(UserRequest request);
  Future<CliDetailsModel> getCliDetails();
}

/// Offline demo responses (no HTTP client).
@LazySingleton(as: SampleDataSource)
@injectable
class SampleDataSourceImpl implements SampleDataSource {
  SampleDataSourceImpl();

  @override
  Future<UserModel> getUser(UserRequest request) async {
    final name = request.username?.trim();
    return UserModel.fromJson({
      'message': name != null && name.isNotEmpty
          ? 'Hello, $name (demo — no network)'
          : 'Hello (demo — no network)',
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'status': 'ok',
      'serverInfo': {'platform': 'demo', 'uptime': 0.0},
    });
  }

  @override
  Future<CliDetailsModel> getCliDetails() async {
    return CliDetailsModel.fromJson({
      'name': 'screenshot_builder',
      'latestVersion': '1.0.0',
      'description': 'Demo CLI details (app has no remote API).',
      'homepage': '',
      'fetchedAt': DateTime.now().toUtc().toIso8601String(),
    });
  }
}
