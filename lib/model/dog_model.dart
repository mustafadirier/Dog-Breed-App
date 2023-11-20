import 'dart:convert';
import 'package:dog_breed_app/model/breed_model.dart';

class DogModel {
  final List<BreedModel>? breeds;

  DogModel({
    this.breeds,
  });

  DogModel copyWith({
    List<BreedModel>? breeds,
  }) =>
      DogModel(
        breeds: breeds ?? this.breeds,
      );

  factory DogModel.fromRawJson(String str) =>
      DogModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
        breeds: json["breeds"] == null
            ? []
            : List<BreedModel>.from(
                json["breeds"].map((x) => BreedModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "breeds": breeds == null
            ? []
            : List<dynamic>.from(breeds!.map((x) => x.toJson())),
      };
}
