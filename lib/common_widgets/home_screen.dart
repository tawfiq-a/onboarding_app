import 'package:flutter/material.dart';

import '../features/alarm/alarm_list_item.dart';
import '../helpers/location_card.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      // Floating Action Button for adding a new alarm
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple, // Use your accent color
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // 1. Selected Location Overview Card
          const LocationCard(
            locationName: 'Work',
            address: '123 Main St, New York',
            status: 'Next alarm is in 2 hours',
          ),

          const SizedBox(height: 30),

          // 2. Alarms Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alarms',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // The Add button functionality is handled by the FAB,
              // but a title button could be here instead if preferred.
            ],
          ),

          const SizedBox(height: 15),

          // 3. Alarm List (using sample data)
          const AlarmListItem(
            time: '9:00 AM',
            trigger: 'Arriving at Home',
            recurrence: 'Mon, Tue, Wed, Thu, Fri',
            isActive: true,
          ),
          const AlarmListItem(
            time: '7:30 PM',
            trigger: 'Exiting the Office',
            recurrence: 'Every Day',
            isActive: true,
          ),
          const AlarmListItem(
            time: '11:00 AM',
            trigger: 'Arriving at Gym',
            recurrence: 'Sat, Sun',
            isActive: false,
          ),
        ],
      ),

      // 4. Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 'Home' is selected
        selectedItemColor: Colors.deepPurple, // Use your primary color
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}