import 'package:blog_app/Provider/providerstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return SizedBox(
        height: 174,
        child: FlutterMap(
          options: MapOptions(
            center: state.loc != null
                ? LatLng(state.loc!.latitude, state.loc!.longitude)
                : null,
            zoom: 13.0,
            onPositionChanged: (pos, _) {},
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(state.loc!.latitude, state.loc!.longitude),
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
