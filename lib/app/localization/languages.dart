final List<LanguageModel> languages = [
  LanguageModel("English", "en"),
  LanguageModel("Hindi", "hi"),
  LanguageModel("Bengali", "bn"),
  LanguageModel("Telugu", "te"),
  LanguageModel("Urdu", "ur"),
  LanguageModel("Tamil", "ta"),
  LanguageModel("Spanish", "es"),
  LanguageModel("Marathi", "mr"),
  LanguageModel("Russian", "ru"),
  LanguageModel("French", "fr"),
];

class LanguageModel {
  LanguageModel(
      this.language,
      this.symbol,
      );

  String language;
  String symbol;
}