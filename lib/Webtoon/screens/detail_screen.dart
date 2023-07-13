import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon_flutter/Webtoon/services/api_service.dart';
import 'package:webtoon_flutter/Webtoon/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget{
  final String title,thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>  {

  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async{
    prefs = await SharedPreferences.getInstance(); //핸드폰 저장소 액세스 얻기
    final likedToons = prefs.getStringList('likedToons');
    if(likedToons != null) {
      if(likedToons.contains(widget.id) == true){
        setState(() {
          isLiked = true;
        });
      }
    } else{
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon=ApiService.getToonById(widget.id);
    episodes=ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async{
    final likedToons = prefs.getStringList('likedToons');
    if(likedToons != null) {
      if(isLiked) {
        likedToons.remove(widget.id);
      } else{
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1, //앱바의 음영을 설정 0-> 없어짐
        backgroundColor: Colors.white,
        foregroundColor: Colors.green, //글자색
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            )
          )
        ],
        title: Text(
          widget.title, //widget.~~ : widget => 부모에게 가라는 의미
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15, //그림자 크기
                              offset: const Offset(10,10),
                              color: Colors.black.withOpacity(0.5)//그림자 위치 (좌표 지정)

                          )
                        ]
                    ),
                    child: Image.network(
                      widget.thumb,
                      headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,),
            FutureBuilder(
              future: webtoon,
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                }
                return const Text("...");
              },
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Column(
                    children: [
                      for(var episode in snapshot.data!)
                        Episode(episode: episode,
                        webtoonId : widget.id),
                    ],
                  );
                }
                return Container();
              }
            )
          ],
        ),
      ),
    ),
  );
}
