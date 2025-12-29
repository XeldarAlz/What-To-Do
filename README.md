[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/XeldarAlz)
[![License](https://img.shields.io/badge/license-Non--Commercial-red.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.10.0-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/platform-cross--platform-lightgrey.svg)]()
[![Sponsor](https://img.shields.io/badge/sponsor-30363D?style=flat-square&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/XeldarAlz)

> **Language**: [English](README.md) | [Türkçe](README_TR.md)

# What Should We Do?

A simple Flutter application that quickly shows activities to do near your location. After granting location permission, with a single tap you'll see a random activity, motivational message, image, and nearby place suggestions related to that activity.

The app is organized into feature-focused packages like `location`, `activities`, `places`, `home`, and `audio`, and works with Google Maps / Places API.

<img src="docs/screenshots/app_ui_1.png" alt="What Should We Do interface 1" width="250" /> <img src="docs/screenshots/app_ui_2.png" alt="What Should We Do interface 2" width="250" /> <img src="docs/screenshots/app_ui_3.png" alt="What Should We Do interface 3" width="250" />

## Features

- **Random Activity Generation**:  
  After getting your location, the "What should we do?" button generates a random activity, message, and image.

- **Nearby Place Suggestions**:  
  Places suitable for the selected activity in the nearby area are fetched from Google Places.

- **Sorting and Pagination**:  
  Place results are sorted by distance, displayed in chunks (pagination), and more results can be loaded if desired.

- **Rich Visual Experience**:  
  Activity cards are enhanced with animations, gradients, and confetti effects; images can be fetched from Unsplash.

- **Feedback and Sound Effects**:  
  Successful results provide user feedback with light vibration, confetti, and star sound effects.

## Architecture Overview

The project is structured under `lib/` following a feature-first approach:

- **`core/`**
  - Common constants (`app_constants.dart`)
  - Theme definition (`app_theme.dart`)
  - Common exports (`core.dart`)

- **`features/activities/`**
  - `models/activity.dart`: Activity model
  - `data/activity_repository.dart`: Manages activity list and categories
  - `data/message_repository.dart`: Generates messages accompanying activities
  - `data/unsplash_service.dart`: Fetches random images suitable for activities from Unsplash API

- **`features/location/`**
  - `location_service.dart`:  
    - Checks location permissions  
    - Gets the user's current location  
    - Throws custom `LocationException` in error cases

- **`features/places/`**
  - `data/places_repository.dart`:  
    - Searches for nearby places via Google Places API  
    - Converts place results to project-specific models
  - `models/place_suggestion.dart`: Place suggestion model
  - `utils/places_sorter.dart`: Sorts places by distance and other criteria

- **`features/audio/`**
  - `sound_service.dart`: Plays success sound using `assets/sounds/star_sparkle.mp3` file
  - `audio.dart`: Feature export file

- **`features/home/`**
  - `presentation/home_page.dart`:  
    - Location permission request  
    - Activity generation flow  
    - Display, sorting, and "load more" functionality for place list  
    - Error message display  
  - `widgets/activity_result_card.dart`: Displays activity card
  - `widgets/place_result_tile.dart`: Displays place row
  - `utils/activity_generator.dart`:  
    - Orchestration class that generates activity, message, image, and place results together

- **`main.dart` & `app.dart`**
  - `main.dart`: Application entry point
  - `app.dart`:  
    - `MaterialApp` configuration  
    - Title (`What Should We Do?`), theme, and `HomePage` as the starting screen

## API Keys and Running

The app works with Google Maps / Places and optionally Unsplash API keys.

- **Google Maps / Places API**: Used for nearby place suggestions.
- **Unsplash API** (optional): Used for activity images.

You can run the app in development environment as follows:

```bash
flutter pub get
flutter run \
  --dart-define=GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_KEY \
  --dart-define=UNSPLASH_API_KEY=YOUR_UNSPLASH_KEY
```

The Unsplash key is optional but recommended for a richer visual experience.  
Remember to manage API keys securely using `.env`-like environment variables or CI settings.

## Technologies

- **Flutter** (customized, close to Material 3 theme)
- **geolocator**: Location permission and coordinate retrieval
- **url_launcher**: Opening places via Google Maps
- **confetti**: Confetti animation
- **audioplayers**: Success sounds

## License

This project is licensed under a **Non-Commercial License**. See the [LICENSE](LICENSE) file for details.

**Non-Commercial Use Only**: This software and associated documentation files (the "Software") are provided for personal, educational, and non-commercial use only. You may not use this Software for any commercial purpose without explicit written permission from the copyright holder.

## Sponsors

If you find this project useful, consider supporting it:

[![Sponsor](https://img.shields.io/badge/Sponsor-EA4AAA?style=for-the-badge&logo=github-sponsors&logoColor=white)](https://github.com/sponsors/XeldarAlz)

Your support helps maintain and improve this project.

---

<div align="center">

⭐ Star this repo if you find it interesting!

</div>
