import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../../../../core/theme/color_styles.dart';
import '../../../../core/widgets/custom_loader.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.updateDistance});
  final Function(double) updateDistance;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  StreamSubscription<LocationData>? _locationSubscription;
  final String orsApiKey =
      '5b3ce3597851110001cf624848d6876fe8824e7699f98a83b94738bf';

  List<Map<String, dynamic>> fuelStations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  void _getCurrentLocation() async {
    var location = Location();

    try {
      var userLocation = await location.getLocation();
      if (!mounted) return;

      setState(() {
        currentLocation = userLocation;
        markers = [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child: const Icon(
              Icons.my_location,
              color: ColorStyles.primaryColor,
              size: 40.0,
            ),
          ),
        ];
      });

      await fetchNearbyFuelStations();
      if (fuelStations.isNotEmpty) {
        _navigateToNearestFuelStation();
      }
    } on Exception catch (e) {
      log("Location error: $e");
      currentLocation = null;
    }

    _locationSubscription =
        location.onLocationChanged.listen((LocationData newLocation) {
          if (mounted) {
            setState(() {
              currentLocation = newLocation;
            });
          }
        });
  }

  Future<void> fetchNearbyFuelStations() async {
    if (currentLocation == null) return;

    double lat = currentLocation!.latitude!;
    double lon = currentLocation!.longitude!;
    double radius = 5000; // نصف قطر البحث (5 كم)

    final overpassUrl =
        "https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=fuel](around:$radius,$lat,$lon);out;";

    try {
      final response = await http.get(Uri.parse(overpassUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          fuelStations = (data['elements'] as List)
              .where((element) =>
          element.containsKey('lat') && element.containsKey('lon'))
              .map((element) => {
            "name": element['tags']?['name'] ?? "محطة وقود غير معروفة",
            "latitude": element['lat'],
            "longitude": element['lon'],
            "address": element['tags']?['addr:street'] ?? "غير متوفر"
          })
              .toList();
        });
      } else {
        log("Failed to fetch fuel stations: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching fuel stations: $e");
    }
  }

  Map<String, dynamic>? getNearestFuelStation() {
    if (currentLocation == null || fuelStations.isEmpty) return null;

    LatLng userLocation =
    LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    Map<String, dynamic>? nearestStation;
    double minDistance = double.infinity;

    for (var station in fuelStations) {
      double distance = const Distance().as(
        LengthUnit.Kilometer,
        userLocation,
        LatLng(station['latitude'], station['longitude']),
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station;
      }
    }

    if (nearestStation != null) {
      widget.updateDistance(minDistance);
    } else {
      widget.updateDistance(0.0);
    }

    return nearestStation;
  }

  void _navigateToNearestFuelStation() {
    var nearestStation = getNearestFuelStation();
    if (nearestStation != null) {
      _getRoute(
        LatLng(nearestStation['latitude'], nearestStation['longitude']),
      );
    }
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null || !mounted) return;

    final start =
    LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );

    if (response.statusCode == 200 && mounted) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
      data['features'][0]['geometry']['coordinates'];

      setState(() {
        routePoints =
            coords.map((coord) => LatLng(coord[1], coord[0])).toList();

        // إضافة marker للمحطة (بعد حذف أي marker قديم خاص بالمحطة)
        markers.removeWhere((m) => m.child is Icon && (m.child as Icon).icon == Icons.location_on);
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: destination,
            child: const Icon(
              Icons.location_on,
              color: ColorStyles.primaryColor,
              size: 40.0,
            ),
          ),
        );
      });
    } else {
      log('Failed to fetch route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الخريطة',
          style: TextStyle(color: ColorStyles.whiteColor),
        ),
        backgroundColor: ColorStyles.primaryColor,
      ),
      body: currentLocation == null
          ? const Center(child: CustomLoader(loaderSize: 40))
          : FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
          PolylineLayer(
            polylines: routePoints.isNotEmpty
                ? [
              Polyline<Object>(
                points: routePoints,
                strokeWidth: 4.0,
                color: ColorStyles.primaryColor,
              ),
            ]
                : <Polyline<Object>>[],
          ),


        ],
      ),
    );
  }
}
