export 'pc_part.dart';

class PCPart {
  final String id;
  final String name;
  final String type;
  final double price;
  final Map<String, dynamic> specifications;

  PCPart({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.specifications,
  });

  double? get tdp => specifications['tdp'] as double?;

  factory PCPart.fromJson(Map<String, dynamic> json) {
    return PCPart(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      specifications: json['specifications'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'price': price,
    'specifications': specifications,
  };
}
