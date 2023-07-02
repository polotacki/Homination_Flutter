import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:meta/meta.dart';

import '../../../model/service_request_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/http_helper.dart';

part 'proposal_state.dart';

class ProposalCubit extends Cubit<ProposalState> {
  ProposalCubit() : super(ProposalInitial());
  static ProposalCubit get(context) => BlocProvider.of(context);
  Future<void> sendServiceRequest(ServiceRequest serviceRequest) async {
    emit(ServiceRequestLoading());
    try {

      var token=CacheHelper.getData(key: "Token");
      print(token);
      final response = await HttpHelper.postData(
        url: serviceRequestEndPoint,
        data: serviceRequest.toJson((requestDesc) => requestDesc.toJson()), headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token', // Assuming the token is a JWT, use 'Bearer' prefix
        'Accept': 'application/json', // Add 'Accept' header to specify expected response format
      },

      );   print(serviceRequest.toJson((requestDesc) => requestDesc.toJson()));
      if (response.statusCode == 200) {
        emit(ServiceRequestSuccess());
      } else {
        print('Error: ${response.statusCode}');
        print(response.body);
        emit(ServiceRequestFailure());
      }
    } catch (e) {
      print(e);
      emit(ServiceRequestFailure());
    }
  }
}
