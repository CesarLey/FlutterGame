import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> _scores = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    setState(() => _isLoading = true);
    try {
      final scores = await SupabaseService.getTopScores();
      if (mounted) {
        setState(() {
          _scores = scores;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar ranking: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2e8cf),
      appBar: AppBar(
        title: Text(
          'Top 5 Jugadores',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: const Color(0xff184e77),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffa9d6e5), Color(0xfff2e8cf)],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _scores.isEmpty
                ? Center(
                    child: Text(
                      'No hay puntuaciones aún',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadScores,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _scores.length,
                      itemBuilder: (context, index) {
                        final score = _scores[index];
                        final position = index + 1;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 4,
                          color: position <= 3
                              ? _getMedalColor(position)
                              : Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff184e77),
                              child: Text(
                                '$position',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              score['player_name'] ?? 'Anónimo',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff184e77),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${score['score']} pts',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Color _getMedalColor(int position) {
    switch (position) {
      case 1:
        return const Color(0xffFFD700); // Oro
      case 2:
        return const Color(0xffC0C0C0); // Plata
      case 3:
        return const Color(0xffCD7F32); // Bronce
      default:
        return Colors.white;
    }
  }
}
