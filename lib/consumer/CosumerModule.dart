// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConsumerModule {
  final String name;
  final String emailAddress;
  final String PhoneNumberl;
  final String Address;
  final String ConsumerId;
  final String ProfilePic;
  final String ConsumerLati;
  final String ConsumerLogi;
  ConsumerModule({
    required this.name,
    required this.emailAddress,
    required this.PhoneNumberl,
    required this.Address,
    required this.ConsumerId,
    required this.ProfilePic,
    required this.ConsumerLati,
    required this.ConsumerLogi,
  });

  ConsumerModule copyWith({
    String? name,
    String? emailAddress,
    String? PhoneNumberl,
    String? Address,
    String? ConsumerId,
    String? ProfilePic,
    String? ConsumerLati,
    String? ConsumerLogi,
  }) {
    return ConsumerModule(
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      PhoneNumberl: PhoneNumberl ?? this.PhoneNumberl,
      Address: Address ?? this.Address,
      ConsumerId: ConsumerId ?? this.ConsumerId,
      ProfilePic: ProfilePic ?? this.ProfilePic,
      ConsumerLati: ConsumerLati ?? this.ConsumerLati,
      ConsumerLogi: ConsumerLogi ?? this.ConsumerLogi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'emailAddress': emailAddress,
      'PhoneNumberl': PhoneNumberl,
      'Address': Address,
      'ConsumerId': ConsumerId,
      'ProfilePic': ProfilePic,
      'ConsumerLati': ConsumerLati,
      'ConsumerLogi': ConsumerLogi,
    };
  }

  factory ConsumerModule.fromMap(Map<String, dynamic> map) {
    return ConsumerModule(
      name: map['name'] as String,
      emailAddress: map['emailAddress'] as String,
      PhoneNumberl: map['PhoneNumberl'] as String,
      Address: map['Address'] as String,
      ConsumerId: map['ConsumerId'] as String,
      ProfilePic: map['ProfilePic'] as String,
      ConsumerLati: map['ConsumerLati'] as String,
      ConsumerLogi: map['ConsumerLogi'] as String,
    );
  }

  @override
  String toString() {
    return 'ConsumerModule(name: $name, emailAddress: $emailAddress, PhoneNumberl: $PhoneNumberl, Address: $Address, ConsumerId: $ConsumerId, ProfilePic: $ProfilePic, ConsumerLati: $ConsumerLati, ConsumerLogi: $ConsumerLogi)';
  }

  @override
  bool operator ==(covariant ConsumerModule other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.emailAddress == emailAddress &&
        other.PhoneNumberl == PhoneNumberl &&
        other.Address == Address &&
        other.ConsumerId == ConsumerId &&
        other.ProfilePic == ProfilePic &&
        other.ConsumerLati == ConsumerLati &&
        other.ConsumerLogi == ConsumerLogi;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        emailAddress.hashCode ^
        PhoneNumberl.hashCode ^
        Address.hashCode ^
        ConsumerId.hashCode ^
        ProfilePic.hashCode ^
        ConsumerLati.hashCode ^
        ConsumerLogi.hashCode;
  }
}
