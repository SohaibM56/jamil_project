class AppUrls {
  const AppUrls._();

  static const hostingDomain = 'graduation.jamilcards.com';
  static String cardDisplayUrl(String cardId) => '$hostingDomain/#/$cardId';
  static String cardUrl(String cardId) => 'https://${cardDisplayUrl(cardId)}';
}
