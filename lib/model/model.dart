class YouTubeModel {
   String? id;
  String? caption;
  String? url;
  String? image;
   String? views;
   String? channelName;
  YouTubeModel({required this.id, required this.caption, required this.url, required this.image,required this.views,this.channelName});


 YouTubeModel.fromJson(Map <String,dynamic> json)
 {
  id = json["id"];
  image = json["image"];
  url = json["url"];
  caption = json["caption"];
  views = json["views"];
  channelName = json["channelName"];

}
}