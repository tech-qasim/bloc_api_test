import 'package:bloc_api_test/models/post.dart';

class ApiState {
  final List<Post> posts;
  final List<Post> filteredPosts;
  final bool isLoading;
  final int startPage;
  final bool hasMoreData;
  final bool isFetchign;

  ApiState({
    required this.posts,
    required this.filteredPosts,
    required this.isLoading,
    required this.startPage,
    required this.hasMoreData,
    required this.isFetchign,
  });

  ApiState copyWith({
    List<Post>? posts,
    List<Post>? filteredPosts,
    bool? isLoading,
    int? startPage,
    bool? hasMoreData,
    bool? isFetchign,
  }) {
    return ApiState(
      posts: posts ?? this.posts,
      filteredPosts: filteredPosts ?? this.filteredPosts,
      isLoading: isLoading ?? this.isLoading,
      startPage: startPage ?? this.startPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isFetchign: isFetchign ?? this.isFetchign,
    );
  }

  factory ApiState.initial() {
    return ApiState(
      isFetchign: false,
      hasMoreData: true,
      posts: [],
      isLoading: false,
      filteredPosts: [],
      startPage: 10,
    );
  }
}
