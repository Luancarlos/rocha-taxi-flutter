class Place {
  String name;
  String address;
  double lat;
  double lng;
  String icon;

  Place(this.name, this.address, this.lat, this.lng);

  static List<Place> fromJson(Map<String, dynamic> json) {
    print("parse data");
    List<Place> rs = new List();

    var results = json['results'] as List;
    for (var item in results) {
      var p = new Place(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);

      rs.add(p);
    }

    return rs;
  }

}