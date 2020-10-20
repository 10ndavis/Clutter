import 'package:Clutter/helpers/api.dart';
import 'package:Clutter/models/series.dart';
import 'package:Clutter/widgets/series_details.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller;
  List<Series> searchResults = [];

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
    List<Series> results = await search(_controller.text);
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
              (Series comic) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeriesDetails(comic: comic),
                    ),
                  );
                },
                child: Hero(
                  tag: 'comic-details-${comic.title}',
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.50),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    margin: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image(
                            image: NetworkImage(comic.cover),
                            height: 350 / 1,
                            width: 250 / .5,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                    top: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment(0, 1),
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(.80),
                                        Colors.black.withOpacity(.95),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comic.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
