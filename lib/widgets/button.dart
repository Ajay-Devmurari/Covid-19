import 'package:flutter/material.dart';
import '../screen/country_list.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CountryList(),
            ));
      },
      child: Container(
        height: ht * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blue.shade700],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('Track Countries',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
