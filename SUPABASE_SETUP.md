# Configuración de Supabase para Brick Breaker

## Pasos para configurar la base de datos:

### 1. Crear cuenta en Supabase
- Ve a https://supabase.com
- Crea una cuenta gratuita
- Crea un nuevo proyecto

### 2. Crear la tabla de puntuaciones
En el editor SQL de Supabase (SQL Editor), ejecuta este código:

```sql
-- Crear tabla de puntuaciones
CREATE TABLE scores (
  id BIGSERIAL PRIMARY KEY,
  player_name TEXT NOT NULL,
  score INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::TEXT, NOW()) NOT NULL
);

-- Crear índice para ordenar por puntuación
CREATE INDEX idx_scores_score ON scores(score DESC);

-- Habilitar Row Level Security (RLS)
ALTER TABLE scores ENABLE ROW LEVEL SECURITY;

-- Política para permitir lectura a todos
CREATE POLICY "Permitir lectura a todos" 
ON scores FOR SELECT 
TO public 
USING (true);

-- Política para permitir inserción a todos
CREATE POLICY "Permitir inserción a todos" 
ON scores FOR INSERT 
TO public 
WITH CHECK (true);
```

### 3. Obtener las credenciales
1. Ve a Settings > API
2. Copia tu **Project URL**
3. Copia tu **anon public key**

### 4. Configurar en el proyecto
Edita el archivo `lib/src/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://tu-proyecto.supabase.co';
  static const String supabaseAnonKey = 'tu-clave-publica-aqui';
}
```

### 5. ¡Listo!
Ahora el juego guardará automáticamente las puntuaciones cuando el jugador pierda.

## Características implementadas:
- ✅ Diálogo para ingresar nombre al perder
- ✅ Guardar puntuación en Supabase
- ✅ Botón de ranking (icono de trofeo)
- ✅ Top 5 mejores puntuaciones
- ✅ Colores especiales para medallas (oro, plata, bronce)
- ✅ Pull to refresh en el ranking
