import 'dart:convert';
import 'package:http/http.dart' as http; //import한 package 이름을 http로 명명함
import 'package:webtoon_flutter/Webtoon/models/webtoon_model.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_episode_model.dart';
class ApiService{
  static const String baseUrl= "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //future: 미래에 받을 값의 타입을 지칭함 -> 비동기 프로그래밍에 사용
  //Future<Response> -> response : Future함수 완료시 response 반환
  static Future<List<WebtoonModel>> getTodaysToons()async { //async : 비동기 함수임을 표현
    List<WebtoonModel> webtoonInstances= [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); //await: 비동기 함수(async)내에서만 사용 가능하다. 응답이 완료될 때 까지 기다리게해준다.
    if(response.statusCode == 200) {
      //jsonDecode() -> JSON포맷으로 decode한다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for(var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async{
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async{
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for(var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.formJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}