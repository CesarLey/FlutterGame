# 🎮 Brick Breaker Game

Un juego clásico de Brick Breaker desarrollado con Flutter y Flame Engine, con integración de Supabase para guardar puntuaciones en línea.

![Flutter](https://img.shields.io/badge/Flutter-3.8.0-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.0-0175C2?style=flat&logo=dart)
![Flame](https://img.shields.io/badge/Flame-1.28.1-FF6D00?style=flat)
![Supabase](https://img.shields.io/badge/Supabase-2.5.6-3ECF8E?style=flat&logo=supabase)

## 📋 Descripción

Brick Breaker es una reimplementación del clásico juego Breakout de Atari. Controla una paleta para mantener la pelota en juego mientras rompes todos los ladrillos de colores. El juego incluye un sistema de puntuación en línea, efectos de sonido y música de fondo.

## ✨ Características

### 🎯 Mecánicas del Juego
- **50 ladrillos coloridos** organizados en 5 filas
- **Física realista** de la pelota con detección de colisiones
- **Control de paleta** mediante teclado (flechas) o táctil
- **Sistema de puntuación** en tiempo real
- **Dificultad progresiva** - la pelota acelera al romper ladrillos

### 🎨 Interfaz de Usuario
- **Diseño retro** con fuente Press Start 2P
- **Animaciones fluidas** con Flutter Animate
- **Pantallas de estado**: Bienvenida, Jugando, Game Over y Victoria
- **Gradientes de colores** para una experiencia visual atractiva

### 🎵 Audio
- **Música de fondo** que se reproduce durante el juego
- **Efectos de sonido**:
  - Sonido al perder el juego
  - Sonido al romper ladrillos (opcional)
  - Sonido al ganar (opcional)

### 🏆 Sistema de Clasificación en Línea
- **Integración con Supabase** para almacenamiento en la nube
- **Tabla de clasificación** con los 5 mejores puntajes
- **Guardado de nombres** de jugadores
- **Medallas visuales** (oro, plata, bronce) para los top 3

## 🚀 Instalación

### Requisitos Previos

- Flutter SDK (3.8.0 o superior)
- Dart SDK (3.8.0 o superior)
- Android Studio / Xcode (para desarrollo móvil)
- Cuenta de Supabase (para funcionalidad de clasificación)

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/CesarLey/FlutterGame.git
cd FlutterGame/flutter_application_1
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Supabase** (opcional, para clasificación en línea)
   - Sigue las instrucciones en [SUPABASE_SETUP.md](SUPABASE_SETUP.md)
   - Crea una tabla `scores` en tu proyecto de Supabase
   - Actualiza las credenciales en `lib/src/config/supabase_config.dart`

4. **Agregar archivos de audio** (opcional)
   - Coloca tus archivos de audio en `assets/audio/`:
     - `background_music.mp3` - Música de fondo
     - `game_over.mp3` - Sonido al perder
     - `win.mp3` - Sonido al ganar (opcional)
     - `brick_hit.mp3` - Sonido al golpear ladrillos (opcional)

5. **Ejecutar la aplicación**
```bash
flutter run
```

## 🎮 Controles

### Teclado
- **Flecha Izquierda** ⬅️ - Mover paleta a la izquierda
- **Flecha Derecha** ➡️ - Mover paleta a la derecha
- **Espacio / Enter** - Iniciar juego

### Táctil
- **Tocar pantalla** - Iniciar juego
- **Arrastrar** - Mover paleta

## 🏗️ Estructura del Proyecto

```
lib/
├── brick_breaker.dart          # Clase principal del juego
├── main.dart                   # Punto de entrada
└── src/
    ├── components/             # Componentes del juego
    │   ├── ball.dart          # Pelota con física
    │   ├── bat.dart           # Paleta controlable
    │   ├── brick.dart         # Ladrillos destructibles
    │   ├── play_area.dart     # Área de juego
    │   └── components.dart    # Exportaciones
    ├── config/
    │   ├── config.dart        # Constantes del juego
    │   └── supabase_config.dart # Credenciales Supabase
    ├── services/
    │   ├── audio_service.dart    # Gestión de audio
    │   └── supabase_service.dart # Operaciones de base de datos
    └── widgets/
        ├── game_app.dart          # Widget principal
        ├── leaderboard_screen.dart # Tabla de clasificación
        ├── overlay_screen.dart     # Pantallas de estado
        ├── player_name_dialog.dart # Diálogo para guardar nombre
        └── score_card.dart         # Tarjeta de puntuación

assets/
└── audio/                      # Archivos de sonido
    ├── background_music.mp3
    ├── game_over.mp3
    ├── win.mp3 (opcional)
    └── brick_hit.mp3 (opcional)
```

## 📦 Dependencias

```yaml
dependencies:
  flutter: sdk
  flame: ^1.28.1              # Motor de juego 2D
  google_fonts: ^6.2.1        # Fuentes personalizadas
  flutter_animate: ^4.5.2     # Animaciones
  supabase_flutter: ^2.5.6    # Backend y base de datos
  audioplayers: ^6.1.0        # Reproducción de audio
```

## 🎨 Colores y Diseño

El juego utiliza una paleta de colores vibrante:
- **Ladrillos**: 10 colores diferentes (rojo, naranja, amarillo, verde, cian, azul, magenta, rosa, morado, lima)
- **Fondo**: Gradiente de azul claro a beige
- **Pelota**: Azul oscuro (#1e6091)
- **Paleta**: Azul (#184e77)

## 🏆 Sistema de Puntuación

- Cada ladrillo roto suma **1 punto**
- Los puntajes se guardan automáticamente al perder
- La tabla de clasificación muestra los 5 mejores puntajes
- Sistema de medallas:
  - 🥇 Oro - 1er lugar
  - 🥈 Plata - 2do lugar
  - 🥉 Bronce - 3er lugar

## 🔧 Configuración

### Audio
Puedes ajustar el volumen en `lib/src/services/audio_service.dart`:
```dart
await _musicPlayer.setVolume(0.5);  // Música al 50%
await _sfxPlayer.setVolume(0.7);    // Efectos al 70%
```

### Dificultad
Modifica la dificultad en `lib/src/config.dart`:
```dart
const double difficultyModifier = 1.03; // Incremento de velocidad
```

## 🐛 Solución de Problemas

### La música no se reproduce
- Verifica que los archivos de audio estén en `assets/audio/`
- Asegúrate de que los nombres coincidan exactamente
- Revisa los permisos de audio en el dispositivo

### El diálogo de nombre no aparece
- Verifica la configuración de Supabase
- Revisa la conexión a internet
- Consulta los logs de la consola para errores

### Errores de compilación
```bash
flutter clean
flutter pub get
flutter run
```

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 👨‍💻 Desarrollo

### Ejecutar en modo debug
```bash
flutter run
```

### Ejecutar en modo release
```bash
flutter run --release
```

### Generar APK para Android
```bash
flutter build apk --release
```

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Haz un Fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Contacto

Cesar Ley - [@CesarLey](https://github.com/CesarLey)

Link del Proyecto: [https://github.com/CesarLey/FlutterGame](https://github.com/CesarLey/FlutterGame)

## 🙏 Agradecimientos

- Tutorial base del juego Brick Breaker de Flutter
- [Flame Engine](https://flame-engine.org/) - Motor de juego 2D para Flutter
- [Supabase](https://supabase.com/) - Backend como servicio
- [Google Fonts](https://fonts.google.com/) - Fuentes tipográficas

---

⭐️ Si te gusta este proyecto, ¡dale una estrella en GitHub!

