import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String locationName;
  final String address;
  final String status;

  const LocationCard({
    super.key,
    required this.locationName,
    required this.address,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1), // Subtle background color
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
        // Optional: Add a subtle shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.deepPurple, size: 30),
              const SizedBox(width: 10),
              Text(
                locationName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const Divider(height: 25, thickness: 1),
          Text(
            status,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}