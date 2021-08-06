import 'package:equatable/equatable.dart';
import 'package:story_repository/story_repository.dart';

abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryLoading extends StoryState {}

class StoryLoaded extends StoryState {
  final List<Story> stories;

  const StoryLoaded([this.stories = const []]);

  @override
  List<Object> get props => [stories];

  @override
  String toString() => 'StoryLoaded { stories: $stories }';
}

class StoryNotLoaded extends StoryState {}
