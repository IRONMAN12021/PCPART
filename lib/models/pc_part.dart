class PCPart {
  final String id;
  final String item;
  final String name;
  final String category;
  final double price;
  final String brand;
  final String benchmarks;
  final String fps;
  final String type;
  final double? tdp;
   // TDP is nullable.

  // Constructor
  PCPart({
    required this.id,
    required this.item,
    required this.name,
    required this.category,
    required this.price,
    required this.brand,
    required this.benchmarks,
    required this.fps,
    required this.type,
    this.tdp,   // Optional parameter
  });

  // From JSON factory method
  factory PCPart.fromJson(Map<String, dynamic> json) {
    return PCPart(
      id: json['_id'],
      item: json['_item'], // Using correct key names for mapping
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),  // Ensuring price is a double
      brand: json['brand'],
      benchmarks: json['benchmarks'],
      fps: json['fps'],
      type: json['type'],
      tdp: json['tdp']? json['tdp'].toDouble() : null,  // Convert tdp to double if present
    );
  }

  // Getter for TDP (Thermal Design Power)
  double? get tdpValue => tdp;

  // Convert PCPart object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      '_item': item, // Using correct key names for mapping
      'name': name,
      'category': category,
      'price': price,
      'brand': brand,
      'benchmarks': benchmarks,
      'fps': fps,
      'type': type,
      'tdp': tdp,  // Include TDP if it's available
    };
  }
}
