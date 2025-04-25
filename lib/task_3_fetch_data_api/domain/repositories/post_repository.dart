import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/data/remote_datasources/post_remote_datasource.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/domain/models/post_model.dart';

class PostRepository {
  final PostRemoteDatasource postRemoteDatasource = PostRemoteDatasource();

  Future<List<PostModel>> fetchPosts() async {
    return await postRemoteDatasource.fetchPosts();
  }
}
