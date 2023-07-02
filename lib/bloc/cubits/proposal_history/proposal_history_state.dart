part of 'proposal_history_cubit.dart';

@immutable
abstract class ProposalHistoryState {}

class ProposalHistoryInitial extends ProposalHistoryState {}

class ProposalHistoryLoading extends ProposalHistoryState {}

class ProposalHistoryError extends ProposalHistoryState {
  final String error;

  ProposalHistoryError(this.error);
}

class ProposalHistorySuccess extends ProposalHistoryState {
  final List<ProposalHistory> servicesModel;

  ProposalHistorySuccess(this.servicesModel);
}