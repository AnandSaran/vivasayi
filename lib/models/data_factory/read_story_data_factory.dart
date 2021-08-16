import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';

class ReadStoryDataFactory {
  ReadStoryDataFactory({required this.storyScreenId, story, isEdit})
      : this.story = story ??
            Story(
                id: EMPTY_STRING,
                title: EMPTY_STRING,
                subTitle: EMPTY_STRING,
                imageUrl: EMPTY_STRING,
                content: EMPTY_STRING),
        this.isEdit = isEdit ?? false;

  HomeNavigationItemIdEnum storyScreenId;

  Story story;

  bool isEdit;
}
