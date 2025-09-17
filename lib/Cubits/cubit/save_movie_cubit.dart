import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:moviesproject/Models/movie_model.dart';
import 'package:moviesproject/main.dart';

part 'save_movie_state.dart';

class SaveMovieCubit extends Cubit<SaveMovieState> {
  SaveMovieCubit() : super(SaveMovieInitial());
  final String _moviesBox = 'moviesBox';
  Future<void> getSavedMovies() async {
    final box = Hive.box<Movie>(_moviesBox);
    final movies = box.values.toList();
    emit(SaveMovieLoaded(movies));
  }

  Future<void> saveMovie(Movie movie) async {
    final box = Hive.box<Movie>(_moviesBox);
    box.put(movie.id, movie);
    getSavedMovies();
  }
  Future<void>removeMovie(Movie movie) async {
    final box = Hive.box<Movie>(_moviesBox);
    box.delete(movie.id);
    getSavedMovies();
  }
  bool isSaved(Movie movie) {
  final box = Hive.box<Movie>(_moviesBox);
  return box.containsKey(movie.id);
}
 
}
