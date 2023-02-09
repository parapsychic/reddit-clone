part of 'get_posts_cubit.dart';

@immutable
abstract class GetPostsState {}

class GetPostsInitial extends GetPostsState {}

class GetPostsLoading extends GetPostsState {}

class GetPostsCompleted extends GetPostsState {
  final List<Post> posts;

  GetPostsCompleted(this.posts);
}

class GetPostsError extends GetPostsState {
  final ServiceFailure failure;

  GetPostsError(this.failure);
}
