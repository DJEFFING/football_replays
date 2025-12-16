import 'package:flutter/material.dart';
import 'package:football_replays/presentation/providers/match_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/search_bar_widget.dart';
import '../widgets/match_card.dart';

class MatchesListPage extends StatefulWidget {
  const MatchesListPage({super.key});

  @override
  State<MatchesListPage> createState() => _MatchesListPageState();
}

class _MatchesListPageState extends State<MatchesListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MatchProvider>(context, listen: false).loadMatches());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matchs disponibles"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, _) {
          /// LOADING ?
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// ERREUR ?
          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          /// LISTE DES MATCHS
          final matches = provider.filterMatches;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                /// SEARCH BAR
                SearchBarWidget(
                  controller: _searchController,
                  // hintText: "Rechercher un match...",
                  onChanged: (value) {
                    provider.searchMatches(value);
                  },
                  onClear: () {
                    provider.searchMatches("");
                  },
                ),

                const SizedBox(height: 16),

                /// LISTE
                Expanded(
                  child: ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final match = matches[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: MatchCard(
                          match: match,
                          onTap: () {
                            print("Match sélectionné : ${match.title}");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => MatchDetailPage(match: match),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
