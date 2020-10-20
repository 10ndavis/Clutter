import 'package:Clutter/models/comic.dart';
import 'package:Clutter/models/page.dart' as Clutter;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicView extends StatefulWidget {
  ComicView({@required this.comic});
  final Comic comic;

  @override
  _ComicViewState createState() => _ComicViewState();
}

class _ComicViewState extends State<ComicView> {
  Widget _buildComics(BuildContext context, List<Clutter.Page> pages) {
    return PageView(
      children: [
        ...pages.map(
          (Clutter.Page page) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InteractiveViewer(
              child: CachedNetworkImage(imageUrl: page.url),
            ),
          ),
        )
      ],
      scrollDirection: Axis.horizontal,
      controller: PageController(
        viewportFraction: .90,
        initialPage: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: widget.comic.getPages(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildComics(context, snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
