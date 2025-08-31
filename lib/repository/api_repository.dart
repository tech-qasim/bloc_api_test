import 'dart:convert';

import 'package:bloc_api_test/models/post.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  static String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/posts"),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        final data = jsonList.map((e) => Post.fromMap(e)).toList();
        return data;
      } else {
        debugPrint('error fetching posts');
        return [];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Post>> fetchPostsByBatch(int startPage, int limit) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/posts?_start=$startPage&_limit=$limit"),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        final data = jsonList.map((e) => Post.fromMap(e)).toList();
        return data;
      } else {
        debugPrint('error fetching posts');
        return [];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Post?> addPost(Map<String, dynamic> post) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/posts"),
        body: jsonEncode(post),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonObject = jsonDecode(response.body);
        final data = Post.fromMap(jsonObject);
        return data;
      } else {
        debugPrint('add post failed');
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
