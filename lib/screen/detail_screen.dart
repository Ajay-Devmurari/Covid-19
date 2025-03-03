import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  final String flag;
  final String countryName;
  final int active;
  final int critical;
  final int test;
  final int todayRecovered;
  final String totalCases;
  final int totalDeaths;
  final int totalRecovered;

  const DetailScreen({
    super.key,
    required this.flag,
    required this.countryName,
    required this.active,
    required this.critical,
    required this.test,
    required this.todayRecovered,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  });

  @override
  Widget build(BuildContext context) {
    final List<StatItem> stats = [
      StatItem(
          title: "Total Cases",
          value: totalCases,
          icon: FontAwesomeIcons.virus,
          color: Colors.orange),
      StatItem(
          title: "Active Cases",
          value: active.toString(),
          icon: FontAwesomeIcons.exclamationTriangle,
          color: Colors.blue),
      StatItem(
          title: "Critical Cases",
          value: critical.toString(),
          icon: FontAwesomeIcons.procedures,
          color: Colors.red),
      StatItem(
          title: "Total Tests",
          value: test.toString(),
          icon: FontAwesomeIcons.vial,
          color: Colors.teal),
      StatItem(
          title: "Today's Recovered",
          value: todayRecovered.toString(),
          icon: FontAwesomeIcons.solidHeart,
          color: Colors.green),
      StatItem(
          title: "Total Deaths",
          value: totalDeaths.toString(),
          icon: FontAwesomeIcons.skullCrossbones,
          color: Colors.black),
      StatItem(
          title: "Total Recovered",
          value: totalRecovered.toString(),
          icon: FontAwesomeIcons.checkCircle,
          color: Colors.green),
    ];
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        title: Text(countryName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 6, spreadRadius: 1)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(flag,
                    height: ht * 0.2,
                    width: wt * 0.5,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: ht * 0.05),
            Card(
              color: Colors.white30,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: ht * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Country Statistics",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: stats.length,
                        itemBuilder: (context, index) {
                          return _buildStatCard(stats[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(StatItem stat) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(stat.icon, color: stat.color, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Text(stat.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Text(
              stat.value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: stat.color),
            ),
          ],
        ),
      ),
    );
  }
}

class StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
