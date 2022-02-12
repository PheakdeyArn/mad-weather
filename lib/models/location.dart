class Location {
  final String city;
  final String country;
  final String lat;
  final String lon;

  Location({
    required this.city,
    required this.country,
    required this.lat,
    required this.lon});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['name'],
      country: json['sys']['country'],
      lat: json['coord']['lat'].toString(),
      lon: json['coord']['lon'].toString(),
    );
  }

  factory Location.fromDjango(Map<String, dynamic> json) {
    return Location(
      city: json['name'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

}
