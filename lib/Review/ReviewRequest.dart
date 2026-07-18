import 'package:in_app_review/in_app_review.dart';

class ReviewRequest {
  /// The internal constructor.
  ReviewRequest._internal();

  /// Returns the singleton instance of [ReviewRequest].
  static ReviewRequest get instance => _singletonInstance;

  /// The singleton instance of this [ReviewRequest].
  static final _singletonInstance = ReviewRequest._internal();

  final InAppReview _inAppReview = InAppReview.instance;

  /// レビューダイアログの表示をOSにリクエストする。
  /// 実際に表示されるかはOS側の制御に従う(毎回は表示されない)。
  Future<void> request() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }
}
