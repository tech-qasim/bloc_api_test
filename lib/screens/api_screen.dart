import 'package:bloc_api_test/bloc/api_bloc.dart';
import 'package:bloc_api_test/bloc/api_event.dart';
import 'package:bloc_api_test/repository/api_repository.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApiBloc>().add(GetPostListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<ApiBloc>().state.filteredPosts;
    final isLoading = context.watch<ApiBloc>().state.isLoading;
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

          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(title: Text(post.title));
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
