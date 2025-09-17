class ApiEndpoints {
  String get baseUrl => 'https://vcard.vaccinehomebd.com/';
  String get apiBaseUrl => 'https://vcard.vaccinehomebd.com/api/';

  // 📦 Auth
  String get registerUser => 'register';
  String get loginUser => 'login';
  String get editProfile => 'profile';
  String get changePassword => 'change-password';

  // 📦 Reminders
  String get addConsultation => 'doctor-consultation-reminder/store';
  String get myConsultations => 'doctor-consultation-reminders';
  String get addMedication => 'medication-reminder/store';
  String get myMedications => 'medication-reminders';
  String get addTest => '';
  String get myTests => '';

  // Avatar
  String avatar(String path) => 'https://vcard.vaccinehomebd.com/storage/app/public/$path';
}
