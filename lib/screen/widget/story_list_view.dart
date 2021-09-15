import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/read_story_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/util/navigation.dart';

class StoryListView extends StatelessWidget {
  final List<Story> stories;
  final HomeNavigationItemIdEnum storyScreenId;

  StoryListView({
    Key? key,
    required this.stories,
    required this.storyScreenId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return storyListView(context, stories, storyScreenId);
  }
}

ListView storyListView(BuildContext context, List<Story> stories,
    HomeNavigationItemIdEnum storyScreenId) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: stories.length,
      itemBuilder: (context, index) {
        Story story = stories[index];
        return ListTile(
            title: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      height: 72.0,
                      width: 72.0,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(70),
                                offset: const Offset(2.0, 2.0),
                                blurRadius: 2.0)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              story.imageUrl,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          story.title,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          story.subTitle,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    )),
                  ],
                ),
                Divider(),
              ],
            ),
            onTap: () {
              onTapListItem(context, story, storyScreenId);
            });
      });
}

onTapListItem(
    BuildContext context, Story story, HomeNavigationItemIdEnum storyScreenId) {
  Navigation().pushPageWithArgument(context, ROUTE_READ_STORY,
      ReadStoryDataModel(storyScreenId: storyScreenId, story: story));
}
