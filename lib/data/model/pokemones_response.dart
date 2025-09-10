class PokemonesResponse {
  final String name;
  final String url;
  final String? imageUrl;
  final String? imageGif;

  PokemonesResponse({required this.name, required this.url, this.imageUrl, required this.imageGif});

  factory PokemonesResponse.fromJson(Map<String, dynamic> json) {
    String? imgUrl;
    if (json.containsKey("sprites")) {
      imgUrl = json["sprites"]["front_default"];
    }

    String? imgGif;
    if (json.containsKey("sprites")) {
      imgGif = json["sprites"]["front_default"];
    }

    return PokemonesResponse(
      name: json["name"],
      url: json["url"],
      imageUrl: imgUrl,
      imageGif: imgGif,
    );
  }
}
