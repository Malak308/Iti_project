import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:moviesproject/Cubits/cubit/save_movie_cubit.dart';
import 'package:moviesproject/Models/movie_model.dart';

class SaveButton extends StatelessWidget {
  final Movie movie;
  const SaveButton({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveMovieCubit, SaveMovieState>(
      builder: (context, state) {
        bool isBookmarked = context.read<SaveMovieCubit>().isSaved(movie);
        return IconButton(
          onPressed: () {
            if (isBookmarked) {
              context.read<SaveMovieCubit>().removeMovie(movie);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${movie.title} removed!"),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              context.read<SaveMovieCubit>().saveMovie(movie);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${movie.title} saved!"),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
            color: isBookmarked ? const Color.fromARGB(255, 0, 0, 0) : null,
          ),
        );
      },
    );
  }
}
