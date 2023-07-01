class ProposalHistory<T> {
  final String status;
  final String id;
  final String clientName;
  final String providerName;
  final String serviceName;
  final RequestDescription<T> requestDescription;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProposalHistory({
    required this.status,
    required this.id,
    required this.clientName,
    required this.providerName,
    required this.serviceName,
    required this.requestDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProposalHistory.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ProposalHistory(
      status: json['status'],
      id: json['_id'],
      clientName: json['client_Name'],
      providerName: json['provider_Name'],
      serviceName: json['service_Name'],
      requestDescription:
      RequestDescription.fromJson(json['Request_Description'], fromJsonT),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      'status': status,
      '_id': id,
      'client_Name': clientName,
      'provider_Name': providerName,
      'service_Name': serviceName,
      'Request_Description': requestDescription.toJson(toJsonT),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
class RequestDescription<T> {
  final String id;
  final int propertyInMeter;
  final T requestDesc;
  final String propertyType;
  final String location;

  RequestDescription({
    required this.id,
    required this.propertyInMeter,
    required this.requestDesc,
    required this.propertyType,
    required this.location,
  });

  factory RequestDescription.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return RequestDescription(
      id: json['_id'],
      propertyInMeter: json['propertyInMeter'],
      requestDesc: fromJsonT(json['request_Desc']),
      propertyType: json['property_Type'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      '_id': id,
      'propertyInMeter': propertyInMeter,
      'request_Desc': toJsonT(requestDesc),
      'property_Type': propertyType,
      'location': location,
    };
  }
}