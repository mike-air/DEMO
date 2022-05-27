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
      bottomNavigationBar: buildBottomNavigationBar(),
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<List<YouTubeModel>> buildFutureBuilder() {
    return FutureBuilder(
      future: jsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Text("${data.error}");
        } else if (data.hasData) {
          var items = data.data as List<YouTubeModel>;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoApp(asset: items[index].url.toString(),))),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: Image.asset(
                                        items[index].image.toString(),
                                        // width: 300,
                                        height: 150,
                                        fit: BoxFit.fill),
                                  ),
                                  ListTile(
                                    title:
                                        Text(items[index].caption.toString()),
                                    subtitle: Row(
                                      children: [
                                        Text("${items[index].views}k views"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("1 week ago")
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  print(
                                                      "View channel details");
                                                },
                                                icon: const Icon(Icons.face)),
                                            Text(items[index]
                                                .channelName
                                                .toString())
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Subscribe"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {

    int selected = 0;

    void _onTapped(int index) {
      setState(() {
        selected = index;
      });
     // Navigator.push(context, route)
    }
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      currentIndex: selected,
      onTap: _onTapped,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_fire_department,color: Colors.black54,),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle,color: Colors.black54,),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder,color: Colors.black54,),
          label: 'Play',
        ),
      ],
      type: BottomNavigationBarType.shifting,
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
    return VideoApp(asset: 'assets/video.mp4',);
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
