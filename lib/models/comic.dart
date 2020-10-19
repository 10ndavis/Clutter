import 'package:Clutter/models/chapter.dart';

class Comic {
  Comic({
    this.cover,
    this.title,
    this.chapters = const <Chapter>[],
  });
  final String cover;
  final String title;
  List<Chapter> chapters;
}
