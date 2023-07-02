class ServiceRequest<T> {
  String clientName;
  String providerName;
  String serviceName;
  RequestDescription<T> requestDescription;

  ServiceRequest({
    required this.clientName,
    required this.providerName,
    required this.serviceName,
    required this.requestDescription,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ServiceRequest(
      clientName: json['client_Name'],
      providerName: json['provider_Name'],
      serviceName: json['service_Name'],
      requestDescription: RequestDescription.fromJson(json['Request_Description'],fromJson,),
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJson) {
    final Map<String, dynamic> data = {
      'client_Name': clientName,
      'provider_Name': providerName,
      'service_Name': serviceName,
      'Request_Description': requestDescription.toJson(toJson),
    };
    return data;
  }
}

class RequestDescription<T> {
  String? propertyInMeter;
  T requestDesc;
  String? propertyType;
  String? location;

  RequestDescription({
    required this.propertyInMeter,
    required this.requestDesc,
    required this.propertyType,
    required this.location,
  });

  factory RequestDescription.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return RequestDescription(
      propertyInMeter: json['propertyInMeter'],
      requestDesc: json['request_Desc'],
      propertyType: json['property_Type'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJson) {
    final Map<String, dynamic> data = {
      'propertyInMeter': propertyInMeter,
      'request_Desc': requestDesc,
      'property_Type': propertyType,
      'location': location,
    };
    return data;
  }
}

class SidingContractRequestDetails {
  String? style;
  String? color;
  String? materials;
  double? totalCost;
  String? timeFrame;

  SidingContractRequestDetails({
    required this.style,
    required this.color,
    required this.materials,
    required this.totalCost,
    required this.timeFrame,
  });

  factory SidingContractRequestDetails.fromJson(Map<String, dynamic> json) {
    return SidingContractRequestDetails(
      style: json['style'],
      color: json['color'],
      materials: json['materials'],
      totalCost: (json['total_Cost']).toDouble(),
      timeFrame: json['time_Frame'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'style': style,
      'color': color,
      'materials': materials,
      'total_Cost': totalCost,
      'time_Frame': timeFrame,
    };
    return data;
  }
}
