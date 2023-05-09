import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubits/search_cubit/search_cubit.dart';
import '../../model/services_model.dart';
import '../../shared/components/horizontal_card.dart';

class SearchPage extends StatefulWidget {

  final String query;

  const SearchPage({ required this.query, required this.service});
  final List<ServicesModel> service;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ServicesModel> _searchResults = [];




  @override
  void initState() {
    super.initState();
    _search();
  }

  void _search() {
    // Clear previous search results
    _searchResults.clear();

    // المفروض هنا تبقي الفلاتر مبعوتة
    ;

      final filteredServices = widget.service.where((service) {
        final squery = widget.query.toLowerCase();
        return service.provider.toLowerCase().contains(squery) ||
            service.desc.toLowerCase().contains(squery) ||
            service.title.toLowerCase().contains(squery);
      }).toList();

      setState(() {
        _searchResults.addAll(filteredServices);
      });
    }


  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) {
      return 0.0;
    }

    int totalRating = 0;

    for (var review in reviews) {
      totalRating += review.rating;
    }

    return totalRating / reviews.length;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
    child: BlocConsumer<SearchCubit, SearchState>(

    listener: (context, state) {},
    builder: (context, state) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: _searchResults.isEmpty
          ? const Center(
        child: Text('No results found'),
      )
          : ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          final service = _searchResults[index];

          return HorizontalCard(avarageRate:calculateAverageRating(service.reviews) , service: service, );
        },
      ),
    );
    }));}
}
