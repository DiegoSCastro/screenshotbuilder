import 'app_runner.dart';
import 'core/config/flavor_config.dart';

Future<void> main(List<String> args) async {
  await runApplication(Flavor.dev);
}

