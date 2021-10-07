import 'package:story_repository/src/models/models.dart';

extension AdsExtension on Ads {
  Story get toStory {
    return Story(id: id, title: title, subTitle: subTitle, imageUrl: imageUrl, content: content);
  }
}
