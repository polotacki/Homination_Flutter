class ServiceRequest {
  String clientName;
  String providerName;
  String serviceName;
  RequestDescription requestDescription;

  ServiceRequest({
    required this.clientName,
    required this.providerName,
    required this.serviceName,
    required this.requestDescription,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      clientName: json['client_Name'],
      providerName: json['provider_Name'],
      serviceName: json['service_Name'],
      requestDescription: RequestDescription.fromJson(json['Request_Description']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_Name': clientName,
      'provider_Name': providerName,
      'service_Name': serviceName,
      'Request_Description': requestDescription.toJson(),
    };
  }
}

class RequestDescription {
  String? propertyInMeter;
  String? requestDesc;
  String? propertyType;
  String? location;

  RequestDescription({
    required this.propertyInMeter,
    required this.requestDesc,
    required this.propertyType,
    required this.location,
  });

  factory RequestDescription.fromJson(Map<String, dynamic> json) {
    return RequestDescription(
      propertyInMeter: json['propertyInMeter'],
      requestDesc: json['request_Desc'],
      propertyType: json['property_Type'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyInMeter': propertyInMeter,
      'request_Desc': requestDesc,
      'property_Type': propertyType,
      'location': location,
    };
  }
}