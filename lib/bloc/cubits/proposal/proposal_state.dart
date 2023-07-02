part of 'proposal_cubit.dart';

@immutable
abstract class ProposalState {}

class ProposalInitial extends ProposalState {}
class ServiceRequestLoading extends ProposalState {}
class ServiceRequestSuccess extends ProposalState {}
class ServiceRequestFailure extends ProposalState {}
