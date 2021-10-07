import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBloc;
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/bloc/ads/home_banner_bloc.dart';
import 'package:vivasayi/bloc/ads/home_banner_event.dart';
import 'package:vivasayi/bloc/shop/agri_product_shop_bloc.dart';
import 'package:vivasayi/bloc/shop/equip_shop_bloc.dart';
import 'package:vivasayi/bloc/shop/irrigation_shop_bloc.dart';
import 'package:vivasayi/bloc/shop/machine_shop_bloc.dart';
import 'package:vivasayi/bloc/shop/manure_shop_bloc.dart';
import 'package:vivasayi/bloc/shop/nursery_shop_bloc.dart';
import 'package:vivasayi/bloc/shop_address/shop_address_bloc.dart';
import 'package:vivasayi/bloc/story/home_story_bloc.dart';
import 'package:vivasayi/bloc/story_genres/story_genres.dart';
import 'package:vivasayi/repository/repository.dart';
import 'package:vivasayi/screen/create_product/create_product_screen.dart';
import 'package:vivasayi/screen/create_shop/create_shop_profile_screen.dart';
import 'package:vivasayi/screen/read_story/read_story_screen.dart';
import 'package:vivasayi/screen/splash/splash_screen.dart';
import 'package:vivasayi/screen/story_genre/story_genre_screen.dart';
import 'package:vivasayi/screens/homepage.dart';
import 'package:vivasayi/screens/product_screen.dart';
import 'package:vivasayi/style/theme.dart';

import 'bloc/bloc.dart';
import 'bloc/bloc_provider/bloc_provider.dart';
import 'bloc/shop_address/shop_address_bloc.dart';
import 'constants/constant.dart';
import 'models/enum/enum.dart';
import 'screen/create_story/create_story_screen.dart';
import 'screens/product_details.dart';

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
        accentColor: AppColors.accentColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: Wrapper(),
      initialRoute: ROUTE_SPLASH,
      routes: {
        ROUTE_SPLASH: (context) => BlocProvider<SplashScreenBloc>(
              bloc: SplashScreenBloc(),
              child: SplashScreen(),
            ),
        ROUTE_HOME: (context) => generateHomeBlocProvider(),
        ROUTE_CREATE_STORY: (context) => BlocProvider<PostBloc>(
              bloc: PostBloc(),
              child: CreateStoryScreen(),
            ),
        ROUTE_READ_STORY: (context) => ReadStoryScreen(),
        ROUTE_SELECT_GENRE: (context) =>
            FlutterBloc.BlocProvider<StoryGenresBloc>(
                create: (context) {
                  return StoryGenresBloc(
                      storyGenresRepository: FirestoreStoryGenreRepository())
                    ..add(LoadStoryGenres());
                },
                child: StoryGenreScreen()),
        ROUTE_CREATE_SHOP_PROFILE: (context) =>
            BlocProvider<CreateShopProfileScreenBloc>(
              bloc: CreateShopProfileScreenBloc(
                  shopCategoryRepository: ShopCategoryRepository(),
                  shopRepository: FirestoreShopRepository()),
              child: CreateShopProfileScreen(),
            ),
        ROUTE_CREATE_PRODUCT: (context) =>
            BlocProvider<CreateProductScreenBloc>(
              bloc: CreateProductScreenBloc(
                  productRepository: FirestoreProductRepository(),
                  scaleTypeRepository: ScaleTypeRepository()),
              child: CreateProductScreen(),
            ),
        ROUTE_PRODUCT_LIST_SCREEN: (context) =>
            FlutterBloc.BlocProvider<ProductBloc>(
                create: (context) {
                  return ProductBloc(
                      productRepository: FirestoreProductRepository());
                },
                child: ProductScreen()),
        ROUTE_PRODUCT_DETAIL_SCREEN: (context) => ProductDetails(),
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
        FlutterBloc.BlocProvider<AgriProductShopBloc>(
          create: (BuildContext context) => AgriProductShopBloc(
            shopRepository: FirestoreShopRepository()
              ..updateShopCategory(
                  HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS.value),
          ),
        ),
        FlutterBloc.BlocProvider<EquipShopBloc>(
          create: (BuildContext context) => EquipShopBloc(
              shopRepository: FirestoreShopRepository()
                ..updateShopCategory(HomeNavigationItemIdEnum.EQUIPS.value)),
        ),
        FlutterBloc.BlocProvider<IrrigationShopBloc>(
          create: (BuildContext context) => IrrigationShopBloc(
            shopRepository: FirestoreShopRepository()
              ..updateShopCategory(HomeNavigationItemIdEnum.IRRIGATION.value),
          ),
        ),
        FlutterBloc.BlocProvider<MachineShopBloc>(
          create: (BuildContext context) => MachineShopBloc(
              shopRepository: FirestoreShopRepository()
                ..updateShopCategory(HomeNavigationItemIdEnum.MACHINES.value)),
        ),
        FlutterBloc.BlocProvider<ManureShopBloc>(
          create: (BuildContext context) => ManureShopBloc(
              shopRepository: FirestoreShopRepository()
                ..updateShopCategory(HomeNavigationItemIdEnum.MANURE.value)),
        ),
        FlutterBloc.BlocProvider<NurseryShopBloc>(
          create: (BuildContext context) => NurseryShopBloc(
              shopRepository: FirestoreShopRepository()
                ..updateShopCategory(HomeNavigationItemIdEnum.NURSERY.value)),
        ),
        FlutterBloc.BlocProvider<AgriProductShopAddressBloc>(
          create: (BuildContext context) => AgriProductShopAddressBloc(
              locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<EquipShopAddressBloc>(
          create: (BuildContext context) =>
              EquipShopAddressBloc(locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<IrrigationShopAddressBloc>(
          create: (BuildContext context) => IrrigationShopAddressBloc(
              locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<MachineShopAddressBloc>(
          create: (BuildContext context) =>
              MachineShopAddressBloc(locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<ManureShopAddressBloc>(
          create: (BuildContext context) =>
              ManureShopAddressBloc(locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<NurseryShopAddressBloc>(
          create: (BuildContext context) =>
              NurseryShopAddressBloc(locationRepository: LocationRepository()),
        ),
        FlutterBloc.BlocProvider<HomeBannerBloc>(
          create: (BuildContext context) => HomeBannerBloc(
              homeBannerAdsRepository: FirestoreHomeBannerAdsRepository())
            ..add((LoadAds())),
        ),
      ],
      child: MyHomePage(title: APP_NAME),
    );
  }
}
