import 'package:Clutter/models/comic.dart';
import 'package:Clutter/models/series.dart';
import 'package:Clutter/widgets/comic_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeriesDetails extends StatefulWidget {
  SeriesDetails({@required this.comic});
  final Series comic;

  @override
  _SeriesDetailsState createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  List<Page> pages = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Hero(
              tag: 'comic-details-${widget.comic.title}',
              child: Image(
                image: NetworkImage(
                  widget.comic.cover,
                ),
                height: 350 / 1,
                width: 250 / .5,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  ...widget.comic.chapters
                      .map(
                        (Comic comic) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComicView(comic: comic),
                              ),
                            );
                          },
                          child: Text(
                            comic.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
