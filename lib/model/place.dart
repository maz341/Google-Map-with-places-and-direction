class PlaceModel{

  int place_id;
  double lat, long, rating, distance;
  String image, title, description;

  PlaceModel(
      {this.place_id,
      this.lat,
      this.long,
      this.title,
      this.description,
      this.rating,
      this.distance,
      this.image});


  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    place_id: json["place_id"],
    lat: json["lat"],
    long: json["long"],
    rating: json["rating"],
    distance: json["distance"],
    description: json["description"],
    title: json["title"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "place_id": place_id,
    "lat": lat,
    "long": long,
    "rating": rating,
    "distance": distance,
    "description": description,
    "title": title,
    "image": image,
  };
  
}

