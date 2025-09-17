import 'package:hive/hive.dart';
import 'package:moviesproject/Core/Constants/api.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String subtitle;
  @HiveField(3)
  final String categ;
  @HiveField(4)
  final String posterPath;
  @HiveField(5)
  final double rating;
  @HiveField(6)
  final int duration;

  Movie({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categ,

    required this.posterPath,
    required this.rating,
    required this.duration,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? "No Title",
      subtitle: json['tagline'] ?? "No Subtitle",
      categ:
          (json['genres'] != null && json['genres'].isNotEmpty)
              ? json['genres'][0]['name']
              : "No Category",
      posterPath: json['poster_path'] ?? "",
      rating:
          json['vote_average'] != null
              ? (json['vote_average'] / 2) // Convert 10 → 5
              : 0.0,
      duration: json['runtime'] ?? 0,
    );
  }
  String get fullPosterPath {
    if (posterPath.isEmpty) {
      return "https://via.placeholder.com/150x220?text=No+Image";
    }
    return "https://image.tmdb.org/t/p/w500$posterPath";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,

      "categ": categ,

      "poster_path": posterPath,
      "rating": rating,
      "duration": duration,
    };
  }
}
