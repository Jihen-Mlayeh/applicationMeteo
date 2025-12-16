# ☁️ Application Météo - Flutter Weather App


## 🌤️ Aperçu

Application météo complète développée en Flutter utilisant l'API OpenWeatherMap pour afficher les conditions météorologiques en temps réel de n'importe quelle ville dans le monde.

### ✨ Points Forts

- 🌍 **Recherche Mondiale** : N'importe quelle ville
- 📊 **Données Complètes** : Température, humidité, vent, etc.
- 📅 **Prévisions 7 jours** : Prévisions détaillées
- 🎨 **Design Glassmorphism** : Interface moderne
- ⚡ **Temps Réel** : Données actualisées
- 🌈 **Thème Dynamique** : Couleurs selon la météo

---

## ⚡ Fonctionnalités

### Météo Actuelle

- 🌡️ **Température** actuelle et ressentie
- 💧 **Humidité** en pourcentage
- 💨 **Vitesse du vent** en m/s
- 👁️ **Visibilité** en kilomètres
- 📊 **Pression atmosphérique** en hPa
- 🌅 **Heures** de lever et coucher du soleil
- 📍 **Localisation** (ville + pays)

### Prévisions

- 📅 **7 jours** de prévisions
- 🌡️ **Températures** min/max
- ☁️ **Conditions météo** détaillées
- 🎨 **Icônes** adaptées (emoji)

### Interface

- ✅ Barre de recherche intuitive
- ✅ Carte météo principale glassmorphism
- ✅ Grille d'informations supplémentaires
- ✅ Cartes de prévisions horizontales
- ✅ Animations fluides (fade-in, slide-in)
- ✅ Gestion d'erreurs élégante
- ✅ Loading indicators

---

## 📦 Prérequis

### Logiciels Requis

- **Flutter SDK** : `>= 3.10.1`
- **Dart SDK** : `>= 3.10.1`
- **Android Studio** / **VS Code**
- **Git**
- **Compte OpenWeatherMap** (gratuit)

### Vérification

```bash
flutter --version
dart --version
flutter doctor -v
```

---

## 🚀 Installation

### 1. Cloner le Repository

```bash
git clone https://github.com/Jihen-Mlayeh/applicationMeteo
cd applicationMeteo
```

### 2. Installer les Dépendances

```bash
flutter pub get
```

### 3. Configurer l'API Key

Voir section [Configuration API](#configuration-api).

### 4. Lancer l'Application

```bash
# Android
flutter run

# iOS (macOS uniquement)
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

---

## 🔑 Configuration API

### Obtenir une Clé API OpenWeatherMap

1. **Créer un compte** : [openweathermap.org/api](https://openweathermap.org/api)
2. **S'inscrire** gratuitement
3. **Générer une clé API** (gratuite, 1000 appels/jour)
4. **Activer** la clé (peut prendre 1-2 heures)

### Configurer la Clé dans l'Application

#### Méthode 1 : Directement dans le code

Ouvrez `lib/screens/weather_screen.dart` :

```dart
final WeatherService _weatherService = WeatherService(
  apiKey: 'VOTRE_CLE_API_ICI', // ← Remplacez ici
);
```



### Limites API Gratuites

| Plan | Appels/jour | Appels/minute | Prévisions |
|------|-------------|---------------|------------|
| Free | 1,000 | 60 | 5 jours |
| Startup | 100,000 | - | 16 jours |
| Developer | 1,000,000 | - | 16 jours |

---

## 📁 Structure du Projet

```
lib/
├── main.dart                          # Point d'entrée
│
├── models/                            # Modèles de données
│   └── weather_model.dart
│       ├── WeatherData               # Météo actuelle
│       └── ForecastData              # Prévisions
│
├── services/                          # Services & API
│   └── weather_service.dart
│       ├── getCurrentWeather()       # Météo actuelle
│       ├── getForecast()             # Prévisions
│       └── getWeatherAndForecast()   # Combiné
│
├── widgets/                           # Composants UI
│   ├── search_section.dart           # Barre de recherche
│   ├── current_weather_card.dart     # Carte météo principale
│   ├── additional_info_card.dart     # Infos supplémentaires
│   ├── forecast_section.dart         # Section prévisions
│   └── forecast_card.dart            # Carte prévision
│
├── screens/                           # Écrans
│   └── weather_screen.dart           # Écran principal
│
└── utils/                             # Utilitaires
    └── weather_utils.dart
        ├── getWeatherIcon()          # Emoji météo
        ├── getWeatherColor()         # Couleurs
        ├── formatTime()              # Formatage temps
        ├── formatDate()              # Formatage date
        └── formatDay()               # Formatage jour
```

---

## ⚙️ Configuration

### `pubspec.yaml`

```yaml
name: meteo_app2
description: Application météo Flutter

environment:
  sdk: ^3.10.1

dependencies:
  flutter:
    sdk: flutter
  
  # HTTP & API
  http: ^1.1.0
  
  # Formatage dates
  intl: ^0.19.0
  
  # UI
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
```

### Installation des Packages

```bash
# HTTP pour les appels API
flutter pub add http

# Intl pour le formatage des dates
flutter pub add intl
```

---

## 🎮 Utilisation

### Recherche de Ville

1. **Tapez** le nom de la ville dans la barre de recherche
2. **Appuyez** sur Entrée ou cliquez sur la flèche →
3. **Attendez** le chargement (1-2 secondes)
4. **Visualisez** les données météo

### Format de Recherche

```
✅ Paris
✅ London
✅ New York
✅ Tokyo
✅ Montpellier
✅ Jemmal

❌ paris (pas de majuscule)
❌ P@ris (caractères spéciaux)
```

### Navigation

```
Écran Principal
    ├── Barre de recherche
    ├── Carte météo actuelle
    ├── Informations détaillées (6 items)
    └── Prévisions 4 jours (scroll horizontal)
```

---

## 🏗️ Architecture

### Clean Architecture

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│      (Screens, Widgets, UI)             │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         BUSINESS LOGIC LAYER            │
│      (Services, Use Cases)              │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│            DATA LAYER                   │
│      (Models, API, Repository)          │
└─────────────────────────────────────────┘
```

### Flow de Données

```
User Input (Ville)
    ↓
WeatherScreen
    ↓
WeatherService.getWeatherAndForecast()
    ↓
HTTP GET → OpenWeatherMap API
    ↓
JSON Response
    ↓
WeatherData.fromJson()
ForecastData.fromJson()
    ↓
setState()
    ↓
UI Update avec Animations
```
### Production

| Package | Version | Usage |
|---------|---------|-------|
| `http` | ^1.1.0 | Appels API REST |
| `intl` | ^0.19.0 | Formatage dates/heures |

### Dev

| Package | Version | Usage |
|---------|---------|-------|
| `flutter_test` | SDK | Tests unitaires |
| `flutter_lints` | ^6.0.0 | Linter Dart |

### Installation

```bash
flutter pub add http
flutter pub add intl
```

---



🌤️ Bonne météo à tous ! ☀️
