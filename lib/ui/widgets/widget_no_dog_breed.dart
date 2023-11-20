import 'package:dog_breed_app/ui/shared/uicolor.dart';
import 'package:flutter/material.dart';

Widget noDogBreedPage() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "No results found",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Try searching with another word",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: UIColor.secondartColor.withOpacity(.6),
          ),
        ),
      ],
    ),
  );
}
