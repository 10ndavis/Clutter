import 'package:Clutter/models/comic.dart';

class Series {
  Series({
    this.cover,
    this.releaseDate,
    this.title,
    this.chapters = const <Comic>[],
  });
  final String cover;
  final String releaseDate;
  final String title;
  List<Comic> chapters;
}
