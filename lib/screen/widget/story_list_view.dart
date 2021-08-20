import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';

ListView storyListView(List<Story> stories) {
  return ListView.builder(
    
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: stories.length,
      itemBuilder: (context, index) {
        Story story = stories[index];
        return ListTile(
          title: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    height: 72.0,
                    width: 72.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(70),
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 2.0)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                            story.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        story.title,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6.0,),
                      Text(
                        story.subTitle,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  )),
                ],
              ),
              Divider(),
            ],
          ),
        );
      });
}
