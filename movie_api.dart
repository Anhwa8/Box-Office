import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieApi {
  var key = 'ed2d40d42e1ef38f52bad387b33ec987';

  Future<List<dynamic>> getDailyBoxOffice(String date) async {
    var site =
        'http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$key&targetDt=$date';

    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['boxOfficeResult']
          ['dailyBoxOfficeList'] as List<dynamic>;
      return movies;
    } else {
      //실패
      return [];
    }
  }
}
