import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final double price;
  final bool isTotal;

  const PriceDisplay({
    super.key,
    required this.price,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isTotal ? 'Total Price:' : 'Price:',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 16,
          ),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 16,
            color: isTotal ? Theme.of(context).primaryColor : null,
          ),
        ),
      ],
    );
  }
} 