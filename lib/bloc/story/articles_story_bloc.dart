import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_repository/story_repository.dart';

import 'stories.dart';

class ArticlesStoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepository _storyRepository;
  StreamSubscription? _storySubscription;

  ArticlesStoryBloc({required StoryRepository storyRepository})
      : _storyRepository = storyRepository,
        super(StoryLoading());

  @override
  Stream<StoryState> mapEventToState(StoryEvent event) async* {
    if (event is LoadStory) {
      yield* _mapLoadStoryToState();
    } else if (event is AddStory) {
      yield* _mapAddStoryToState(event);
    } else if (event is UpdateStory) {
      yield* _mapUpdateStoryToState(event);
    } else if (event is DeleteStory) {
      yield* _mapDeleteStoryToState(event);
    } else if (event is StoryUpdated) {
      yield* _mapStoryUpdateToState(event);
    }
  }

  Stream<StoryState> _mapLoadStoryToState() async* {
    _storySubscription?.cancel();
    _storySubscription = _storyRepository.stories().listen(
          (storyGenres) => add(StoryUpdated(storyGenres)),
        );
  }

  Stream<StoryState> _mapAddStoryToState(AddStory event) async* {
    //  _storyRepository.addNewStory(event.story);
  }

  Stream<StoryState> _mapUpdateStoryToState(UpdateStory event) async* {
    //_storyRepository.updateStoryGenre(event.updatedStory);
  }

  Stream<StoryState> _mapDeleteStoryToState(DeleteStory event) async* {
    // _storyRepository.deleteStoryGenre(event.story);
  }

  Stream<StoryState> _mapStoryUpdateToState(StoryUpdated event) async* {
    yield StoryLoaded(event.stories);
  }

  @override
  Future<void> close() {
    _storySubscription?.cancel();
    return super.close();
  }
}
