part of 'save_movie_cubit.dart';

@immutable
sealed class SaveMovieState {}

 class SaveMovieInitial extends SaveMovieState {}


class SaveMovieLoaded extends SaveMovieState {
  final List<Movie> movies;
  SaveMovieLoaded(this.movies);
}
