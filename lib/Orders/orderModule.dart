// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:helping_hands/Farmer/Productmodule.dart';

class OrderModule {
  final ProductModule productModule;
  final String FarmerName;
  final String FarmerLogi;
  final String FarmerLati;
  final String FarmerId;
  final String ConsumerId;
  final String ConsumerName;
  final String ConsumerLogi;
  final String ConsumerLati;
  final String DileveryName;
  final String DileveryLati;
  final String DileveryLongi;
  final String DileveryId;
  final DateTime createdAt;
  final String OrderId;
  OrderModule({
    required this.productModule,
    required this.FarmerName,
    required this.FarmerLogi,
    required this.FarmerLati,
    required this.FarmerId,
    required this.ConsumerId,
    required this.ConsumerName,
    required this.ConsumerLogi,
    required this.ConsumerLati,
    required this.DileveryName,
    required this.DileveryLati,
    required this.DileveryLongi,
    required this.DileveryId,
    required this.createdAt,
    required this.OrderId,
  });

  OrderModule copyWith({
    ProductModule? productModule,
    String? FarmerName,
    String? FarmerLogi,
    String? FarmerLati,
    String? FarmerId,
    String? ConsumerId,
    String? ConsumerName,
    String? ConsumerLogi,
    String? ConsumerLati,
    String? DileveryName,
    String? DileveryLati,
    String? DileveryLongi,
    String? DileveryId,
    DateTime? createdAt,
    String? OrderId,
  }) {
    return OrderModule(
      productModule: productModule ?? this.productModule,
      FarmerName: FarmerName ?? this.FarmerName,
      FarmerLogi: FarmerLogi ?? this.FarmerLogi,
      FarmerLati: FarmerLati ?? this.FarmerLati,
      FarmerId: FarmerId ?? this.FarmerId,
      ConsumerId: ConsumerId ?? this.ConsumerId,
      ConsumerName: ConsumerName ?? this.ConsumerName,
      ConsumerLogi: ConsumerLogi ?? this.ConsumerLogi,
      ConsumerLati: ConsumerLati ?? this.ConsumerLati,
      DileveryName: DileveryName ?? this.DileveryName,
      DileveryLati: DileveryLati ?? this.DileveryLati,
      DileveryLongi: DileveryLongi ?? this.DileveryLongi,
      DileveryId: DileveryId ?? this.DileveryId,
      createdAt: createdAt ?? this.createdAt,
      OrderId: OrderId ?? this.OrderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productModule': productModule.toMap(),
      'FarmerName': FarmerName,
      'FarmerLogi': FarmerLogi,
      'FarmerLati': FarmerLati,
      'FarmerId': FarmerId,
      'ConsumerId': ConsumerId,
      'ConsumerName': ConsumerName,
      'ConsumerLogi': ConsumerLogi,
      'ConsumerLati': ConsumerLati,
      'DileveryName': DileveryName,
      'DileveryLati': DileveryLati,
      'DileveryLongi': DileveryLongi,
      'DileveryId': DileveryId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'OrderId': OrderId,
    };
  }

  factory OrderModule.fromMap(Map<String, dynamic> map) {
    return OrderModule(
      productModule:
          ProductModule.fromMap(map['productModule'] as Map<String, dynamic>),
      FarmerName: map['FarmerName'] as String,
      FarmerLogi: map['FarmerLogi'] as String,
      FarmerLati: map['FarmerLati'] as String,
      FarmerId: map['FarmerId'] as String,
      ConsumerId: map['ConsumerId'] as String,
      ConsumerName: map['ConsumerName'] as String,
      ConsumerLogi: map['ConsumerLogi'] as String,
      ConsumerLati: map['ConsumerLati'] as String,
      DileveryName: map['DileveryName'] as String,
      DileveryLati: map['DileveryLati'] as String,
      DileveryLongi: map['DileveryLongi'] as String,
      DileveryId: map['DileveryId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      OrderId: map['OrderId'] as String,
    );
  }

  @override
  String toString() {
    return 'OrderModule(productModule: $productModule, FarmerName: $FarmerName, FarmerLogi: $FarmerLogi, FarmerLati: $FarmerLati, FarmerId: $FarmerId, ConsumerId: $ConsumerId, ConsumerName: $ConsumerName, ConsumerLogi: $ConsumerLogi, ConsumerLati: $ConsumerLati, DileveryName: $DileveryName, DileveryLati: $DileveryLati, DileveryLongi: $DileveryLongi, DileveryId: $DileveryId, createdAt: $createdAt, OrderId: $OrderId)';
  }

  @override
  bool operator ==(covariant OrderModule other) {
    if (identical(this, other)) return true;

    return other.productModule == productModule &&
        other.FarmerName == FarmerName &&
        other.FarmerLogi == FarmerLogi &&
        other.FarmerLati == FarmerLati &&
        other.FarmerId == FarmerId &&
        other.ConsumerId == ConsumerId &&
        other.ConsumerName == ConsumerName &&
        other.ConsumerLogi == ConsumerLogi &&
        other.ConsumerLati == ConsumerLati &&
        other.DileveryName == DileveryName &&
        other.DileveryLati == DileveryLati &&
        other.DileveryLongi == DileveryLongi &&
        other.DileveryId == DileveryId &&
        other.createdAt == createdAt &&
        other.OrderId == OrderId;
  }

  @override
  int get hashCode {
    return productModule.hashCode ^
        FarmerName.hashCode ^
        FarmerLogi.hashCode ^
        FarmerLati.hashCode ^
        FarmerId.hashCode ^
        ConsumerId.hashCode ^
        ConsumerName.hashCode ^
        ConsumerLogi.hashCode ^
        ConsumerLati.hashCode ^
        DileveryName.hashCode ^
        DileveryLati.hashCode ^
        DileveryLongi.hashCode ^
        DileveryId.hashCode ^
        createdAt.hashCode ^
        OrderId.hashCode;
  }
}
