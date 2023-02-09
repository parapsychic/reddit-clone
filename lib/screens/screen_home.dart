import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_clone/core/image_card.dart';
import 'package:reddit_clone/logic/get_posts/get_posts_cubit.dart';
import 'package:reddit_clone/services/rest_services.dart';

import '../core/constants.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    BlocProvider.of<GetPostsCubit>(context).getPosts(SUBREDDIT, MAX_COUNT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Sawwit!",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              BlocBuilder<GetPostsCubit, GetPostsState>(
                builder: (context, state) {
                  if (state is GetPostsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetPostsError) {
                    return Center(
                      child: Text(state.failure.name),
                    );
                  }
                  if (state is GetPostsCompleted) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ImageCard(
                              imageTitle: state.posts[index].title,
                              imageURL: state.posts[index].url);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: state.posts.length,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
