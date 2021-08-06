import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBloc;
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:vivasayi/bloc/story_genres/story_genres.dart';
import 'package:vivasayi/screen/story_genre/story_genre_screen.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: Wrapper(),
      initialRoute: ROUTE_CREATE_STORY,
      routes: {
        ROUTE_CREATE_STORY: (context) => BlocProvider<PostBloc>(
              bloc: PostBloc(),
              child: CreateStoryScreen(
                  collectionName: HomeNavigationItemIdEnum.HOME.value),
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
}
