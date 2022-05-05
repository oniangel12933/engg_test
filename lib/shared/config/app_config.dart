class AppConfig {
  static AppConfig? _instance;

  factory AppConfig() => _instance ??= AppConfig._();

  AppConfig._();

  Future<void> setup() async {}

  String get baseUrl {
    return 'https://api-qa-demo.nimbleandsimple.com/';
  }
}
