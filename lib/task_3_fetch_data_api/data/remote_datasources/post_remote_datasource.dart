import 'dart:convert';

import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/domain/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRemoteDatasource {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
