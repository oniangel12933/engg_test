part of 'pharmacy_bloc.dart';

abstract class PharmacyState {
  final List<Map<String, dynamic>> pharmacies;
  final List<String> medications;
  const PharmacyState({
    required this.pharmacies,
    required this.medications,
  });

  @override
  List<Object> get props => [];
}

class DetailLoading extends PharmacyState {
  DetailLoading()
      : super(
          pharmacies: [],
          medications: [],
        );

  @override
  String toString() => 'DetailLoading: {  }';
}

class DetailLoaded extends PharmacyState {
  final List<Map<String, dynamic>> newPharmacies;
  final List<String> newMedications;
  const DetailLoaded({
    required this.newPharmacies,
    required this.newMedications,
  }) : super(
          pharmacies: newPharmacies,
          medications: newMedications,
        );

  @override
  String toString() => 'DetailLoaded: { $newPharmacies }, { $newMedications }';
}

class MedicationsOrdered extends PharmacyState {
  final List<Map<String, dynamic>> newPharmacies;
  final List<String> newMedications;
  const MedicationsOrdered({
    required this.newPharmacies,
    required this.newMedications,
  }) : super(
          pharmacies: newPharmacies,
          medications: newMedications,
        );

  @override
  String toString() => 'MedicationsOrdered: { $newPharmacies }';
}
