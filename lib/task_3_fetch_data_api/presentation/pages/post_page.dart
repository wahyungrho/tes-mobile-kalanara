import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/bloc/post_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/presentation/widgets/list_tile_widget.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  void fetchPost() {
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                fetchPost();
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTileWidget(
                        title: state.posts[index].title,
                        subtitle: state.posts[index].body,
                      ),
                      const Divider(height: 0, color: Colors.grey),
                    ],
                  );
                },
              ),
            );
          } else if (state is PostError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('Unknown State'));
        },
      ),
    );
  }
}
