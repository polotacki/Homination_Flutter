import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:meta/meta.dart';

import '../../../model/proposal_history.dart';
import '../../../model/service_request_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/http_helper.dart';

part 'proposal_history_state.dart';

class ProposalHistoryCubit extends Cubit<ProposalHistoryState> {
  ProposalHistoryCubit() : super(ProposalHistoryInitial());
  var base64String = CacheHelper.getData(key: "profilePic");
  List<ProposalHistory> proposalHistory=[];
  void getProposalHistoryData() {
    emit(ProposalHistoryLoading());
    var userName=CacheHelper.getData(key: 'userName');
    var token=CacheHelper.getData(key: "Token");
    print(token);

    print(userName);
    HttpHelper.getData(url: '${proposalHistoryEndPoint}$userName/',  headers: {
      'Content-Type': 'application/json',
      'Authorization': '$token', // Assuming the token is a JWT, use 'Bearer' prefix
      'Accept': 'application/json', // Add 'Accept' header to specify expected response format
    },).then((response) {
      if (response.statusCode == 200) {
        print('API call successful, response body:');
        print(response.body);
        proposalHistory =
            (jsonDecode(response.body) as List)
                .map((serviceJson) => ProposalHistory.fromJson(serviceJson,(json) => SidingContractRequestDetails.fromJson(json)))
                .toList();
        print('Data processing successful, services:');
        print(proposalHistory);
        emit(ProposalHistorySuccess(proposalHistory));
      } else {
        print('API call failed, response body:');
        print(response.body);
        emit(ProposalHistoryError(response.body));
      }
    }).catchError((error) {
      print('API call error:');

      print(error.toString());
      emit(ProposalHistoryError(error.toString()));
    });
  }
}
