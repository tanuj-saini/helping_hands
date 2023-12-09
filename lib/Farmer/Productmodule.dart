// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModule {
  final String productProfile;
  final String productName;
  final String PricePerKg;
  final String manufacutingDatel;
  final String bestBefore;
  final String ProductDetails;
  final String ProductId;
  final DateTime registerDate;
  ProductModule({
    required this.productProfile,
    required this.productName,
    required this.PricePerKg,
    required this.manufacutingDatel,
    required this.bestBefore,
    required this.ProductDetails,
    required this.ProductId,
    required this.registerDate,
  });

  ProductModule copyWith({
    String? productProfile,
    String? productName,
    String? PricePerKg,
    String? manufacutingDatel,
    String? bestBefore,
    String? ProductDetails,
    String? ProductId,
    DateTime? registerDate,
  }) {
    return ProductModule(
      productProfile: productProfile ?? this.productProfile,
      productName: productName ?? this.productName,
      PricePerKg: PricePerKg ?? this.PricePerKg,
      manufacutingDatel: manufacutingDatel ?? this.manufacutingDatel,
      bestBefore: bestBefore ?? this.bestBefore,
      ProductDetails: ProductDetails ?? this.ProductDetails,
      ProductId: ProductId ?? this.ProductId,
      registerDate: registerDate ?? this.registerDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productProfile': productProfile,
      'productName': productName,
      'PricePerKg': PricePerKg,
      'manufacutingDatel': manufacutingDatel,
      'bestBefore': bestBefore,
      'ProductDetails': ProductDetails,
      'ProductId': ProductId,
      'registerDate': registerDate.millisecondsSinceEpoch,
    };
  }

  factory ProductModule.fromMap(Map<String, dynamic> map) {
    return ProductModule(
      productProfile: map['productProfile'] as String,
      productName: map['productName'] as String,
      PricePerKg: map['PricePerKg'] as String,
      manufacutingDatel: map['manufacutingDatel'] as String,
      bestBefore: map['bestBefore'] as String,
      ProductDetails: map['ProductDetails'] as String,
      ProductId: map['ProductId'] as String,
      registerDate:
          DateTime.fromMillisecondsSinceEpoch(map['registerDate'] as int),
    );
  }

  @override
  String toString() {
    return 'ProductModule(productProfile: $productProfile, productName: $productName, PricePerKg: $PricePerKg, manufacutingDatel: $manufacutingDatel, bestBefore: $bestBefore, ProductDetails: $ProductDetails, ProductId: $ProductId, registerDate: $registerDate)';
  }

  @override
  bool operator ==(covariant ProductModule other) {
    if (identical(this, other)) return true;

    return other.productProfile == productProfile &&
        other.productName == productName &&
        other.PricePerKg == PricePerKg &&
        other.manufacutingDatel == manufacutingDatel &&
        other.bestBefore == bestBefore &&
        other.ProductDetails == ProductDetails &&
        other.ProductId == ProductId &&
        other.registerDate == registerDate;
  }

  @override
  int get hashCode {
    return productProfile.hashCode ^
        productName.hashCode ^
        PricePerKg.hashCode ^
        manufacutingDatel.hashCode ^
        bestBefore.hashCode ^
        ProductDetails.hashCode ^
        ProductId.hashCode ^
        registerDate.hashCode;
  }
}
