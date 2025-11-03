import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../brick_breaker.dart';
import '../config.dart';
import '../services/supabase_service.dart';
import 'leaderboard_screen.dart';
import 'overlay_screen.dart';
import 'player_name_dialog.dart';
import 'score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
    game.onGameOver = _handleGameOver;
  }

  void _handleGameOver(int score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PlayerNameDialog(
        score: score,
        onSubmit: (name) async {
          await SupabaseService.saveScore(
            playerName: name,
            score: score,
          );
        },
      ),
    );
  }

  void _showLeaderboard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LeaderboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffa9d6e5), Color(0xfff2e8cf)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        ScoreCard(score: game.score),
                        Expanded(
                          child: FittedBox(
                            child: SizedBox(
                              width: gameWidth,
                              height: gameHeight,
                              child: GameWidget(
                                game: game,
                                overlayBuilderMap: {
                                  PlayState.welcome.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'TAP TO PLAY',
                                        subtitle: 'Use arrow keys or swipe',
                                      ),
                                  PlayState.gameOver.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'G A M E   O V E R',
                                        subtitle: 'Tap to Play Again',
                                      ),
                                  PlayState.won.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'Y O U   W O N ! ! !',
                                        subtitle: 'Tap to Play Again',
                                      ),
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: FloatingActionButton(
                  onPressed: _showLeaderboard,
                  backgroundColor: const Color(0xff184e77),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.leaderboard),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
