# FACARTES Móvil (prototipo)
Prototipo navegable en Flutter (Material 3). Sin dependencias externas; la IA está simulada.

## Ejecutar
1. `cd facartes_movil`
2. `flutter create . --project-name facartes_movil --org co.udenar` (genera android/ios; no sobrescribe archivos existentes)
3. `flutter pub get && flutter run`

## Estructura
- `lib/core.dart`: tema, modelo `Artwork`, datos de ejemplo, widgets comunes
- `lib/screens/`: `shell`, `home_screen`, `assistant_screen`, `profile_screen`, `detail_screen`, `upload_flow`
- Puntos para la IA real: `AnalyzingScreen` (etiquetas/descripción) y `_AssistantScreenState._reply`

## Verificar
`flutter pub get && flutter analyze && flutter test`
