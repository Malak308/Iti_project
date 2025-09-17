import 'package:flutter/material.dart';
import 'package:moviesproject/Models/movie_model.dart';
import 'package:moviesproject/Widgets/save_button.dart';

class MovieCardCopy extends StatelessWidget {
  final Movie movie;
  final Widget? trailing;

  const MovieCardCopy({super.key, required this.movie, this.trailing});

  String timeInHours(int t) {
    int h = 0;
    while (t >= 60) {
      t -= 60;
      h++;
    }
    if (h >= 1) {
      return '${h}h ${t}m';
    } else {
      return '${t}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access current theme colors
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color; // adapts automatically
    final subtitleColor = theme.textTheme.bodySmall?.color?.withOpacity(0.7);

    return Card(
      margin: const EdgeInsets.all(8),
    
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 120,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    movie.fullPosterPath.isNotEmpty
                        ? movie.fullPosterPath
                        : 'https://picsum.photos/200/300',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: movie.title + ' ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: movie.subtitle,
                          style: TextStyle(fontSize: 14, color: subtitleColor),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        movie.rating.floor(),
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${movie.rating.toStringAsFixed(1)}/5',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      movie.categ,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_sharp,
                            size: 16,
                            color: subtitleColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${timeInHours(movie.duration)}',
                            style: TextStyle(color: subtitleColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: SaveButton(movie: movie),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
