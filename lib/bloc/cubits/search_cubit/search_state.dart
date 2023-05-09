part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResultsLoaded extends SearchState {
  final List<ServicesModel> services;

  SearchResultsLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}