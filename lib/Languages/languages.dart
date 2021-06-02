class ApplicationLanguages {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  ApplicationLanguages({this.id, this.name, this.flag, this.languageCode});

  static List<ApplicationLanguages> getLanguages() {
    return [
      ApplicationLanguages(
          id: 1, name: 'العربية', flag: '🇪🇬', languageCode: 'ar'),
      ApplicationLanguages(
          id: 2, name: 'English', flag: '🇺🇸', languageCode: 'en'),
    ];
  }
}
