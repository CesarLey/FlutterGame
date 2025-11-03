# Audio Assets

Esta carpeta contiene los archivos de audio del juego Brick Breaker.

## Archivos Requeridos

Coloca los siguientes archivos de audio en esta carpeta:

### Música de Fondo
- **background_music.mp3** - Música que se reproduce durante el juego
  - Se reproduce en loop mientras el jugador está jugando
  - Se detiene cuando el juego termina o el jugador gana/pierde

### Efectos de Sonido
- **game_over.mp3** - Sonido que se reproduce cuando el jugador pierde
  - Se reproduce una vez cuando la pelota cae al fondo
  
- **win.mp3** (Opcional) - Sonido que se reproduce cuando el jugador gana
  - Se reproduce cuando se rompen todos los ladrillos

- **brick_hit.mp3** (Opcional) - Sonido que se reproduce al golpear un ladrillo
  - Se reproduce cada vez que la pelota golpea un ladrillo

## Formatos Soportados

El paquete `audioplayers` soporta los siguientes formatos:
- MP3
- WAV
- OGG
- AAC
- M4A

## Notas

- Los archivos deben tener exactamente los nombres listados arriba
- Se recomienda usar archivos MP3 para mejor compatibilidad
- Mantén los archivos de audio pequeños (menos de 1MB) para mejor rendimiento
- El volumen de la música se establece en 50%
- El volumen de los efectos de sonido se establece en 70%

## Estructura de Carpetas

```
assets/
└── audio/
    ├── background_music.mp3    (requerido)
    ├── game_over.mp3           (requerido)
    ├── win.mp3                 (opcional)
    └── brick_hit.mp3           (opcional)
```
