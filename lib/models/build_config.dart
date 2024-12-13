import 'package:myapp/models/pc_part.dart';
import 'package:flutter/material.dart';

class BuildConfig {
  final String id;
  final String userId;
  final List<PCPart> parts;
  final double totalPrice;

  BuildConfig({
    required this.id,
    required this.userId,
    required this.parts,
    required this.totalPrice,
  });

  // Convert JSON to BuildConfig object
  factory BuildConfig.fromJson(Map<String, dynamic> json) {
    return BuildConfig(
      id: json['_id'],
      userId: json['userId'],
      parts:
          (json['parts'] as List).map((part) => PCPart.fromJson(part)).toList(),
      totalPrice: json['totalPrice'],
    );
  }

  // Convert BuildConfig object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'parts': parts.map((part) => part.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }
}

void navigateToBuildSummary(BuildContext context, BuildConfig yourBuildConfig) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BuildSummaryScreen(buildConfig: yourBuildConfig),
    ),
  );
}
