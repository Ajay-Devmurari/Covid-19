import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/world_state_model.dart';
import 'api_service.dart';

class StateDataService {
  Future<WorldStateModel?> fetchStateData() async {
    try {
      final response = await http.get(Uri.parse(ApiService.stateUrl));
      if (response.statusCode == 200) {
        return WorldStateModel.fromJson(jsonDecode(response.body));
      } else {
        debugPrint("Failed to load data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
      return null;
    }
  }
}

class CountriesDataService {
  Future<List<dynamic>> fetchCountriesData() async {
    try {
      final response = await http.get(Uri.parse(ApiService.countriesUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
      return [];
    }
  }
}
