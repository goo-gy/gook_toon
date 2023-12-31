import 'dart:convert';

import 'package:gook_toon/models/webtoon.dart';
import 'package:gook_toon/models/webtoon_detail.dart';
import 'package:gook_toon/models/webtoon_episode.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String todayApi = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$todayApi');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoonsJson = jsonDecode(response.body);
      final webtoons = webtoonsJson
          .map(
            (e) => WebtoonModel.fromJson(e),
          )
          .toList();
      return webtoons;
    } else {
      print("Status: ${response.statusCode}");
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic webtoonsJson = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoonsJson);
    } else {
      print("Status: ${response.statusCode}");
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesByToonId(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> webtoonEpisodesJson = jsonDecode(response.body);
      final webtoonEpisodes = webtoonEpisodesJson
          .map(
            (e) => WebtoonEpisodeModel.fromJson(e),
          )
          .toList();
      return webtoonEpisodes;
    } else {
      print("Status: ${response.statusCode}");
      throw Error();
    }
  }
}
