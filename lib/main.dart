import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/Core/Services/movie_service.dart';
import 'package:moviesproject/Cubits/cubit/search_movie_cubit.dart';
import 'package:moviesproject/Cubits/cubit/save_movie_cubit.dart';
import 'package:moviesproject/Cubits/cubit/theme_cubit.dart';
import 'package:moviesproject/Models/movie_model.dart';
import 'package:moviesproject/Screens/search_page.dart';
import 'package:moviesproject/Screens/saved_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

//final String _moviesBox = 'moviesBox';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('moviesBox');
  await Hive.openBox<String>('recentSearchBox');
  final movieService = MovieService();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SaveMovieCubit()..getSavedMovies()),
        BlocProvider(create: (_) => SearchMovieCubit(movieService)),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<SaveMovieCubit, SaveMovieState>(
        builder: (BuildContext context, state) {
          return const MovieApp();
        },
      ),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context,  themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MOVIE APP",
          
          theme: ThemeData.light().copyWith(
           
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white, // color for selected label & icon
              unselectedItemColor: Colors.grey,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.red,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
            ),
          ),
          themeMode: themeMode, // 👈 controlled by cubit
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const SearchScreen(), const SavedScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        actions: [
          IconButton(
            icon: Icon(
              context.read<ThemeCubit>().state == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
           // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            currentIndex: _currentIndex,
            // selectedItemColor: Colors.white, // color for selected label & icon
            // unselectedItemColor: Colors.grey,

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Saved",
              ),
            ],
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
      ),
    );
  }
}
