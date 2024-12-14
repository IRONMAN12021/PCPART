import 'package:myapp/models/pc_part.dart';
import 'package:flutter/material.dart';
//import 'package:myapp/screens/build/auto_build/auto_bild_summary_screen.dart';
import 'package:myapp/routes.dart';

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
      id: json['_id'] as String,
      userId: json['userId'] as String,
      parts: (json['parts'] as List)
          .map((part) => PCPart.fromJson(part as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
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
  Navigator.pushNamed(
    context, 
    Routes.autoBuildSummary,
    arguments: yourBuildConfig,
  );
}
