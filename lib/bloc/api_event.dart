abstract class ApiEvent {}

class GetPostListEvent extends ApiEvent {}

class AddPostEvent extends ApiEvent {
  final String title;
  final String body;

  AddPostEvent({required this.title, required this.body});
}

class SearchPostEvent extends ApiEvent {
  final String searchQuery;

  SearchPostEvent({required this.searchQuery});
}
