import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

class NaturalAgriScreen extends StatelessWidget {
  final String id;

  const NaturalAgriScreen({Key? key, required this.id}) : super(key: key);

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
    return BlocBuilder<NaturalAgriStoryBloc, StoryState>(
        builder: (context, state) {
      if (state is StoryLoading) {
        return LoadingIndicator();
      } else if (state is StoryLoaded) {
        return storyListView(state.stories);
      } else {
        return Container();
      }
    });
  }
}
