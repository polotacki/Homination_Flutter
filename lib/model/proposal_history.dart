class ProposalHistory {
  final String status;
  final String id;
  final String clientName;
  final String providerName;
  final String serviceName;
  final RequestDescription requestDescription;
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

  factory ProposalHistory.fromJson(Map<String, dynamic> json) {
    return ProposalHistory(
      status: json['status'],
      id: json['_id'],
      clientName: json['client_Name'],
      providerName: json['provider_Name'],
      serviceName: json['service_Name'],
      requestDescription: RequestDescription.fromJson(json['Request_Description']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      '_id': id,
      'client_Name': clientName,
      'provider_Name': providerName,
      'service_Name': serviceName,
      'Request_Description': requestDescription.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class RequestDescription {
  final String id;
  final int propertyInMeter;
  final String requestDesc;
  final String propertyType;
  final String location;

  RequestDescription({
    required this.id,
    required this.propertyInMeter,
    required this.requestDesc,
    required this.propertyType,
    required this.location,
  });

  factory RequestDescription.fromJson(Map<String, dynamic> json) {
    return RequestDescription(
      id: json['_id'],
      propertyInMeter: json['propertyInMeter'],
      requestDesc: json['request_Desc'],
      propertyType: json['property_Type'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'propertyInMeter': propertyInMeter,
      'request_Desc': requestDesc,
      'property_Type': propertyType,
      'location': location,
    };
  }
}