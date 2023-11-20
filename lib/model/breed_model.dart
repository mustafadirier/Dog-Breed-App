import 'dart:convert';

class BreedModel {
  String? name;
  List<dynamic>? subBreeds;
  String? image;

  BreedModel({
    this.name,
    this.subBreeds,
    this.image,
  });
  BreedModel copyWith({
    String? name,
    List<dynamic>? subBreeds,
    String? image,
  }) =>
      BreedModel(
        name: name ?? this.name,
        subBreeds: subBreeds ?? this.subBreeds,
        image: image ?? this.image,
      );

  factory BreedModel.fromRawJson(String str) =>
      BreedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      name: json["name"],
      subBreeds: json["subBreeds"] == null
          ? []
          : List<dynamic>.from(json["subBreeds"].map((x) => x)),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "subBreeds": subBreeds == null
            ? []
            : List<dynamic>.from(subBreeds!.map((x) => x)),
        "image": image,
      };
}
