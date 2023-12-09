// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FarmerModule {
  final String name;
  final String emailAddress;
  final String SeelingAddress;
  final String FarmerUid;
  final String PhoneNumber;
  final String ProfilePic;
  final String upiId;
  final String Farmerlati;
  final String FarmerLogi;
  FarmerModule({
    required this.name,
    required this.emailAddress,
    required this.SeelingAddress,
    required this.FarmerUid,
    required this.PhoneNumber,
    required this.ProfilePic,
    required this.upiId,
    required this.Farmerlati,
    required this.FarmerLogi,
  });

  FarmerModule copyWith({
    String? name,
    String? emailAddress,
    String? SeelingAddress,
    String? FarmerUid,
    String? PhoneNumber,
    String? ProfilePic,
    String? upiId,
    String? Farmerlati,
    String? FarmerLogi,
  }) {
    return FarmerModule(
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      SeelingAddress: SeelingAddress ?? this.SeelingAddress,
      FarmerUid: FarmerUid ?? this.FarmerUid,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      ProfilePic: ProfilePic ?? this.ProfilePic,
      upiId: upiId ?? this.upiId,
      Farmerlati: Farmerlati ?? this.Farmerlati,
      FarmerLogi: FarmerLogi ?? this.FarmerLogi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'emailAddress': emailAddress,
      'SeelingAddress': SeelingAddress,
      'FarmerUid': FarmerUid,
      'PhoneNumber': PhoneNumber,
      'ProfilePic': ProfilePic,
      'upiId': upiId,
      'Farmerlati': Farmerlati,
      'FarmerLogi': FarmerLogi,
    };
  }

  factory FarmerModule.fromMap(Map<String, dynamic> map) {
    return FarmerModule(
      name: map['name'] as String,
      emailAddress: map['emailAddress'] as String,
      SeelingAddress: map['SeelingAddress'] as String,
      FarmerUid: map['FarmerUid'] as String,
      PhoneNumber: map['PhoneNumber'] as String,
      ProfilePic: map['ProfilePic'] as String,
      upiId: map['upiId'] as String,
      Farmerlati: map['Farmerlati'] as String,
      FarmerLogi: map['FarmerLogi'] as String,
    );
  }

  @override
  String toString() {
    return 'FarmerModule(name: $name, emailAddress: $emailAddress, SeelingAddress: $SeelingAddress, FarmerUid: $FarmerUid, PhoneNumber: $PhoneNumber, ProfilePic: $ProfilePic, upiId: $upiId, Farmerlati: $Farmerlati, FarmerLogi: $FarmerLogi)';
  }

  @override
  bool operator ==(covariant FarmerModule other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.emailAddress == emailAddress &&
        other.SeelingAddress == SeelingAddress &&
        other.FarmerUid == FarmerUid &&
        other.PhoneNumber == PhoneNumber &&
        other.ProfilePic == ProfilePic &&
        other.upiId == upiId &&
        other.Farmerlati == Farmerlati &&
        other.FarmerLogi == FarmerLogi;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        emailAddress.hashCode ^
        SeelingAddress.hashCode ^
        FarmerUid.hashCode ^
        PhoneNumber.hashCode ^
        ProfilePic.hashCode ^
        upiId.hashCode ^
        Farmerlati.hashCode ^
        FarmerLogi.hashCode;
  }
}
