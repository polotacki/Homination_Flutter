import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../../bloc/cubits/home_cubit/home_cubit.dart';
import '../../data/cards.dart';
import '../../model/services_mod.dart';
import '../../model/services_model.dart';
import '../../shared/components/horizontal_card.dart';

class SearchPage extends StatefulWidget {

  final String query;

  SearchPage({ required this.query});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Service> _searchResults = [];
  final service = services.values.toList();
  @override
  void initState() {
    super.initState();
    _search();
  }

  void _search() {
    // Clear previous search results
    _searchResults.clear();

    // Apply filters if any
    final filteredServices = service.where((service) {
      final squery = widget.query.toLowerCase();
      return service.provider.toLowerCase().contains(squery) ||
          service.desc.toLowerCase().contains(squery)||
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
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
    builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: _searchResults.isEmpty
          ? Center(
        child: Text('No results found'),
      )
          : ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          final service = _searchResults[index];

          return HorizontalCard(avarageRate:calculateAverageRating(HomeCubit.get(context).services![index].reviews) ,service: HomeCubit.get(context).services![index], state: state,);
        },
      ),
    );
    });}
}
