enum Flavor {
  dev,
  prod;

  @override
  String toString() => name;
}

class FlavorConfig {
  final String baseUrl;

  final Flavor flavor;

  FlavorConfig({required this.baseUrl, required this.flavor});

  static FlavorConfig? _instance;

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.dev,
        );
        break;

      case Flavor.prod:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.prod,
        );
        break;
    }
  }

  static FlavorConfig get instance {
    _instance ??= FlavorConfig(
      baseUrl: "https://easy-init-demo-api.vercel.app",
      flavor: Flavor.dev,
    );
    return _instance!;
  }
}
