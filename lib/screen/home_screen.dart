import 'package:covid_app/api_services/state_countries_service.dart';
import 'package:covid_app/model/world_state_model.dart';
import 'package:covid_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  final colorList = [Colors.blue, Colors.green, Colors.red, Colors.orange];

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final StateDataService stateDataService = StateDataService();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Covid Tracker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<WorldStateModel?>(
              future: stateDataService.fetchStateData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white)),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text("No data available",
                        style: TextStyle(color: Colors.white)),
                  );
                }

                final data = snapshot.data!;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCircularIndicator(
                            "Active", data.active, data.cases, Colors.blue),
                        buildCircularIndicator(
                            "Cases", data.cases, data.cases, Colors.orange),
                        buildCircularIndicator("Recovered", data.recovered,
                            data.cases, Colors.green),
                        buildCircularIndicator(
                            "Deaths", data.deaths, data.cases, Colors.red),
                      ],
                    ),
                    SizedBox(height: ht * 0.02),
                    Card(
                      color: Colors.white.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            buildReusableWidget(
                                'Deaths', data.deaths!.toString()),
                            buildReusableWidget(
                                'Recovered', data.recovered!.toString()),
                            buildReusableWidget(
                                'Active', data.active!.toString()),
                            buildReusableWidget('Today Recovered',
                                data.todayRecovered!.toString()),
                            buildReusableWidget(
                                'Critical', data.critical!.toString()),
                            buildReusableWidget(
                                'Tests', data.tests!.toString()),
                            buildReusableWidget(
                                'Today Cases', data.todayCases!.toString()),
                            buildReusableWidget(
                                'Cases', data.cases!.toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            const Buttons(),
            SizedBox(height: ht * 0.04),
          ],
        ),
      ),
    );
  }

  Widget buildReusableWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildCircularIndicator(
      String title, int? value, int? total, Color color) {
    double percentage = (value ?? 0) / (total ?? 1);
    percentage = percentage.clamp(0.0, 1.0);
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1200,
          curve: Curves.easeInOut,

          radius: ht * 0.040,
          lineWidth: wt * 0.01,
          percent: percentage,
          center: Text(
            "${(percentage * 100).toStringAsFixed(1)}%",
            style: const TextStyle(color: Colors.white),
          ),
          progressColor: color,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: ht * 0.02),
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
