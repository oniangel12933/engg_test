import 'package:dio/dio.dart';
import 'package:engg/modals/pharmacy.dart';

class PharmacyRepository {
  Future<Map<String, dynamic>> getDetail({required String pharmacyId}) async {
    Response response = await Dio().get(
        'https://api-qa-demo.nimbleandsimple.com/pharmacies/info/$pharmacyId');
    return response.data['value'];
  }

  Future<List<String>> loadMedications() async {
    Response response = await Dio().get(
        'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt');
    if (response.data == null) {
      return [];
    }
    final array = response.data.toString().replaceAll('\n', '').split(',');
    return array;
  }
}

List<Pharmacy> pharmacies = [
  {"name": "ReCept", "pharmacyId": "NRxPh-HLRS"},
  {"name": "My Community Pharmacy", "pharmacyId": "NRxPh-BAC1"},
  {"name": "MedTime Pharmacy", "pharmacyId": "NRxPh-SJC1"},
  {"name": "NY Pharmacy", "pharmacyId": "NRxPh-ZEREiaYq"}
].map((item) => Pharmacy.fromJson(item)).toList();
