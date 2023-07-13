import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webtoon_flutter/Webtoon/models/webtoon_model.dart';
import 'package:webtoon_flutter/Webtoon/services/api_service.dart';
import 'package:webtoon_flutter/Webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1, //앱바의 음영을 설정 0-> 없어짐
        backgroundColor: Colors.white,
        foregroundColor: Colors.green, //글자색
        title: Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        //StatelessWidget으로 Stateful처럼 하기
        //FutureBuilder : Future랑 build함수 받음
        future: webtoons,
        builder: (context, snapshot) {
          //snapshotㅈㅏ리 매개변수 : Future의 상태(로딩, 데이터 있는지? 오류는 없는지?)
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

// ListView : 많은 양의 데이터를 보여줄 때 효과적이다.
/* 가장 기본적인 ListView, 무한 스크롤 기능 만들 경우 한 번에 다 로딩하기에 메모리가 넘칠거임
return ListView(
  children: [
    for(var webtoon in snapshot.data!) Text('${webtoon.title}') //snapshot.data :  future의 결과값, webtoonModel의 리스트
  ],
 */
//최적화된 ListView 만들기 : ListView.builder
  //return ListView.builder( //사용자가 보고 있는 아이템만 build할 거임
  //사용자가 안보고 있으면 메모리에서 삭제한다.
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // ListView.builder에서 구분해서 표현할 때
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        //어떤 아이템이 build됐는지 아는 방법 : 인덱스만 활용할 수 있다
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title, thumb: webtoon.thumb,
          id: webtoon.id
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
