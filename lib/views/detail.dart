import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Map<String, dynamic> pharmacy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pharmacy['name'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailItem(
              'Name',
              pharmacy['name'],
            ),
            detailItem(
              'Address',
              pharmacy['address']['city'],
            ),
            if (pharmacy['primaryPhoneNumber'] != null)
              detailItem(
                'Phone Number',
                pharmacy['primaryPhoneNumber'],
              ),
            if (pharmacy['pharmacyHours'] != null)
              detailItem(
                'Hours',
                pharmacy['pharmacyHours'] ?? '',
              ),
            const SizedBox(
              height: 15,
            ),
            if (pharmacy['medications'] != null)
              Expanded(
                child: StaggeredGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  children: pharmacy['medications'].map<Widget>((medication) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        child: Center(
                          child: Text(
                            medication,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  staggeredTiles: pharmacy['medications']
                      .map<StaggeredTile>((_) => const StaggeredTile.fit(1))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget detailItem(String key, String data) {
    String newData = data;
    if (data.contains('\\n')) {
      List<String> array = data.split('\\n');
      newData = '';
      for (String str in array) {
        newData += ('\n\b\b' +
            str
                .replaceFirst(RegExp(r"^\s+"), "")
                .replaceFirst(RegExp(r"\s+$"), ""));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: key + ' : ',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            TextSpan(
              text: newData,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
