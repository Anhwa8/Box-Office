import 'package:flutter/material.dart';

class MovieData {
  final rank, rankInten, movieNm, openDt, audiAcc;

  MovieData(
      {required this.rank,
      required this.rankInten,
      required this.movieNm,
      required this.openDt,
      required this.audiAcc});
}

class MovieForm extends StatelessWidget {
  Map<String, dynamic> movie;
  MovieForm({super.key, required this.movie});
  var movieData;
  @override
  Widget build(BuildContext context) {
    Color rankColor = Colors.black;
    if (movie['rank'] == '1') {
      rankColor = Colors.yellow;
    } else if (movie['rank'] == '2') {
      rankColor = Colors.grey;
    } else if (movie['rank'] == '3') {
      rankColor = Colors.brown;
    }

    int rankInten = int.parse(movie['rankInten']); //int로 변환
    String rankStr = '';
    Color rankIntColor = Colors.black;
    if (rankInten > 0) {
      rankStr = '▲${movie['rankInten']}';
      rankIntColor = Colors.red;
    } else if (rankInten < 0) {
      rankStr = '▼${movie['rankInten']}';
      rankIntColor = Colors.blue;
    } else {
      rankStr = '-';
      rankIntColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                //증감폭
                child: SizedBox(
                    width: 30,
                    child: Text(
                      rankStr,
                      style: TextStyle(color: rankIntColor),
                    ))),
            SizedBox(
                //순위
                width: 70,
                height: 50,
                child: Center(
                  child: Text(
                    movie['rank'],
                    style: TextStyle(fontSize: 20, color: rankColor),
                  ),
                )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${movie['movieNm']}', //제목
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                Text('개봉일: ${movie['openDt']}'),
                Text('누적관객수: ${movie['audiAcc']}')
              ],
            ))
          ],
        ),
      ),
    );
  }
}
