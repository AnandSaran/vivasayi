import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_genre_repository/story_genre_repository.dart';

import 'story_genres.dart';

class StoryGenresBloc extends Bloc<StoryGenresEvent, StoryGenresState> {
  final StoryGenreRepository _storyGenresRepository;
  StreamSubscription? _storyGenreSubscription;

  StoryGenresBloc({required StoryGenreRepository storyGenresRepository})
      : _storyGenresRepository = storyGenresRepository,
        super(StoryGenresLoading());

  @override
  Stream<StoryGenresState> mapEventToState(StoryGenresEvent event) async* {
    if (event is LoadStoryGenres) {
      yield* _mapLoadStoryGenresToState();
    } else if (event is AddStoryGenre) {
      yield* _mapAddStoryGenreToState(event);
    } else if (event is UpdateStoryGenre) {
      yield* _mapUpdateStoryGenreToState(event);
    } else if (event is DeleteStoryGenre) {
      yield* _mapDeleteStoryGenreToState(event);
    } else if (event is StoryGenresUpdated) {
      yield* _mapStoryGenresUpdateToState(event);
    }
  }

  Stream<StoryGenresState> _mapLoadStoryGenresToState() async* {
    _storyGenreSubscription?.cancel();
    _storyGenreSubscription = _storyGenresRepository.storyGenres().listen(
          (storyGenres) => add(StoryGenresUpdated(storyGenres)),
        );
  }

  Stream<StoryGenresState> _mapAddStoryGenreToState(
      AddStoryGenre event) async* {
    _storyGenresRepository.addNewStoryGenre(event.storyGenre);
  }

  Stream<StoryGenresState> _mapUpdateStoryGenreToState(
      UpdateStoryGenre event) async* {
    _storyGenresRepository.updateStoryGenre(event.updatedStoryGenre);
  }

  Stream<StoryGenresState> _mapDeleteStoryGenreToState(
      DeleteStoryGenre event) async* {
    _storyGenresRepository.deleteStoryGenre(event.storyGenre);
  }

  Stream<StoryGenresState> _mapStoryGenresUpdateToState(
      StoryGenresUpdated event) async* {
    yield StoryGenresLoaded(event.storyGenres);
  }

  @override
  Future<void> close() {
    _storyGenreSubscription?.cancel();
    return super.close();
  }
}
