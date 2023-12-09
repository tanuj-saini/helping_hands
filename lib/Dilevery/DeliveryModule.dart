// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliveryModule {
  final String name;
  final String PhoneNumber;
  final String emailAddress;
  final String DeliveryUid;
  final String DeliveryProfilePic;
  final String DileveryLati;
  final String DileveryLongi;
  DeliveryModule({
    required this.name,
    required this.PhoneNumber,
    required this.emailAddress,
    required this.DeliveryUid,
    required this.DeliveryProfilePic,
    required this.DileveryLati,
    required this.DileveryLongi,
  });

  DeliveryModule copyWith({
    String? name,
    String? PhoneNumber,
    String? emailAddress,
    String? DeliveryUid,
    String? DeliveryProfilePic,
    String? DileveryLati,
    String? DileveryLongi,
  }) {
    return DeliveryModule(
      name: name ?? this.name,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      DeliveryUid: DeliveryUid ?? this.DeliveryUid,
      DeliveryProfilePic: DeliveryProfilePic ?? this.DeliveryProfilePic,
      DileveryLati: DileveryLati ?? this.DileveryLati,
      DileveryLongi: DileveryLongi ?? this.DileveryLongi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'PhoneNumber': PhoneNumber,
      'emailAddress': emailAddress,
      'DeliveryUid': DeliveryUid,
      'DeliveryProfilePic': DeliveryProfilePic,
      'DileveryLati': DileveryLati,
      'DileveryLongi': DileveryLongi,
    };
  }

  factory DeliveryModule.fromMap(Map<String, dynamic> map) {
    return DeliveryModule(
      name: map['name'] as String,
      PhoneNumber: map['PhoneNumber'] as String,
      emailAddress: map['emailAddress'] as String,
      DeliveryUid: map['DeliveryUid'] as String,
      DeliveryProfilePic: map['DeliveryProfilePic'] as String,
      DileveryLati: map['DileveryLati'] as String,
      DileveryLongi: map['DileveryLongi'] as String,
    );
  }

  @override
  String toString() {
    return 'DeliveryModule(name: $name, PhoneNumber: $PhoneNumber, emailAddress: $emailAddress, DeliveryUid: $DeliveryUid, DeliveryProfilePic: $DeliveryProfilePic, DileveryLati: $DileveryLati, DileveryLongi: $DileveryLongi)';
  }

  @override
  bool operator ==(covariant DeliveryModule other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.PhoneNumber == PhoneNumber &&
        other.emailAddress == emailAddress &&
        other.DeliveryUid == DeliveryUid &&
        other.DeliveryProfilePic == DeliveryProfilePic &&
        other.DileveryLati == DileveryLati &&
        other.DileveryLongi == DileveryLongi;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        PhoneNumber.hashCode ^
        emailAddress.hashCode ^
        DeliveryUid.hashCode ^
        DeliveryProfilePic.hashCode ^
        DileveryLati.hashCode ^
        DileveryLongi.hashCode;
  }
}
