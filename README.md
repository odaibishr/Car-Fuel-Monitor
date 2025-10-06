# Car Fuel Monitor

A Flutter application to help drivers monitor fuel usage, discover nearby fuel stations, and navigate efficiently. The app provides real-time location features, routing, and a clean Arabic-first UI.

## Overview
Car Fuel Monitor aims to simplify day-to-day driving by combining live location data, station discovery, and user-friendly insights. It supports Arabic localization and follows a modular, scalable architecture using BLoC and dependency injection.

## Key Features
- Real-time location tracking and map view
- Nearby fuel stations discovery
- Route and distance calculation
- Authentication flow and user session handling
- Notifications screen for useful updates
- Beautiful Arabic-first UI using the Cairo font
- Routing via `go_router`
- State management with `bloc`/`flutter_bloc`

## Tech Stack
- Flutter (Material 3)
- State Management: `bloc`, `flutter_bloc`
- Routing: `go_router`
- Networking: `dio`, `http`
- Maps: `google_maps_flutter` and/or `flutter_map` (OpenStreetMap)
- Geolocation: `geolocator`, `location`
- Cloud Backends: `supabase_flutter`, `firebase_core`, `cloud_firestore`, `firebase_database`
- Utilities: `dartz`, `get_it`, `flutter_dotenv`

## Architecture
- Feature-first structure under `lib/features/`
- BLoC/Cubit for presentation state: see `lib/features/**/presentation/manager/`
- Repository pattern for data access: e.g., `lib/features/**/data/repos/`
- DI via `get_it`: initialized in `lib/injection_container.dart`
- Centralized routing in `lib/core/utils/app_route.dart`


## Environment Variables
This project loads environment variables from `.env` (see `lib/main.dart` and `pubspec.yaml`). Create a `.env` file in the project root with the following keys as needed:
```
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
# Optional, if you use external routing APIs like OpenRouteService
OPENROUTESERVICE_API_KEY=your_ors_api_key
# Optional, any additional keys
```

## Setup and Installation
1. Clone the repository
   ```bash
   git clone <repo-url>
   cd car_monitor
   ```
2. Create and fill your `.env` file (see Environment Variables section).
3. Get packages
   ```bash
   flutter pub get
   ```
4. Generate assets file (optional, if you use flutter_assets)
   - The project includes a `flutter_assets` config in `pubspec.yaml`. If you use a generator, run its command accordingly.

## Maps Configuration
- Google Maps (if using `google_maps_flutter`):
  - Android: add your API key in `android/app/src/main/AndroidManifest.xml` inside the `<application>` tag
    ```xml
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY" />
    ```
  - iOS: set the API key in `ios/Runner/AppDelegate.swift` or using `GMSServices.provideAPIKey("YOUR_API_KEY")` depending on your setup.
- OpenStreetMap (`flutter_map`): no API key required by default.
- Routing (if using `open_route_service`): provide `OPENROUTESERVICE_API_KEY` in `.env` and load it where needed.

## Supabase Configuration
- The app initializes Supabase in `lib/main.dart` using `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
- Create a Supabase project, copy the URL and anon key, and set them in `.env`.

