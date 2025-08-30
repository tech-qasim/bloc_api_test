import 'package:bloc_api_test/models/post.dart';

class ApiState {
  final List<Post> posts;
  final List<Post> filteredPosts;
  final bool isLoading;

  ApiState({
    required this.posts,
    required this.filteredPosts,
    required this.isLoading,
  });

  ApiState copyWith({
    List<Post>? posts,
    List<Post>? filteredPosts,
    bool? isLoading,
  }) {
    return ApiState(
      posts: posts ?? this.posts,
      filteredPosts: filteredPosts ?? this.filteredPosts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory ApiState.initial() {
    return ApiState(posts: [], isLoading: false, filteredPosts: []);
  }
}
