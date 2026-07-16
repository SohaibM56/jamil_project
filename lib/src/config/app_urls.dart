class AppUrls {
  const AppUrls._();

  static const hostingDomain = 'grad-project-d5f84.web.app';
  static String cardDisplayUrl(String cardId) => '$hostingDomain/#/$cardId';
  static String cardUrl(String cardId) => 'https://${cardDisplayUrl(cardId)}';
}
