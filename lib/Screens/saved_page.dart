import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/Cubits/cubit/save_movie_cubit.dart';

import 'package:moviesproject/Models/movie_model.dart';
import 'package:moviesproject/Widgets/movie_card%20copy.dart';

import 'package:moviesproject/Widgets/save_button.dart';

class SavedScreen extends StatelessWidget {

  const SavedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveMovieCubit, SaveMovieState>(
      builder: (context, state) {
        if (state is SaveMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return const Center(child: Text("No saved movies yet"));
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saved Movies',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final Movie movie = state.movies[index];
                        //  final Movie movie = movies[index];
                        return MovieCardCopy(
                          movie: movie,
                          trailing: SaveButton(movie: movie),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Always return a widget for other states
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
