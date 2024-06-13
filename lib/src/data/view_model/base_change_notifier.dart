import 'package:flutter/foundation.dart';
import 'package:mca_official_flutter_sdk/locator.dart';
import 'package:mca_official_flutter_sdk/src/data/repositories/form_repo.dart';
import 'package:mca_official_flutter_sdk/src/data/repositories/init_repo.dart';
import 'package:mca_official_flutter_sdk/src/data/repositories/payment_repo.dart';
import 'package:mca_official_flutter_sdk/src/data/repositories/product_repo.dart';
import '../../utils/navigator_handler.dart';
import '../api_config/app_logger.dart';
import '../api_config/local_cache.dart';
import '../repositories/user_repo.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late UserRepository userRepository;
  late ProductRepository productRepository;
  late FormRepository formRepository;
  late InitRepository initRepository;
  late InitRepository initRepositoryV2;
  late PaymentRepository paymentRepository;
  late LocalCache localCache;
  late NavigationHandler navigationHandler;

  BaseChangeNotifier({
    UserRepository? userRepository,
    ProductRepository? productRepository,
    FormRepository? formRepository,
    PaymentRepository? paymentRepository,
    LocalCache? localCache,
    NavigationHandler? navigationHandler,
    InitRepository? initRepository,
  }) {
    this.userRepository = userRepository ?? locator();
    this.productRepository = productRepository ?? locator();
    this.formRepository = formRepository ?? locator();
    this.paymentRepository = paymentRepository ?? locator();
    this.localCache = localCache ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
    this.initRepository = initRepository ?? locator();
  }

  // ignore: prefer_final_fields
  bool _loading = false;

  bool get loading => _loading;
  void log(Object? e) {
    AppLogger.log("$e");
  }
}
