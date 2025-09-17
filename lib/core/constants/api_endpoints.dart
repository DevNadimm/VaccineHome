class ApiEndpoints {
  String get baseUrl => 'https://vcard.vaccinehomebd.com/';
  String get apiBaseUrl => 'https://vcard.vaccinehomebd.com/api/';

  // 📦 Auth
  String get registerUser => 'register';

  // 📦 Reminders
  String get addMedication => '${apiBaseUrl}pathology-reminder/store';
  String get addConsultation => '${apiBaseUrl}doctor-consultation-reminder/store';
  String get addTest => '${apiBaseUrl}medication-test-reminder/store';
}
