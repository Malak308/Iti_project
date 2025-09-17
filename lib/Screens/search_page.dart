import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/Cubits/cubit/search_movie_cubit.dart';

import 'package:moviesproject/Widgets/movie_card copy.dart';
import 'package:moviesproject/Widgets/save_button.dart';
import 'package:moviesproject/Models/movie_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch() {
    final query = _controller.text;
    context.read<SearchMovieCubit>().searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search movies",
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 1,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onFieldSubmitted: (_) => _onSearch(),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<SearchMovieCubit, SearchMovieState>(
                builder: (context, state) {
                  if (state is SearchMovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchMovieLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final Movie movie = movies[index];
                        return MovieCardCopy(
                          movie: movie,
                          trailing: SaveButton(movie: movie),
                        );
                      },
                    );
                  }
                  if (state is SearchMovieError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: Text('Search for a movie...'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
