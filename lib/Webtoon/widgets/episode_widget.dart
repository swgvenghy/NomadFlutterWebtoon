import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget{
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoonId,
  }) : super(key: key);


  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async{
    await launchUrlString(
      "https://comic.naver.com/webtoon/detail?titleId=${webtoonId}&no=${int.parse(episode.id)+1}"
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}