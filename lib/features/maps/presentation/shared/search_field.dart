import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchField extends StatefulWidget {
  final Function(LatLng)? onLocationSelected;

  SearchField({Key? key, this.onLocationSelected}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];

  Future<void> _fetchSuggestions(String query) async {
    if (query.length < 3) return; // Начинаем поиск только после 3 символов

    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?format=json&q=$query&addressdetails=1");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _suggestions = data
              .map((item) => {
            "display_name": item["display_name"],
            "lat": double.parse(item["lat"]),
            "lon": double.parse(item["lon"]),
          })
              .toList();
        });
      }
    } catch (e) {
      print("Ошибка поиска: $e");
    }
  }

  void _selectLocation(Map<String, dynamic> location) {
    double lat = location["lat"];
    double lon = location["lon"];

    LatLng newLocation = LatLng(lat, lon);
    widget.onLocationSelected?.call(newLocation);

    setState(() {
      _controller.text = location["display_name"];
      _suggestions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search for a location",
          ),
          onChanged: _fetchSuggestions,
        ),
        if (_suggestions.isNotEmpty)
          Container(
            color: Colors.white,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3, // Ограничиваем высоту
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]["display_name"]),
                  onTap: () => _selectLocation(_suggestions[index]),
                );
              },
            ),
          ),
      ],
    );
  }
}