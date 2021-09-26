import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/toplist.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

class HomeContentScreen extends StatelessWidget {
  final HomeNavigationItemIdEnum id;

  const HomeContentScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10),
              color: Colors.white,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bannerImagesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(20.0),
                      child: Image.asset(
                        bannerImagesList[index],
                        fit: BoxFit.fill,
                        //  fit: BoxFit.fitWidth,
                        height: 150,
                        width: 300,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(child: _buildStoryListView()),
          ],
        ),
      ),
    );
  }

  _buildStoryListView() {
    return BlocBuilder<HomeStoryBloc, StoryState>(builder: (context, state) {
      if (state is StoryLoading) {
        return LoadingIndicator();
      } else if (state is StoryLoaded) {
        return storyView(state.stories, context, id);
      } else {
        return Container();
      }
    });
  }
}
