enum SdkOptions {
  buy,
  renew,
  manage,
  claim,
}

enum PaymentOption {
  wallet,
  gateway,
}

enum PaymentMethod {
  transfer,
  ussd,
}

extension PaymentMethodName on PaymentMethod {
  String get getName {
    switch (this) {
      case PaymentMethod.transfer:
        return 'bank transfer';
      case PaymentMethod.ussd:
        return 'ussd';
      default:
        return "";
    }
  }
}

extension PaymentOptionName on PaymentOption {
  String get getName {
    switch (this) {
      case PaymentOption.wallet:
        return 'wallet';
      case PaymentOption.gateway:
        return 'gateway';
      default:
        return "";
    }
  }
}

enum TransactionType {
  purchase,
}

enum SdkLayout {
  grid,
  list,
}

extension SdkLayoutName on SdkLayout {
  String get getName {
    switch (this) {
      case SdkLayout.grid:
        return 'grid';
      case SdkLayout.list:
        return 'list';
      default:
        return "grid";
    }
  }
}
