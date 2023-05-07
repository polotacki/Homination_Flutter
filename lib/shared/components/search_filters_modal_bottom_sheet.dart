import 'package:flutter/material.dart';

import '../../model/search_filters_model.dart';

  class SearchFiltersModalBottomSheet extends StatefulWidget {
    final Function(SearchFilters) onFiltersApplied;

    SearchFiltersModalBottomSheet({required this.onFiltersApplied});

    @override
    _SearchFiltersModalBottomSheetState createState() =>
        _SearchFiltersModalBottomSheetState();
  }

  class _SearchFiltersModalBottomSheetState
      extends State<SearchFiltersModalBottomSheet> {
    late String _category;
    late String _location;
    late  int _priceMin;
    late int _priceMax;

    @override
    Widget build(BuildContext context) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Search Filters',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _category = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Location',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Price Range:'),
                SizedBox(width: 16.0),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Min',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _priceMin = (value.isNotEmpty ? int.parse(value) : null)!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Text('to'),
                SizedBox(width: 16.0),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Max',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _priceMax = (value.isNotEmpty ? int.parse(value) : null)!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                SearchFilters filters = SearchFilters(
                  category: _category,
                  location: _location,
                  priceMin: _priceMin,
                  priceMax: _priceMax,
                );
                widget.onFiltersApplied(filters);
                Navigator.pop(context);
              },
              child: Text('Apply Filters'),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      );
    }
  }
