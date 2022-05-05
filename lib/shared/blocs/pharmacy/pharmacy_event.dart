part of 'pharmacy_bloc.dart';

abstract class PharmacyEvent extends Equatable {
  const PharmacyEvent();

  @override
  List<Object> get props => [];
}

class GetDetailData extends PharmacyEvent {
  const GetDetailData();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetDetailData: {  }';
}

class OrderMedications extends PharmacyEvent {
  final String pharmacyId;
  final List<String> medications;
  const OrderMedications({
    required this.pharmacyId,
    required this.medications,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'OrderMedications: {  }';
}
