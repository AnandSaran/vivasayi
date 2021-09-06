import 'package:flutter/material.dart';

class ShopFilterView extends StatelessWidget {
  final String address;
  final Color iconColor;
  final GestureTapCallback onTapAddress;

  ShopFilterView({
    Key? key,
    required this.address,
    required this.iconColor,
    required this.onTapAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.filter_alt_sharp,
              color: iconColor,
            ),
          ),
          Text("Filter"),
          Expanded(flex: 3, child: SizedBox()),
          Flexible(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: iconColor, // set border color
                    width: 2.0), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: TextField(
                onTap: () => onTapAddress(),
                decoration: InputDecoration(
                    hintText: address,
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.location_pin, color: iconColor)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
