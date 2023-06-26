import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/movie_api.dart';
import 'package:flutter_application_kobis/movie_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  dynamic searchData = DateTime.now().toString().split(' ')[0];
  var api = MovieApi();
  dynamic body = const Center(
    child: Text('날짜를 입력해주세요'),
  );

  void showCal() async {
    var dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 1)),
        firstDate: DateTime(2000),
        lastDate: DateTime.now().subtract(const Duration(days: 1)));

    if (dt != null) {
      var date = dt.toString().split(' ')[0].replaceAll('-', '');
      var fmovies = api.getDailyBoxOffice(date);

      setState(() {
        searchData = dt.toString().split(' ')[0];
        body = FutureBuilder(
          future: fmovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movies = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) {
                  var movie = movies[index];
                  return MovieForm(movie: movie);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: movies!.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );

        // body = ListView.separated(
        //     itemBuilder: (context, index) {
        //       var movie = movies[index];
        //       return MovieForm(movie: movie);
        //     },
        //     separatorBuilder: (context, index) => const Divider(),
        //     itemCount: movies.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('날짜: $searchData')),
        backgroundColor: Colors.blueGrey,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showCal,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.search),
      ),
      // backgroundColor: Colors.white,
    );
  }
}
