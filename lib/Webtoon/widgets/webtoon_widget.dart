import 'package:flutter/material.dart';
import 'package:webtoon_flutter/Webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget{
  final String title, thumb, id;

  const Webtoon({super.key,
    required this.title,
    required this.thumb,
    required this.id
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push( //다른 statelessWidget을 렌더링하는데 애니메이션을 줌
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                  title: title,
                  thumb: thumb,
                  id: id
              ),
            ),
        ); //Navigator.push -> StatelessWidget을 원하지 않는다.
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 15, //그림자 크기
                        offset: Offset(10,10),
                        color: Colors.black.withOpacity(0.5)//그림자 위치 (좌표 지정)

                    )
                  ]
              ),
              child: Image.network(
                thumb,
                headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(title,
            style: const TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}