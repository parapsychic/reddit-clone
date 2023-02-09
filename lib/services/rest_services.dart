import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:reddit_clone/core/API_CONSTANTS.dart';

import '../models/post/post.dart';
import '../models/service_failure/service_failure.dart';

class RESTServices {
  static Future<Either<ServiceFailure, List<Post>>> getPosts(
      {required String subreddit, int count = 5}) async {
    String url = "$API_URL$subreddit/hot.json";

    try {
      List<Post> _posts = [];

      // TODO check for images
      final query = {"limit": count};
      final response = await Dio().get(url, queryParameters: query);
      final allPosts = response.data["data"]["children"];

      for (var post in allPosts) {
        print(post["data"]["is_video"].runtimeType);

        if (!post["data"]["is_video"]) _posts.add(Post.fromJson(post["data"]));
      }
      return Right(_posts);
    } catch (e) {
      print(e);
      return const Left(ServiceFailure.APIFailure);
    }
  }
}
