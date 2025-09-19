class ApiEndpoints {
  String get baseUrl => 'https://vcard.vaccinehomebd.com/';
  String get apiBaseUrl => 'https://vcard.vaccinehomebd.com/api/';

  // 📦 Auth
  String get registerUser => 'register';
  String get loginUser => 'login';
  String get editProfile => 'profile';
  String get changePassword => 'change-password';
  String get sendPin => 'forgot-password';
  String get verifyPin => 'verify-reset-pin';
  String get setNewPassword => 'reset-password';

  // 📦 Reminders
  String get addConsultation => 'doctor-consultation-reminder/store';
  String get myConsultations => 'doctor-consultation-reminders';
  String get addMedication => 'medication-reminder/store';
  String get myMedications => 'medication-reminders';
  String get addTest => 'medication-test-reminder/store';
  String get myTests => 'medication-test-reminders';

  // 📦 Profile
  String get getAdvertisements => 'advertisements';

  // 📦 Vaccine
  String get vaccineRequest => 'vaccine/products/order';
  String get products => 'vaccine/products';

  // 📦 Misc
  String get notifications => 'notifications';

  // 📦 Avatar
  String avatar(String path) => 'https://vcard.vaccinehomebd.com/storage/app/public/$path';
}
