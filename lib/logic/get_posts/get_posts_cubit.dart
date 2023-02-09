import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:reddit_clone/models/service_failure/service_failure.dart';
import 'package:reddit_clone/services/rest_services.dart';

import '../../models/post/post.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit() : super(GetPostsInitial());
  Future<void> getPosts(String subreddit, int count) async {
    final res = await RESTServices.getPosts(subreddit: subreddit, count: count)
        .fold((left) => emit(GetPostsError(left)),
            (right) => emit(GetPostsCompleted(right)));
  }
}
