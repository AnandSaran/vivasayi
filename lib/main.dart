import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBloc;
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/bloc/story/home_story_bloc.dart';
import 'package:vivasayi/bloc/story_genres/story_genres.dart';
import 'package:vivasayi/repository/repository.dart';
import 'package:vivasayi/screen/story_genre/story_genre_screen.dart';
import 'package:vivasayi/screens/homepage.dart';
import 'package:vivasayi/style/theme.dart';

import 'bloc/bloc.dart';
import 'bloc/bloc_provider/bloc_provider.dart';
import 'constants/constant.dart';
import 'models/enum/enum.dart';
import 'screen/create_story/create_story_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        fontFamily: 'sitka',
        primaryColor: AppColors.appGreen,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: Wrapper(),
      initialRoute: ROUTE_HOME,
      routes: {
        ROUTE_HOME: (context) => generateHomeBlocProvider(),
        ROUTE_CREATE_STORY: (context) => BlocProvider<PostBloc>(
              bloc: PostBloc(),
              child: CreateStoryScreen(),
            ),
        ROUTE_SELECT_GENRE: (context) =>
            FlutterBloc.BlocProvider<StoryGenresBloc>(
                create: (context) {
                  return StoryGenresBloc(
                      storyGenresRepository: FirestoreStoryGenreRepository())
                    ..add(LoadStoryGenres());
                },
                child: StoryGenreScreen()),
      },
    );
  }

  FlutterBloc.MultiBlocProvider generateHomeBlocProvider() {
    return FlutterBloc.MultiBlocProvider(
      providers: [
        FlutterBloc.BlocProvider<HomeNavigationBloc>(
          create: (BuildContext context) => HomeNavigationBloc(
              homeNavigationRepository: HomeNavigationRepository())
            ..add((LoadHomeNavigationList())),
        ),
        FlutterBloc.BlocProvider<AgriMedicinesStoryBloc>(
          create: (BuildContext context) => AgriMedicinesStoryBloc(
              storyRepository: FirestoreStoryRepository(
                  HomeNavigationItemIdEnum.AGRI_MEDICINES.value))
            ..add((LoadStory())),
        ),
        FlutterBloc.BlocProvider<ArticlesStoryBloc>(
          create: (BuildContext context) => ArticlesStoryBloc(
              storyRepository: FirestoreStoryRepository(
                  HomeNavigationItemIdEnum.ARTICLES.value))
            ..add((LoadStory())),
        ),
        FlutterBloc.BlocProvider<HomeStoryBloc>(
          create: (BuildContext context) => HomeStoryBloc(
              storyRepository:
                  FirestoreStoryRepository(HomeNavigationItemIdEnum.HOME.value))
            ..add((LoadStory())),
        ),
        FlutterBloc.BlocProvider<ModernAgriStoryBloc>(
          create: (BuildContext context) => ModernAgriStoryBloc(
              storyRepository: FirestoreStoryRepository(
                  HomeNavigationItemIdEnum.MODERN_AGRI.value))
            ..add((LoadStory())),
        ),
        FlutterBloc.BlocProvider<NaturalAgriStoryBloc>(
          create: (BuildContext context) => NaturalAgriStoryBloc(
              storyRepository: FirestoreStoryRepository(
                  HomeNavigationItemIdEnum.NATURAL_AGRI.value))
            ..add((LoadStory())),
        ),
        FlutterBloc.BlocProvider<TerraceGardenStoryBloc>(
          create: (BuildContext context) => TerraceGardenStoryBloc(
              storyRepository: FirestoreStoryRepository(
                  HomeNavigationItemIdEnum.TERRACE_GARDEN.value))
            ..add((LoadStory())),
        ),
      ],
      child: MyHomePage(title: 'Vivasayi'),
    );
  }
}
