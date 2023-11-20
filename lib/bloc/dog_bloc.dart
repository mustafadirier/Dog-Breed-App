import 'package:bloc/bloc.dart';
import 'package:dog_breed_app/event/dog_event.dart';
import 'package:dog_breed_app/model/breed_model.dart';
import 'package:dog_breed_app/repository/dog_repository.dart';

import '../state/dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final DogRepository dogRepository;

  List<BreedModel> initialBreeds = [];
  List<BreedModel> breeds = [];

  DogBloc({required this.dogRepository}) : super(DogStateInitial(breeds: [])) {
    on<GetBreedsEvent>(_onGetBreedsEvent);
    on<SearchBreedEvent>(_onSearchBreedEvent);
  }

  void _onGetBreedsEvent(GetBreedsEvent event, Emitter<DogState> emit) async {
    try {
      final allBreeds = await dogRepository.getBreeds();

      breeds = await Future.wait(allBreeds.entries.map((entry) async {
        String breed = entry.key;
        List<String> subBreeds = entry.value;

        String imageUrl = await dogRepository.getRandomImageByBreed(breed);

        BreedModel _breed =
            BreedModel(name: breed, subBreeds: subBreeds, image: imageUrl);

        return _breed;
      }));

      initialBreeds = breeds;

      emit(DogStateUpdated(breeds: breeds));
    } catch (e) {
      print("Error - GetBreedsEvent: $e");
      emit(DogStateUpdated(breeds: List.empty()));
    }
  }

  void _onSearchBreedEvent(
      SearchBreedEvent event, Emitter<DogState> emit) async {
    String query = event.query;
    List<BreedModel> breeds = [];

    if (query.isEmpty) {
      breeds = initialBreeds;
    } else {
      breeds = initialBreeds.where((breed) {
        return breed.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(DogStateUpdated(breeds: breeds));
  }
}
