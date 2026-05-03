abstract class EndPoints {
  static const String baseUrl = 'https://jrkmal-001-site1.jtempurl.com/api/';
  static const String login = 'Auth/login';
  static const String register = 'Auth/register';
  static const String refreshToken = 'Auth/refresh-token';
  static const String forgotPassword = 'Auth/forgot-password';
  static const String verifyEmail = 'Auth/verify-email';
  static const String verifyOtp = 'Auth/verify-reset-otp';
  static const String resendOtp = 'Auth/resend-otp';
  static const String resetPassword = 'Auth/reset-password';
  static const String getUserData = 'Auth/me';
  static const String startChat = 'Chat/start';
  static const String sendMessage = 'Chat/send';
  static const String updateProfile = 'Auth/profile';
  static const String deleteAccount = 'Auth/me';

  static const String getChatHistory = 'Chat/sessions';

  // Used Cars endpoints
  static const String addUsedCar = 'AddYourUsedCar';
  static const String getAllUsedCars = 'GetAllUsedCars';

  static String renameSession(String sessionId) => 'Chat/rename/$sessionId';
  static String removeSession(String sessionId) => 'Chat/$sessionId';
  static String fetchMessages(String sessionId) => 'Chat/history/$sessionId';
}
