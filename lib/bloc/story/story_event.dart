import 'package:equatable/equatable.dart';
import 'package:story_repository/story_repository.dart';

class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class LoadStory extends StoryEvent {}

class AddStory extends StoryEvent {
  final Story story;

  const AddStory(this.story);

  @override
  List<Object> get props => [story];

  @override
  String toString() => 'AddStory { story: $story }';
}

class UpdateStory extends StoryEvent {
  final Story updatedStory;

  const UpdateStory(this.updatedStory);

  @override
  List<Object> get props => [updatedStory];

  @override
  String toString() => 'UpdateStory { updatedStory: $updatedStory }';
}

class DeleteStory extends StoryEvent {
  final Story story;

  const DeleteStory(this.story);

  @override
  List<Object> get props => [story];

  @override
  String toString() => 'DeleteStory { deletedStory: $story }';
}

class StoryUpdated extends StoryEvent {
  final List<Story> stories;

  const StoryUpdated(this.stories);

  @override
  List<Object> get props => [stories];
}
