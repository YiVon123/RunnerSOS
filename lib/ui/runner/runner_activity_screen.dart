import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner_sos/routes/app_routes.dart';
import 'package:runner_sos/ui/runner/runner_run_screen.dart';
import 'package:runner_sos/utils/app_colors.dart';
import 'package:runner_sos/widgets/common/app_page.dart';

class RunnerActivityScreen extends StatefulWidget {
  const RunnerActivityScreen({super.key});

  State<RunnerActivityScreen> createState() => _RunnerActivityScreenState();
}

class _RunnerActivityScreenState extends State<RunnerActivityScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // take up all space
          Expanded(
            child: Stack(
              children: [
                Container(color: AppColors.light),

                Positioned(
                  bottom: 30,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RunnerRunScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.sos,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'START',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
