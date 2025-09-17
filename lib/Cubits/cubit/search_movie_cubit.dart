import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesproject/Core/Services/movie_service.dart';
import 'package:moviesproject/Models/movie_model.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {

  final MovieService _service;
    SearchMovieCubit(this._service) : super(SearchMovieInitial());

 Future<void> searchMovies(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;
    emit(SearchMovieLoading());
    try {
      final searchResults = await _service.searchMovies(q);
      final detailed = await Future.wait(
        searchResults.map((m) => _service.getMovieDetails(m.id)),
      );
      emit(SearchMovieLoaded(detailed));
    } catch (e) {
      emit(SearchMovieError(e.toString()));
    }
  }
}
