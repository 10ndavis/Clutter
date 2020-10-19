import 'package:Clutter/helpers/api.dart';
import 'package:Clutter/models/comic.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller;
  List<Comic> searchResults = [];

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _updateSearchResults();
    });
  }

  void _updateSearchResults() async {
    List<Comic> results = await search(_controller.text);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term',
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.orangeAccent,
                    onPressed: _search,
                    child: Text('search'),
                  ),
                ],
              ),
              buildComicList()
            ],
          ),
        ),
      ),
    );
  }

  Wrap buildComicList() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ...searchResults
            .map(
              (Comic comic) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.50),
                        blurRadius: 10,
                      )
                    ]),
                    margin: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image(
                        height: 350 / 1.5,
                        width: 250 / 1.5,
                        image: NetworkImage(comic.cover),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        right: 20,
                      ),
                      child: Text(
                        comic.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
