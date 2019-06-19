import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
  Widget build(BuildContext context){
    return Card(
      elevation: 3.0,
    );
  }
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.search,
                color: Colors.black45,
              ),
              onTap: (){},
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Search..."),
                onSubmitted: (String place){},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
