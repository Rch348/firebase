class PostModel 
{
   int? albumId;
   int? id;
   String? title;
   String? url;
   String? thumbnailUrl;

   PostModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

   // Pour lier ce qu'on reçoit du JSON
   PostModel.fromJson(Map<String, dynamic> json) 
   {
      albumId = json['albumId'];
      id = json['id'];
      title = json['title'];
      url = json['url'];
      thumbnailUrl = json['thumbnailUrl'];

   }
}
