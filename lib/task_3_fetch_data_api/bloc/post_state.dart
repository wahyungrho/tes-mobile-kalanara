part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostLoaded extends PostState {
  final List<PostModel> posts;

  PostLoaded(this.posts);
}

final class PostError extends PostState {
  final String error;

  PostError(this.error);
}
