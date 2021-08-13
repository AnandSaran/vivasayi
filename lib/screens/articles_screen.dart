import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

class ArticlesScreen extends StatelessWidget {
  final String id;

  const ArticlesScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: _buildStoryListView()),
            ],
          ),
        ),
      ),
    );
  }

  _buildStoryListView() {
    return BlocBuilder<ArticlesStoryBloc, StoryState>(
        builder: (context, state) {
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
