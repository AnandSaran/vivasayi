import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

class HomeContentScreen extends StatelessWidget {
  final String id;

  const HomeContentScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Image.asset(
                        'asset/svg/seedimage.png',
                        height: 200,
                        width: 250,
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
