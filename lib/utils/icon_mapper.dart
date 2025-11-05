import 'package:flutter/material.dart';

IconData getIconFromString(String? iconName) {
  switch (iconName) {
    case 'phone_android':
      return Icons.phone_android;
    case 'bolt':
      return Icons.bolt;
    case 'gas_meter':
      return Icons.gas_meter;
    case 'water_drop':
      return Icons.water_drop;
    case 'wifi':
      return Icons.wifi;
    case 'computer':
      return Icons.computer;
    case 'security':
      return Icons.security;
    case 'airplane_ticket':
      return Icons.airplane_ticket;
    case 'shopping_cart':
      return Icons.shopping_cart;
    case 'health_and_safety':
      return Icons.health_and_safety;
    default:
      return Icons.apps; // fallback icon
  }
}
