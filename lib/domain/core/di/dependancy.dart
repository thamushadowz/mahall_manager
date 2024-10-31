import 'package:get/get.dart';

import '../../../config.dart';
import '../../../infrastructure/dal/services/api_service.dart';
import '../../listing/listing_repository.dart';
import '../../listing/listing_service.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut<ApiService>(
      () => ApiService(
          baseUrl: ConfigEnvironments.getEnvironments()['url'] ?? ""),
    );
    Get.lazyPut<ListingService>(() => ListingRepository());
  }
}
