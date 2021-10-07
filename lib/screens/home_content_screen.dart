import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/ads/home_banner_bloc.dart';
import 'package:vivasayi/bloc/ads/home_banner_state.dart';
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
            _buildBannerView(),
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

  _buildBannerView() {
    return BlocBuilder<HomeBannerBloc, HomeBannerState>(
        builder: (context, state) {
      if (state is AdLoaded) {
        return bannerView(state.ads, context, id);
      } else {
        return Container();
      }
    });
  }
}
