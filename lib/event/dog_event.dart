
abstract class DogEvent {}

class GetBreedsEvent extends DogEvent {}

class SearchBreedEvent extends DogEvent {
  final String query;

  SearchBreedEvent({required this.query});
}
