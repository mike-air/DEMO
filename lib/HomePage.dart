import 'dart:convert';

import 'package:demo/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter/services.dart" as rootBundler;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'VideoDetailsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Play',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white38,
      ),
      body: FutureBuilder(
        future: jsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Text("${data.error}");
          } else if (data.hasData) {
            var items = data.data as List<YouTubeModel>;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoApp(),
                                ),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(40),
                                  child: Center(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              items[index].image.toString()),
                                          SizedBox(height: 10,),
                                          Text(items[index].caption.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                        ],
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  AppBar header(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          showSearch(context: context, delegate: MySearchDelegate());
        },
        icon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.supervised_user_circle,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Future<List<YouTubeModel>> jsonData() async {
    final jsonData =
        await rootBundler.rootBundle.loadString("jsonfile/youtube.json");
    final list = jsonDecode(jsonData) as List<dynamic>;

    return list.map((e) => YouTubeModel.fromJson(e)).toList();
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> search = ["football", "games", "movies", "basketball"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return VideoApp();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggests = search.where((element) {
      final result = element.toLowerCase();
      final input = element.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggests[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
      itemCount: suggests.length,
    );
  }
}
