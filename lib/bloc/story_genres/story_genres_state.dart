import 'package:equatable/equatable.dart';
import 'package:story_genre_repository/story_genre_repository.dart';

abstract class StoryGenresState extends Equatable {
  const StoryGenresState();

  @override
  List<Object> get props => [];
}

class StoryGenresLoading extends StoryGenresState {}

class StoryGenresLoaded extends StoryGenresState {
  final List<StoryGenre> storyGenres;

  const StoryGenresLoaded([this.storyGenres = const []]);

  @override
  List<Object> get props => [storyGenres];

  @override
  String toString() => 'StoryGenresLoaded { storyGenres: $storyGenres }';
}

class StoryGenresNotLoaded extends StoryGenresState {}
