import 'package:equatable/equatable.dart';
import 'package:story_genre_repository/story_genre_repository.dart';

class StoryGenresEvent extends Equatable {
  const StoryGenresEvent();

  @override
  List<Object> get props => [];
}

class LoadStoryGenres extends StoryGenresEvent {}

class AddStoryGenre extends StoryGenresEvent {
  final StoryGenre storyGenre;

  const AddStoryGenre(this.storyGenre);

  @override
  List<Object> get props => [storyGenre];

  @override
  String toString() => 'AddStoryGenre { storyGenre: $storyGenre }';
}

class UpdateStoryGenre extends StoryGenresEvent {
  final StoryGenre updatedStoryGenre;

  const UpdateStoryGenre(this.updatedStoryGenre);

  @override
  List<Object> get props => [updatedStoryGenre];

  @override
  String toString() => 'UpdateStoryGenre { updatedStoryGenre: $updatedStoryGenre }';
}

class DeleteStoryGenre extends StoryGenresEvent {
  final StoryGenre storyGenre;

  const DeleteStoryGenre(this.storyGenre);

  @override
  List<Object> get props => [storyGenre];

  @override
  String toString() => 'DeleteStoryGenre { storyGenre: $storyGenre }';
}


class StoryGenresUpdated extends StoryGenresEvent {
  final List<StoryGenre> storyGenres;

  const StoryGenresUpdated(this.storyGenres);

  @override
  List<Object> get props => [storyGenres];
}