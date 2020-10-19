import 'dart:convert';

import 'package:Clutter/models/chapter.dart';
import 'package:Clutter/models/comic.dart';
import 'package:http/http.dart' as http;

Future<List<Comic>> search(String query) async {
  var url = 'https://node-comic-server.herokuapp.com/search/$query';
  List<Comic> result = [];

  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    result = await Future.wait(body.map((dynamic comic) async {
      dynamic comicData = await getComicDetails(comic['url']);

      List<dynamic> chaptersRaw = comicData['chapters'];

      // map the chapters
      List<Chapter> chapters = chaptersRaw.map((dynamic chapter) {
        return Chapter(
          title: chapter['title'],
          date: chapter['date'],
          url: chapter['url'],
        );
      }).toList();

      // map the comic
      return Comic(
        cover: comicData['image'],
        title: comicData['title'],
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
