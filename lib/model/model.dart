class YouTubeModel {
   String? id;
  String? caption;
  String? url;
  String? image;

  YouTubeModel({required this.id, required this.caption, required this.url, required this.image});


 YouTubeModel.fromJson(Map <String,dynamic> json)
 {
  id = json["id"];
  image = json["image"];
  url = json["url"];
  caption = json["caption"];

}
}