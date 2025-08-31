import 'package:bloc_api_test/bloc/api_bloc.dart';
import 'package:bloc_api_test/bloc/api_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<ApiBloc>().add(GetPostListByBatchEvent());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApiBloc>().add(GetInitialPosts());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<ApiBloc>().state.posts;
    final isLoading = context.watch<ApiBloc>().state.isFetchign;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('enter title'),
                    SizedBox(height: 5),
                    TextField(controller: titleController),
                    SizedBox(height: 10),
                    Text('enter body'),
                    SizedBox(height: 5),
                    TextField(controller: bodyController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ApiBloc>().add(
                              AddPostEvent(
                                title: titleController.text,
                                body: bodyController.text,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('bloc api')),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) {
              context.read<ApiBloc>().add(SearchPostEvent(searchQuery: value));
            },
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: posts.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final post = posts[index];
                return ListTile(
                  leading: Text(post.id.toString()),
                  title: Text(post.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
