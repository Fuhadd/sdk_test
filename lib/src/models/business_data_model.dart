class BusinessDetailsModel {
  final String? id;
  final String? appMode;
  final String? ownerId;
  final String? logo;
  final bool appNotifications;
  final bool debitWallet;
  final bool emailNotifications;
  final bool newsLetter;
  final bool emailUsers;
  final bool twoFa;
  final bool enableWebhook;
  final String? language;
  final String? currency;
  final String? callbackUrl;
  final String? webhookUrl;
  final String? colorTheme;
  final List<String>? notificationChannels;
  final bool isPurchaseNotification;
  final bool isActivationNotification;
  final bool isRenewalNotification;
  final bool isWatermark;
  final bool isDefaultLogo;
  final bool isDefaultColour;
  final String? layout;
  final String? sdkWelcomeScreenHeaderPrePurchase;
  final String? sdkWelcomeScreenBodyPrePurchase;

  final String? sdkSuccessScreenHeaderPostPurchase;
  final String? sdkSuccessScreenBodyPostPurchase;
  final String? sdkWelcomeScreenHeaderPreRenewal;
  final String? sdkSuccessScreenHeaderPostRenewal;
  final String? sdkWelcomeScreenBodyPreRenewal;
  final String? sdkSuccessScreenBodyPostRenewal;
  final String? sdkBannerRenewal;
  final String? sdkWelcomeScreenHeaderPreInspection;
  final String? sdkSuccessScreenHeaderPostInspection;
  final String? sdkSuccessScreenBodyPostInspection;
  final String? sdkWelcomeScreenHeaderPreClaim;
  final String? sdkSuccessScreenHeaderPostClaim;
  final String? sdkWelcomeScreenBodyPreClaim;
  final String? sdkSuccessScreenBodyPostClaim;
  final String? sdkBannerClaim;
  final String? sdkMenuHeader;
  final String? sdkBannerPurchase;

  final String? sdkMenu1SupportingText;
  final String? sdkMenu2SupportingText;
  final String? sdkMenu3SupportingText;
  final String? sdkMenu4SupportingText;
  final String? brandColorPrimary;
  final String? brandColorSecondary;
  final String? defaultPurchasePageUrl;
  final String? defaultInspectionPageUrl;
  final String? defaultClaimPageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? tradingName;
  final String? businessName;
  final String? instanceId;
  final List<String>? paymentChannels;

  BusinessDetailsModel({
    required this.id,
    required this.appMode,
    required this.ownerId,
    required this.logo,
    required this.appNotifications,
    required this.debitWallet,
    required this.emailNotifications,
    required this.newsLetter,
    required this.emailUsers,
    required this.twoFa,
    required this.enableWebhook,
    required this.language,
    required this.currency,
    required this.callbackUrl,
    required this.webhookUrl,
    required this.colorTheme,
    required this.notificationChannels,
    required this.isPurchaseNotification,
    required this.isActivationNotification,
    required this.isRenewalNotification,
    required this.isWatermark,
    required this.isDefaultLogo,
    required this.isDefaultColour,
    required this.layout,
    required this.sdkWelcomeScreenHeaderPrePurchase,
    required this.sdkWelcomeScreenBodyPrePurchase,
    required this.sdkSuccessScreenHeaderPostPurchase,
    required this.sdkSuccessScreenBodyPostPurchase,
    required this.sdkWelcomeScreenHeaderPreRenewal,
    required this.sdkSuccessScreenHeaderPostRenewal,
    required this.sdkWelcomeScreenBodyPreRenewal,
    required this.sdkSuccessScreenBodyPostRenewal,
    required this.sdkBannerRenewal,
    required this.sdkWelcomeScreenHeaderPreInspection,
    required this.sdkSuccessScreenHeaderPostInspection,
    required this.sdkSuccessScreenBodyPostInspection,
    required this.sdkWelcomeScreenHeaderPreClaim,
    required this.sdkSuccessScreenHeaderPostClaim,
    required this.sdkWelcomeScreenBodyPreClaim,
    required this.sdkSuccessScreenBodyPostClaim,
    required this.sdkBannerClaim,
    required this.sdkMenuHeader,
    required this.sdkMenu1SupportingText,
    required this.sdkMenu2SupportingText,
    required this.sdkMenu3SupportingText,
    required this.sdkMenu4SupportingText,
    required this.brandColorPrimary,
    required this.brandColorSecondary,
    required this.defaultPurchasePageUrl,
    required this.defaultInspectionPageUrl,
    required this.defaultClaimPageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.tradingName,
    required this.businessName,
    required this.instanceId,
    required this.paymentChannels,
    required this.sdkBannerPurchase,
  });

  factory BusinessDetailsModel.fromJson(json) {
    return BusinessDetailsModel(
      id: json['id'],
      appMode: json['app_mode'],
      ownerId: json['owner_id'],
      logo: json['logo'],
      appNotifications: json['app_notifications'] ?? false,
      debitWallet: json['debit_wallet'] ?? false,
      emailNotifications: json['email_notifications'] ?? false,
      newsLetter: json['news_letter'] ?? false,
      emailUsers: json['email_users'] ?? false,
      twoFa: json['two_fa'] ?? false,
      enableWebhook: json['enable_webhook'] ?? false,
      language: json['language'],
      currency: json['currency'],
      callbackUrl: json['callback_url'],
      webhookUrl: json['webhook_url'],
      colorTheme: json['color_theme'],
      notificationChannels: json['notification_channels'] == null
          ? null
          : List<String>.from(json['notification_channels']),
      isPurchaseNotification: json['is_purchase_notification'] ?? false,
      isActivationNotification: json['is_activation_notification'] ?? false,
      isRenewalNotification: json['is_renewal_notification'] ?? false,
      isWatermark: json['is_watermark'] ?? true,
      isDefaultLogo: json['is_default_logo'] ?? true,
      isDefaultColour: json['is_default_colour'] ?? "true",
      layout: json['layout'],
      sdkWelcomeScreenHeaderPrePurchase:
          json['sdk_welcome_screen_header_pre_purchase'],
      sdkWelcomeScreenBodyPrePurchase:
          json['sdk_welcome_screen_body_pre_purchase'],
      sdkSuccessScreenHeaderPostPurchase:
          json['sdk_success_screen_header_post_purchase'],
      sdkSuccessScreenBodyPostPurchase:
          json['sdk_success_screen_body_post_purchase'],
      sdkWelcomeScreenHeaderPreRenewal:
          json['sdk_welcome_screen_header_pre_renewal'],
      sdkSuccessScreenHeaderPostRenewal:
          json['sdk_success_screen_header_post_renewal'],
      sdkWelcomeScreenBodyPreRenewal:
          json['sdk_welcome_screen_body_pre_renewal'],
      sdkSuccessScreenBodyPostRenewal:
          json['sdk_success_screen_body_post_renewal'],
      sdkBannerRenewal: json['sdk_banner_renewal'],
      sdkWelcomeScreenHeaderPreInspection:
          json['sdk_welcome_screen_header_pre_inspection'],
      sdkSuccessScreenHeaderPostInspection:
          json['sdk_success_screen_header_post_inspection'],
      sdkSuccessScreenBodyPostInspection:
          json['sdk_success_screen_body_post_inspection'],
      sdkWelcomeScreenHeaderPreClaim:
          json['sdk_welcome_screen_header_pre_claim'],
      sdkSuccessScreenHeaderPostClaim:
          json['sdk_success_screen_header_post_claim'],
      sdkWelcomeScreenBodyPreClaim: json['sdk_welcome_screen_body_pre_claim'],
      sdkSuccessScreenBodyPostClaim: json['sdk_success_screen_body_post_claim'],
      sdkBannerClaim: json['sdk_banner_claim'],
      sdkMenuHeader: json['sdk_menu_header'],
      sdkMenu1SupportingText: json['sdk_menu_1_supporting_text'],
      sdkMenu2SupportingText: json['sdk_menu_2_supporting_text'],
      sdkMenu3SupportingText: json['sdk_menu_3_supporting_text'],
      sdkMenu4SupportingText: json['sdk_menu_4_supporting_text'],
      brandColorPrimary: json['brand_color_primary'],
      brandColorSecondary: json['brand_color_secondary'],
      defaultPurchasePageUrl: json['default_purchase_page_url'],
      defaultInspectionPageUrl: json['default_inspection_page_url'],
      defaultClaimPageUrl: json['default_claim_page_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
      tradingName: json['trading_name'],
      businessName: json['business_name'],
      instanceId: json['instance_id'],
      paymentChannels: json['payment_channels'] == null
          ? null
          : List<String>.from(json['payment_channels']),
      sdkBannerPurchase: json['sdk_banner_purchase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'app_mode': appMode,
      'owner_id': ownerId,
      'logo': logo,
      'app_notifications': appNotifications,
      'debit_wallet': debitWallet,
      'email_notifications': emailNotifications,
      'news_letter': newsLetter,
      'email_users': emailUsers,
      'two_fa': twoFa,
      'enable_webhook': enableWebhook,
      'language': language,
      'currency': currency,
      'callback_url': callbackUrl,
      'webhook_url': webhookUrl,
      'color_theme': colorTheme,
      'notification_channels': notificationChannels,
      'is_purchase_notification': isPurchaseNotification,
      'is_activation_notification': isActivationNotification,
      'is_renewal_notification': isRenewalNotification,
      'is_watermark': isWatermark,
      'is_default_logo': isDefaultLogo,
      'is_default_colour': isDefaultColour,
      'layout': layout,
      'sdk_welcome_screen_header_pre_purchase':
          sdkWelcomeScreenHeaderPrePurchase,
      'sdk_success_screen_header_post_purchase':
          sdkSuccessScreenHeaderPostPurchase,
      'sdk_success_screen_body_post_purchase': sdkSuccessScreenBodyPostPurchase,
      'sdk_welcome_screen_body_pre_purchase': sdkWelcomeScreenBodyPrePurchase,
      'sdk_welcome_screen_header_pre_renewal': sdkWelcomeScreenHeaderPreRenewal,
      'sdk_success_screen_header_post_renewal':
          sdkSuccessScreenHeaderPostRenewal,
      'sdk_welcome_screen_body_pre_renewal': sdkWelcomeScreenBodyPreRenewal,
      'sdk_success_screen_body_post_renewal': sdkSuccessScreenBodyPostRenewal,
      'sdk_banner_renewal': sdkBannerRenewal,
      'sdk_welcome_screen_header_pre_inspection':
          sdkWelcomeScreenHeaderPreInspection,
      'sdk_success_screen_header_post_inspection':
          sdkSuccessScreenHeaderPostInspection,
      'sdk_success_screen_body_post_inspection':
          sdkSuccessScreenBodyPostInspection,
      'sdk_welcome_screen_header_pre_claim': sdkWelcomeScreenHeaderPreClaim,
      'sdk_success_screen_header_post_claim': sdkSuccessScreenHeaderPostClaim,
      'sdk_welcome_screen_body_pre_claim': sdkWelcomeScreenBodyPreClaim,
      'sdk_success_screen_body_post_claim': sdkSuccessScreenBodyPostClaim,
      'sdk_banner_claim': sdkBannerClaim,
      'sdk_menu_header': sdkMenuHeader,
      'sdk_menu_1_supporting_text': sdkMenu1SupportingText,
      'sdk_menu_2_supporting_text': sdkMenu2SupportingText,
      'sdk_menu_3_supporting_text': sdkMenu3SupportingText,
      'sdk_menu_4_supporting_text': sdkMenu4SupportingText,
      'brand_color_primary': brandColorPrimary,
      'brand_color_secondary': brandColorSecondary,
      'default_purchase_page_url': defaultPurchasePageUrl,
      'default_inspection_page_url': defaultInspectionPageUrl,
      'default_claim_page_url': defaultClaimPageUrl,
      'created_at': createdAt?.toIso8601String() ?? "",
      'updated_at': updatedAt?.toIso8601String() ?? "",
      'deleted_at': deletedAt,
      'trading_name': tradingName,
      'business_name': businessName,
      'instance_id': instanceId,
      'payment_channels': paymentChannels,
      'sdk_banner_purchase': sdkBannerPurchase,
    };
  }
}
