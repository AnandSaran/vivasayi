import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.filter_alt_sharp),
            Text("Filter"),
            SizedBox(),
            Icon(Icons.filter_alt_sharp),
            Text("Filter"),
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(10, (index) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      'https://picsum.photos/500/500?random=$index',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Text $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
