class PatientsModel {
  final int? status;
  final List<Patient>? data;

  PatientsModel({
    this.status,
    this.data,
  });

  factory PatientsModel.fromJson(Map<String, dynamic> json) {
    return PatientsModel(
      status: json['status'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Patient.fromJson(e))
          .toList(),
    );
  }
}

/// Patient model
class Patient {
  final int? id;
  final String? userId;
  final String? uhid;
  final String? firstNameEnglish;
  final String? lastNameEnglish;
  final String? gender;
  final String? birthDate;
  final String? father;
  final String? mother;
  final String? passportNo;
  final String? birthCertificateNumber;
  final String? presentNationality;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? whatsappImo;
  final String? createdAt;
  final String? updatedAt;
  final List<VaccinationCard>? vaccinationCard;

  Patient({
    this.id,
    this.userId,
    this.uhid,
    this.firstNameEnglish,
    this.lastNameEnglish,
    this.gender,
    this.birthDate,
    this.father,
    this.mother,
    this.passportNo,
    this.birthCertificateNumber,
    this.presentNationality,
    this.address,
    this.email,
    this.phoneNumber,
    this.whatsappImo,
    this.createdAt,
    this.updatedAt,
    this.vaccinationCard,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      userId: json['user_id'],
      uhid: json['uhid'],
      firstNameEnglish: json['first_name_english'],
      lastNameEnglish: json['last_name_english'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      father: json['father'],
      mother: json['mother'],
      passportNo: json['passport_no'],
      birthCertificateNumber: json['birth_certificate_number'],
      presentNationality: json['present_nationality'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      whatsappImo: json['whatsapp_imo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      vaccinationCard: (json['vaccinations'] as List<dynamic>?)
          ?.map((e) => VaccinationCard.fromJson(e))
          .toList(),
    );
  }
}

class VaccinationCard {
  final int? id;
  final String? patientId;
  final String? vaccineName;
  final String? approxAge;
  final String? vaccinationDate;
  final String? dueDate;
  final String? route;
  final String? dose;
  final String? remarks;
  final String? createdAt;
  final String? updatedAt;

  VaccinationCard({
    this.id,
    this.patientId,
    this.vaccineName,
    this.approxAge,
    this.vaccinationDate,
    this.dueDate,
    this.route,
    this.dose,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  factory VaccinationCard.fromJson(Map<String, dynamic> json) {
    return VaccinationCard(
      id: json['id'],
      patientId: json['patient_id'],
      vaccineName: json['vaccine_name'],
      approxAge: json['approx_age'],
      vaccinationDate: json['vaccination_date'],
      dueDate: json['due_date'],
      route: json['route'],
      dose: json['dose'],
      remarks: json['remarks'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
