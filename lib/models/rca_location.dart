import 'package:flutter/foundation.dart';

class RcaLocation {
  final String locationID;
  final String name;
  final String address;
  final String piva;

  RcaLocation(
      {@required this.address,
      @required this.locationID,
      @required this.name,
      @required this.piva});

  @override
  String toString() {
    String result = "RcaLocation: \n" +
        this.piva +
        "\n" +
        this.locationID +
        "\n" +
        this.name +
        "\n" +
        this.address +
        "\n";
    return result;
  }

  static RcaLocation fromMap(Map<String, dynamic> map) {
    return new RcaLocation(
      address: map['address'],
      locationID: map['locationID'],
      name: map['name'],
      piva: map['piva'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'piva': piva,
      'locationID': locationID,
      'name': name,
      'address': address
    };
  }

  // Define that two Location are equals if locationID is
  bool operator ==(other) {
    return (other is RcaLocation && other.locationID == locationID);
  }

  @override
  int get hashCode => 31 * int.parse(locationID);
}
