import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location_repository/location_repository.dart';
import 'package:vivasayi/bloc/shop/shops.dart';
import 'package:vivasayi/bloc/shop_address/shop_address_bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/data_factory/data_factory.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart';

class EquipsScreen extends StatefulWidget {
  final HomeNavigationItemIdEnum id;

  const EquipsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _EquipsScreenState createState() => _EquipsScreenState();
}

class _EquipsScreenState extends State<EquipsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadShop(getLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildShopFilterView(),
              _buildShopListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopFilterView() {
    return BlocBuilder<EquipShopAddressBloc, ShopAddressState>(
        builder: (context, state) {
      String address = EMPTY_STRING;
      if (state is ShopAddressLoading) {
        address = state.hint;
      } else if (state is ShopAddressLoaded) {
        address = state.address;
      }
      return ShopFilterView(
          address: address,
          iconColor: AppColors.appGreen,
          onTapAddress: () {
            onClickAddressTextView();
          });
    });
  }

  _buildShopListView() {
    return BlocBuilder<EquipShopBloc, ShopState>(builder: (context, state) {
      if (state is ShopLoading) {
        return LoadingIndicator();
      } else if (state is ShopLoaded) {
        return shopView(state.shops, context, widget.id);
      } else {
        return Container();
      }
    });
  }

  void loadShop(Location location) {
    context.read<EquipShopBloc>().add(LoadShop(location));
    context.read<EquipShopAddressBloc>().add(LoadShopAddress(location));
  }

  Location getLocation() {
    HomeScreenDataModel homeScreenDataModel =
    ModalRoute.of(context)!.settings.arguments as HomeScreenDataModel;
    Location location = DefaultLocationDataFactory()
        .generateOtherShopDefaultLocation(homeScreenDataModel.position);
    return location;
  }

  void onClickAddressTextView() {
    Location location = getLocation();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: API_KEY_MAP, // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            print(result.formattedAddress);
            if (result.geometry?.location != null) {
              loadShop(Location(result.geometry!.location.lat,
                  result.geometry!.location.lng));
            }
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(location.latitude, location.longitude),
          useCurrentLocation: true,
        ),
      ),
    );
  }
}
