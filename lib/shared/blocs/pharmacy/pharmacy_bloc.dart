import 'package:bloc/bloc.dart';
import 'package:engg/modals/pharmacy.dart';
import 'package:engg/repositories/pharmacy.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'pharmacy_event.dart';
part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  late final PharmacyRepository _pharmacyRepository;

  PharmacyBloc()
      : super(const DetailLoaded(newPharmacies: [], newMedications: [])) {
    _pharmacyRepository = GetIt.I.get<PharmacyRepository>();

    on<GetDetailData>(_getDetailData);
    on<OrderMedications>(_orderMedications);
  }

  Future<void> _getDetailData(
    GetDetailData event,
    Emitter<PharmacyState> emit,
  ) async {
    emit(DetailLoading());
    List<Map<String, dynamic>> detailsOfPharmacies = [];
    for (Pharmacy cell in pharmacies) {
      Map<String, dynamic> detail =
          await _pharmacyRepository.getDetail(pharmacyId: cell.id);
      detailsOfPharmacies.add(detail);
    }
    List<String> medications = await _pharmacyRepository.loadMedications();
    emit(
      DetailLoaded(
        newPharmacies: detailsOfPharmacies,
        newMedications: medications,
      ),
    );
  }

  Future<void> _orderMedications(
    OrderMedications event,
    Emitter<PharmacyState> emit,
  ) async {
    List<Map<String, dynamic>> detailsOfPharmacies = state.pharmacies.toList();
    Map<String, dynamic> item = detailsOfPharmacies
        .where((element) => element['id'] == event.pharmacyId)
        .first;
    final index = detailsOfPharmacies.indexOf(item);
    item['medications'] = event.medications;
    detailsOfPharmacies[index] = item;
    emit(
      MedicationsOrdered(
        newPharmacies: detailsOfPharmacies,
        newMedications: state.medications.toList(),
      ),
    );
  }

  void getDetails() {
    add(const GetDetailData());
  }

  void orderMedications(String pharmacyId, List<String> medications) {
    add(
      OrderMedications(
        pharmacyId: pharmacyId,
        medications: medications,
      ),
    );
  }
}
