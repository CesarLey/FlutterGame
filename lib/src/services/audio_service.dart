import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;

  // Inicializar el servicio de audio
  Future<void> initialize() async {
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(0.5);
    await _sfxPlayer.setVolume(0.7);
  }

  // Reproducir música de fondo
  Future<void> playBackgroundMusic() async {
    if (!_isMusicEnabled) return;
    
    try {
      await _musicPlayer.play(AssetSource('audio/background_music.mp3'));
    } catch (e) {
      print('Error al reproducir música de fondo: $e');
    }
  }

  // Detener música de fondo
  Future<void> stopBackgroundMusic() async {
    await _musicPlayer.stop();
  }

  // Pausar música de fondo
  Future<void> pauseBackgroundMusic() async {
    await _musicPlayer.pause();
  }

  // Reanudar música de fondo
  Future<void> resumeBackgroundMusic() async {
    if (!_isMusicEnabled) return;
    await _musicPlayer.resume();
  }

  // Reproducir sonido de game over
  Future<void> playGameOverSound() async {
    if (!_isSfxEnabled) return;
    
    try {
      await _sfxPlayer.play(AssetSource('audio/game_over.mp3'));
    } catch (e) {
      print('Error al reproducir sonido de game over: $e');
    }
  }

  // Reproducir sonido de victoria
  Future<void> playWinSound() async {
    if (!_isSfxEnabled) return;
    
    try {
      await _sfxPlayer.play(AssetSource('audio/win.mp3'));
    } catch (e) {
      print('Error al reproducir sonido de victoria: $e');
    }
  }

  // Reproducir sonido de colisión con ladrillo
  Future<void> playBrickHitSound() async {
    if (!_isSfxEnabled) return;
    
    try {
      await _sfxPlayer.play(AssetSource('audio/brick_hit.mp3'));
    } catch (e) {
      print('Error al reproducir sonido de ladrillo: $e');
    }
  }

  // Habilitar/deshabilitar música
  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      resumeBackgroundMusic();
    } else {
      pauseBackgroundMusic();
    }
  }

  // Habilitar/deshabilitar efectos de sonido
  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  // Configurar volumen de música (0.0 a 1.0)
  Future<void> setMusicVolume(double volume) async {
    await _musicPlayer.setVolume(volume);
  }

  // Configurar volumen de efectos (0.0 a 1.0)
  Future<void> setSfxVolume(double volume) async {
    await _sfxPlayer.setVolume(volume);
  }

  // Limpiar recursos
  Future<void> dispose() async {
    await _musicPlayer.dispose();
    await _sfxPlayer.dispose();
  }

  // Getters
  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
}
