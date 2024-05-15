// ignore_for_file: prefer_const_constructors

import 'package:fake_api/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

   @override
   State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   // static : (ici, le Future) permet de dire qu'on peut appeler le Future depuis n'importe où.
   static Future<List<PostModel>> getPosts() async {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos');
      // Attente d'un contenu de type json qui sera stocké dans 'response'.
      final response =
         await http.get(
            url, headers: {'Content-Type': 'application/json'
            }
         );
      // Décodage du contenu dans la liste 'data'.
      final List data = json.decode(response.body);
      return data.map((post) => PostModel.fromJson(post)).toList();
   }

   Future<List<PostModel>> posts = getPosts();

   @override
   Widget build(BuildContext context) {
      return Center(

         child: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
               future: posts,
               builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                     return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                     final posts = snapshot.data!;
                     return displayPosts(posts);
                  } else {
                     return Text('Pas d\'album pour le moment');
                  }
               }),
         ));
   }

   Widget displayPosts(List<PostModel> posts) {
      return ListView.builder(
         itemCount: posts.length,
         itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
               child: ListTile(
                  leading: Image.network(post.thumbnailUrl!),
                  title: Text(post.title!),
                  subtitle: Text(post.url!),
               )
            );
         }
      );
   }
}
