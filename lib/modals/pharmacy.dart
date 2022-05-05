class Pharmacy {
  final String name;
  final String id;

  Pharmacy({
    required this.id,
    required this.name,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> data) => Pharmacy(
        id: data['pharmacyId'],
        name: data['name'],
      );
}
