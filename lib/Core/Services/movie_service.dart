import 'package:dio/dio.dart';
import 'package:moviesproject/Models/movie_model.dart'; 
import 'package:moviesproject/Core/Constants/api.dart';

class MovieService {
  final Dio _dio = Dio();

  
  Future<List<Movie>> searchMovies(String query) async {
    final response = await _dio.get(
      "${ApiService.baseUrl}/search/movie",
      queryParameters: {
        "api_key": ApiService.apiKey,
        "query": query,
        "language": "en-US",
      },
    );

    if (response.statusCode == 200 && response.data["results"] != null) {
      return (response.data["results"] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

 
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await _dio.get(
      "${ApiService.baseUrl}/movie/$movieId",
      queryParameters: {
        "api_key": ApiService.apiKey,
        "language": "en-US",
        "append_to_response": "credits", 
      },
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(response.data);
    } else {
      throw Exception("Failed to load movie details");
    }
  }
}
