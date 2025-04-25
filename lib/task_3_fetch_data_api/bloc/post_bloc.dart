import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/domain/models/post_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/domain/repositories/post_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PostInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final List<PostModel> posts = await _postRepository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
