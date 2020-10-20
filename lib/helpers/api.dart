import 'dart:convert';

import 'package:Clutter/models/comic.dart';
import 'package:Clutter/models/page.dart';
import 'package:Clutter/models/series.dart';
import 'package:http/http.dart' as http;

Future<List<Series>> search(String query) async {
  var url = 'https://node-comic-server.herokuapp.com/search/$query';
  List<Series> result = [];

  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    result = await Future.wait(body.map((dynamic comic) async {
      dynamic comicData = await getComicDetails(comic['url']);

      List<dynamic> chaptersRaw = comicData['chapters'];

      // map the chapters
      List<Comic> chapters = await Future.wait(chaptersRaw.map((dynamic chapter) async {
        return Comic(
          title: chapter['title'],
          date: chapter['date'],
          url: chapter['url'],
        );
      }).toList());

      // map the comic
      return Series(
        cover: comicData['image'],
        title: comicData['title'],
        releaseDate: comicData['dateRelease'],
        chapters: chapters,
      );
    }));
  }

  return result;
}

Future<dynamic> getComicDetails(String url) async {
  var response = await http.get(url);

  return jsonDecode(response.body);
}

Future<dynamic> getChapterPages(String url) async {
  var response = await http.get(url);

  return jsonDecode(response.body);
}

List<Page> processPages(List<dynamic> pageList) {
  List<Page> result = [];
  pageList.forEach((page) => result.add(Page(url: page['image'])));
  return result;
}
