import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/blocs/pharmacy/pharmacy_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Map<String, dynamic> pharmacy;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> medications = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order for ${widget.pharmacy['name']}',
        ),
      ),
      body: ListView.builder(
        itemCount: context.read<PharmacyBloc>().state.medications!.length,
        itemBuilder: (context, index) {
          final medication =
              context.read<PharmacyBloc>().state.medications![index];
          return ListTile(
            title: Text(
              medication,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            trailing: Icon(
              medications.contains(medication)
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline,
              color:
                  medications.contains(medication) ? Colors.grey : Colors.red,
              size: 22,
            ),
            onTap: () {
              if (medications.contains(medication)) {
                medications.remove(medication);
              } else {
                medications.add(medication);
              }
              setState(() {});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          context
              .read<PharmacyBloc>()
              .orderMedications(widget.pharmacy['id'], medications);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save_outlined,
          size: 29,
        ),
      ),
    );
  }
}
