import 'package:bloc_api_test/bloc/api_event.dart';
import 'package:bloc_api_test/bloc/api_state.dart';
import 'package:bloc_api_test/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiRepository apiRepo;
  ApiBloc(this.apiRepo) : super(ApiState.initial()) {
    on<GetPostListEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final response = await apiRepo.fetchPosts();
      if (response.isNotEmpty) {
        emit(state.copyWith(posts: response, filteredPosts: response));
      }

      emit(state.copyWith(isLoading: false));
    });

    on<GetInitialPosts>((event, emit) async {
      final response = await apiRepo.fetchPostsByBatch(0, 20);
      if (response.isNotEmpty) {
        emit(state.copyWith(posts: [...state.posts, ...response]));
      }
    });

    on<GetPostListByBatchEvent>((event, emit) async {
      if (!state.hasMoreData || state.isFetchign) {
        return;
      }

      emit(state.copyWith(isFetchign: true));

      int limit = 10;
      final response = await apiRepo.fetchPostsByBatch(
        state.startPage + limit, //20 + 10 = 30
        limit,
      );
      if (response.isNotEmpty) {
        emit(
          state.copyWith(
            posts: [...state.posts, ...response],
            startPage: state.startPage + limit, //0+20 = 20
            isFetchign: false,
          ),
        );
      } else {
        emit(state.copyWith(hasMoreData: false, isFetchign: false));
      }
    });

    on<AddPostEvent>((event, emit) async {
      final response = await apiRepo.addPost({
        "title": event.title,
        "body": event.body,
        "userId": 77,
      });

      if (response != null) {
        emit(
          state.copyWith(
            posts: [...state.posts, response],
            filteredPosts: [...state.filteredPosts, response],
          ),
        );
      }
    });

    on<SearchPostEvent>((event, emit) {
      if (event.searchQuery.isNotEmpty) {
        final filtered = state.posts
            .where(
              (post) => post.title.toLowerCase().contains(
                event.searchQuery.toLowerCase(),
              ),
            )
            .toList();

        emit(state.copyWith(filteredPosts: filtered));
      } else {
        emit(state.copyWith(filteredPosts: state.posts));
      }
    });
  }
}
