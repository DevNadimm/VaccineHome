class ApiEndpoints {
  String get baseUrl => 'https://vcard.vaccinehomebd.com/';
  String get apiBaseUrl => 'https://vcard.vaccinehomebd.com/api/';

  // 📦 Auth
  String get registerUser => 'register';
  String get loginUser => 'login';
  String get editProfile => 'profile';

  // 📦 Reminders
  String get addConsultation => 'doctor-consultation-reminder/store';
  String get myConsultations => 'doctor-consultation-reminders';
  String get addMedication => '';
  String get myMedications => '';
  String get addTest => '';
  String get myTests => '';
}
