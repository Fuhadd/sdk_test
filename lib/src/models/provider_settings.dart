class ProviderSettings {
  String? logo;
  String? brandColorPrimary;
  ProviderSettings({
    required this.logo,
    required this.brandColorPrimary,
  });

  factory ProviderSettings.fromJson(json) {
    return ProviderSettings(
      logo: json['logo'],
      brandColorPrimary: json['brand_color_primary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'brand_color_primary': brandColorPrimary,
    };
  }
}
