import 'package:dog_breed_app/model/api_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DogRepository {
  Future<Map<String, List<String>>> getBreeds() async {
    final response =
        await http.get(Uri.parse('${dotenv.env['API_URL']}/breeds/list/all'));
    if (response.statusCode == 200) {
      ApiResponseModel data = ApiResponseModel.fromJsonString(response.body);

      if (data.status != "success") {
        throw Exception('Failed to load breeds');
      }

      Map<String, List<String>> breedsMap = Map.from(data.message)
          .map((key, value) => MapEntry(key, List<String>.from(value)));

      return breedsMap;
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  Future<String> getRandomImageByBreed(breed) async {
    final response = await http
        .get(Uri.parse('${dotenv.env['API_URL']}/breed/$breed/images/random'));
    if (response.statusCode == 200) {
      ApiResponseModel data = ApiResponseModel.fromJsonString(response.body);

      if (data.status != "success") {
        throw Exception('Failed to load random image');
      }

      return data.message;
    } else {
      throw Exception('Failed to load random image');
    }
  }
}
