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
  String deleteConsultation(int id) => 'doctor-consultation-reminder/$id/delete';
  String updateConsultation(int id) => 'doctor-consultation-reminder/$id/update';
  String get addMedication => 'medication-reminder/store';
  String get myMedications => 'medication-reminders';
  String deleteMedication(int id) => 'medication-reminder/$id/delete';
  String updateMedication(int id) => 'medication-reminder/$id/update';
  String get addTest => 'medication-test-reminder/store';
  String get myTests => 'medication-test-reminders';
  String deleteTest(int id) => 'medication-test-reminder/$id/delete';
  String updateTest(int id) => 'medication-test-reminder/$id/update';
  String get addWaterReminder => 'water-reminder/store';
  String get myWaterReminders => 'water-reminders';
  String deleteWaterReminder(int id) => 'water-reminder/$id/delete';
  String updateWaterReminder(int id) => 'water-reminder/$id/update';
  String get addMealReminder => 'meal-reminder/store';
  String get myMealReminders => 'meal-reminders';
  String deleteMealReminder(int id) => 'meal-reminder/$id/delete';
  String updateMealReminder(int id) => 'meal-reminder/$id/update';
  final String addSleepReminder = "sleep-reminder/store";
  final String mySleepReminders = "sleep-reminders";
  String updateSleepReminder(int id) => "sleep-reminder/$id/update";
  String deleteSleepReminder(int id) => "sleep-reminder/$id/delete";

  // 📦 Profile
  String get getAdvertisements => 'advertisements';

  // 📦 Vaccine
  String get vaccineRequest => 'vaccine/products/order';
  String get products => 'vaccine/products';
  String get vaccineCardRequest => 'patients/store';
  String get bookVaccineAppointment => 'vaccine-appointment/store';

  // 📦 Misc
  String get notifications => 'notifications';
  String get readNotification => 'notifications/mark-as-read';
  String get deleteAllNotification => 'notifications/delete-all';
  String get mentalWellBeings => 'mental-well-beings';
  String get faqs => 'faqs';

  // 📦 Feedback
  String get feedbacks => 'feedbacks';

  // 📦 Avatar
  String avatar(String path) => 'https://vcard.vaccinehomebd.com/storage/app/public/$path';
}
