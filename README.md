[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/XeldarAlz)
[![License](https://img.shields.io/badge/license-Non--Commercial-red.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.10.0-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/platform-cross--platform-lightgrey.svg)]()
[![Sponsor](https://img.shields.io/badge/sponsor-30363D?style=flat-square&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/XeldarAlz)

> **Language**: [English](README.md) | [Türkçe](README_TR.md)

# What Should We Do?

A simple Flutter application that quickly shows activities to do near your location. After granting location permission, with a single tap you'll see a random activity, motivational message, image, and nearby place suggestions related to that activity.

The app is organized into feature-focused modules and works with Google Maps / Places API.

<img src="docs/screenshots/app_ui_1.png" alt="What Should We Do interface 1" width="250" /> <img src="docs/screenshots/app_ui_2.png" alt="What Should We Do interface 2" width="250" /> <img src="docs/screenshots/app_ui_3.png" alt="What Should We Do interface 3" width="250" />

## ✨ Features

- **🎲 Random Activity Generation**  
  Get personalized activity suggestions based on your location with motivational messages and beautiful visuals.

- **📍 Nearby Place Suggestions**  
  Discover places suitable for your selected activity using Google Places API with real-time distance calculations.

- **📊 Smart Sorting & Pagination**  
  Results are intelligently sorted by distance and displayed efficiently with pagination support.

- **🎨 Rich Visual Experience**  
  Beautiful activity cards with smooth animations, gradients, and confetti effects. High-quality images from Unsplash.

- **🔔 Interactive Feedback**  
  Haptic feedback, confetti animations, and sound effects enhance the user experience.

## 🏗️ Architecture

The project follows a **feature-first architecture** with clear separation of concerns:

### 🎯 Core Layer
Shared utilities and configurations used across the entire application:
- **Constants**: App-wide configuration values and dimensions
- **Theme System**: Comprehensive color palette, typography, and Material 3 theming with full dark mode support
- **Gradients**: Reusable gradient definitions for visual consistency

### 📦 Feature Modules

#### **Activities**
Manages activity data and content generation:
- Activity models and categories
- Motivational message generation
- Image fetching from Unsplash API

#### **Location**
Handles all location-related functionality:
- Permission management
- Current location retrieval
- Error handling with custom exceptions

#### **Places**
Integrates with Google Places API:
- Nearby place search and discovery
- Place data transformation and modeling
- Distance-based sorting algorithms

#### **Audio**
Provides audio feedback:
- Sound effect playback
- Asset management for audio resources

#### **Home**
Main UI and user interaction:
- Activity generation orchestration
- Location permission flow
- Place list display with sorting and pagination
- Error state management
- Reusable UI components (cards, tiles)

### 🔄 Data Flow

```
User Action → Location Service → Activity Generator → 
Places Repository → UI Components → User Feedback
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.10.0)
- Google Maps / Places API key
- Unsplash API key (optional, but recommended)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app with API keys:
   ```bash
   flutter run \
     --dart-define=GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_KEY \
     --dart-define=UNSPLASH_API_KEY=YOUR_UNSPLASH_KEY
   ```

> **Note**: The Unsplash API key is optional but recommended for a richer visual experience. Always manage API keys securely using environment variables or CI/CD settings.

## 🛠️ Tech Stack

- **Framework**: Flutter with Material 3 design
- **Location**: Geolocator for location services
- **Maps**: Google Maps / Places API integration
- **Images**: Unsplash API for high-quality visuals
- **Animations**: Confetti effects and smooth transitions
- **Audio**: Audio players for sound feedback

## 📄 License

This project is licensed under a **Non-Commercial License**. See the [LICENSE](LICENSE) file for details.

**Non-Commercial Use Only**: This software is provided for personal, educational, and non-commercial use only. Commercial use requires explicit written permission from the copyright holder.

## 💝 Sponsors

If you find this project useful, consider supporting it:

[![Sponsor](https://img.shields.io/badge/Sponsor-EA4AAA?style=for-the-badge&logo=github-sponsors&logoColor=white)](https://github.com/sponsors/XeldarAlz)

Your support helps maintain and improve this project.

---

<div align="center">

⭐ Star this repo if you find it interesting!

</div>
