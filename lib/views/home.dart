import 'package:engg/repositories/pharmacy.dart';
import 'package:engg/views/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import '../shared/blocs/pharmacy/pharmacy_bloc.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PharmacyRepository _pharmacyRepository;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();

    _pharmacyRepository = GetIt.I.get<PharmacyRepository>();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enng Test'),
      ),
      body: BlocBuilder<PharmacyBloc, PharmacyState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.pharmacies.isEmpty) {
            return const Center(
              child: Text('Error to get data'),
            );
          }
          return ListView.builder(
            itemCount: state.pharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = state.pharmacies[index];
              String distance = (Geolocator.distanceBetween(
                        currentPosition!.latitude,
                        currentPosition!.longitude,
                        pharmacy['address']['latitude'],
                        pharmacy['address']['longitude'],
                      ) /
                      1000)
                  .toStringAsFixed(1);
              return ListTile(
                leading: const Icon(
                  Icons.local_hospital_sharp,
                  color: Colors.red,
                ),
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: pharmacy['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '  (${distance}km)',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: pharmacy['medications'] != null
                    ? const Icon(
                        Icons.bookmark,
                        color: Colors.blueGrey,
                        size: 18,
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(pharmacy: pharmacy),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => orderFromClosest(context),
        child: const Icon(Icons.bookmark_add),
      ),
    );
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getLastKnownPosition();
  }

  Future<void> orderFromClosest(BuildContext context) async {
    if (currentPosition != null) {
      double minDistance = 100000000;
      final listOfPharmacies =
          context.read<PharmacyBloc>().state.pharmacies.toList();
      Map<String, dynamic>? closestOne;
      for (Map<String, dynamic> detail in listOfPharmacies) {
        if (detail['medications'] == null) {
          double distance = Geolocator.distanceBetween(
            currentPosition!.latitude,
            currentPosition!.longitude,
            detail['address']['latitude'],
            detail['address']['longitude'],
          );
          if (distance < minDistance) {
            minDistance = distance;
            closestOne = detail;
          }
        }
      }
      if (closestOne == null) {
        final snackBar = SnackBar(
          content: const Text('No bookable pharmacies'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPage(pharmacy: closestOne!),
          ),
        );
      }
    } else {
      final snackBar = SnackBar(
        content: const Text('Error to get location'),
        action: SnackBarAction(
          label: 'Done',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
