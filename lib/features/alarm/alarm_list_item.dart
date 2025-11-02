import 'package:flutter/material.dart';

class AlarmListItem extends StatefulWidget {
  final String time;
  final String trigger;
  final String recurrence;
  final bool isActive;

  const AlarmListItem({
    super.key,
    required this.time,
    required this.trigger,
    required this.recurrence,
    required this.isActive,
  });

  @override
  State<AlarmListItem> createState() => _AlarmListItemState();
}

class _AlarmListItemState extends State<AlarmListItem> {
  late bool _currentIsActive;

  @override
  void initState() {
    super.initState();
    _currentIsActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    // Determine card color based on active state
    Color cardColor = _currentIsActive
        ? Colors.white // Active: light background
        : Colors.grey.withOpacity(0.1); // Inactive: very light gray

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: _currentIsActive
              ? Colors.deepPurple.withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _currentIsActive ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.trigger,
                    style: TextStyle(
                      fontSize: 16,
                      color: _currentIsActive ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.recurrence,
                    style: TextStyle(
                      fontSize: 14,
                      color: _currentIsActive ? Colors.deepPurple : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Toggle Switch
            Switch(
              value: _currentIsActive,
              onChanged: (bool newValue) {
                setState(() {
                  _currentIsActive = newValue;
                });
                // Logic to update the alarm status in the app state/database goes here
              },
              activeColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}