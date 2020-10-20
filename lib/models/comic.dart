import 'package:Clutter/helpers/api.dart';
import 'package:Clutter/models/page.dart';

class Comic {
  Comic({
    this.date,
    this.title,
    this.url,
  });
  final String date;
  final String title;
  final String url;

  Future<List<Page>> getPages() async {
    dynamic pageData = await getChapterPages(this.url);
    final List<Page> pages = processPages(pageData);
    return pages;
  }
}
