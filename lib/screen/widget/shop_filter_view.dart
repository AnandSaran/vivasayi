import 'package:flutter/material.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/shop_list_view.dart';

Widget shopFilterView(Color iconColor) {
  return  Padding(
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
        Expanded(flex:3,child: SizedBox()),
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
              decoration: InputDecoration(
                  hintText: 'Location',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.location_pin,
                      color: iconColor)),
            ),
          ),
        )
      ],
    ),
  );
}
