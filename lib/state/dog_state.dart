
import 'package:dog_breed_app/model/breed_model.dart';

abstract class DogState {
  List<BreedModel> breeds;
  DogState({required this.breeds});
}

class DogStateInitial extends DogState {
  DogStateInitial({required List<BreedModel> breeds}) : super(breeds: breeds);
}

class DogStateUpdated extends DogState {
  DogStateUpdated({required List<BreedModel> breeds}) : super(breeds: breeds);
}
