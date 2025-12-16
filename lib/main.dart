import 'package:flutter/material.dart';
import 'package:football_replays/data/datasources/score_bat_api.dart';
import 'package:football_replays/data/repositories/match_repository_impl.dart';
import 'package:football_replays/domain/usecases/get_Match.dart';
import 'package:football_replays/domain/usecases/search_matches.dart';
import 'package:football_replays/presentation/pages/matches_list_page.dart';
import 'package:football_replays/presentation/providers/match_provider.dart';
import 'package:football_replays/presentation/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

void main() {
  // Initialisation des dépendances
  WidgetsFlutterBinding.ensureInitialized();
  final api = ScoreBatApi();
  final repository = MatchRepositoryImpl(api);
  final getMatches = GetMatches(repository);
  final searchMatches = SearchMatches();

  runApp(
    ChangeNotifierProvider(
      create: (_) => MatchProvider(
        getMatchesUseCase: getMatches,
        searchMatchesUseCase: searchMatches,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MatchesListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SearchBarWidget searchBarWidget = const SearchBarWidget();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                searchBarWidget,
                const Text(
                  'You have pushed the button this many times:',
                ),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
