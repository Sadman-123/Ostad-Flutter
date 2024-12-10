import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  late Timer _timer;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _startLocationUpdates();
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission is required.')),
      );
    }
  }

  Future<LatLng> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching location: $e');
      throw e;
    }
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(Duration(seconds: 10), (_) async {
      try {
        LatLng newPosition = await _getCurrentLocation();
        setState(() {
          _polylineCoordinates.add(newPosition);
          _currentPosition = newPosition;
          _markers = {
            Marker(
              markerId: MarkerId('currentLocation'),
              position: newPosition,
              infoWindow: InfoWindow(
                title: 'My current location',
                snippet:
                'Lat: ${newPosition.latitude}, Lng: ${newPosition.longitude}',
              ),
            ),
          };
          _polylines = {
            Polyline(
              polylineId: PolylineId('trackingPolyline'),
              color: Colors.blue,
              width: 5,
              points: _polylineCoordinates,
            ),
          };
        });
        _moveCamera(newPosition);
      } catch (e) {
        print('Failed to update location: $e');
      }
    });
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Real-Time Location Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<LatLng>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Failed to get location.'));
          }
          LatLng initialPosition = snapshot.data!;
          _currentPosition ??= initialPosition;

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 14.0,
            ),
            onMapCreated: (controller) => _controller.complete(controller),
            markers: _markers,
            polylines: _polylines,
          );
        },
      ),
    );
  }
}