import 'package:mca_official_flutter_sdk/src/models/provider_settings.dart';

class ProviderLiteModel {
  String? companyName;
  String? id;
  ProviderSettings? settings;

  ProviderLiteModel(
      {required this.companyName, required this.id, required this.settings});

  factory ProviderLiteModel.fromJson(json) {
    return ProviderLiteModel(
      id: json['id'],
      companyName: json['company_name'],
      settings: json['settings'] == null
          ? null
          : ProviderSettings.fromJson(json['settings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'id': id,
      'settings': settings?.toJson(),
    };
  }
}
