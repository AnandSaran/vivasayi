import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/shop/shops.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart';

class NurseryScreen extends StatelessWidget {
  final HomeNavigationItemIdEnum id;

  const NurseryScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              shopFilterView(
                AppColors.appGreen,
              ),
              _buildShopListView(),
            ],
          ),
        ),
      ),
    );
  }

  _buildShopListView() {
    return BlocBuilder<NurseryShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return LoadingIndicator();
          } else if (state is ShopLoaded) {
            return shopView(state.shops, context, id);
          } else {
            return Container();
          }
        });
  }
}
