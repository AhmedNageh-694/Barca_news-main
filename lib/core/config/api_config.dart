/// API configuration
///
/// IMPORTANT: In production, these values should be loaded from environment
/// variables or a secure configuration service. Never commit real API keys
/// to version control.
class ApiConfig {
  ApiConfig._();

  // NewsAPI configuration
  static const String newsApiKey = 'ae693838985d492ebc1de831211a4242';
  static const String newsApiBaseUrl = 'https://newsapi.org/v2';
  static const String newsApiLanguage = 'en';

  // SportsMonks API configuration (if needed in future)
  // static const String sportsMonksToken = 'your_token_here';
  // static const String sportsMonksBaseUrl = 'https://api.sportmonks.com/v3';
}
