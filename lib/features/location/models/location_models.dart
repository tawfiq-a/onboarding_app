

class UserLocation {
  final double latitude;
  final double longitude;
  final String address; // Address like: "New York, USA"

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  // Default initial location
  static UserLocation initial = UserLocation(
    latitude: 0.0,
    longitude: 0.0,
    address: "Location Not Selected",
  );
}