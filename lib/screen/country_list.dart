import 'package:covid_app/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../api_services/state_countries_service.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CountriesDataService countriesDataService = CountriesDataService();
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        title: Text(
          'Country List',
          style: TextStyle(
            fontSize: wt * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search countries....',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.blueGrey[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: countriesDataService.fetchCountriesData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[700]!,
                      highlightColor: Colors.grey[500]!,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListTile(
                              title: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        String countryName = item['country'].toString();

                        if (searchController.text.isEmpty ||
                            countryName.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                          return Card(
                            color: Colors.blueGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        flag: item["countryInfo"]["flag"] ?? "",
                                        countryName:
                                            item['country'] ?? "Unknown",
                                        active: item['active'] ?? 0,
                                        critical: item['critical'] ?? 0,
                                        test: item['tests'] ?? 0,
                                        todayRecovered:
                                            item['todayRecovered'] ?? 0,
                                        totalCases: item['cases'].toString(),
                                        totalDeaths: item['deaths'] ?? 0,
                                        totalRecovered: item['recovered'] ?? 0,
                                      ),
                                    ));
                              },
                              title: Text(
                                item['country'] ?? "Unknown",
                                style: TextStyle(
                                  fontSize: wt * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                "Cases: ${item['cases'].toString()}",
                                style: TextStyle(
                                  fontSize: wt * 0.04,
                                  color: Colors.white70,
                                ),
                              ),
                              leading: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item["countryInfo"]["flag"] ?? "",
                                    height: ht * 0.07,
                                    width: wt * 0.18,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
