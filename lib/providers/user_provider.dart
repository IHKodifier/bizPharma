import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dataconnect_generated/biz_pharma.dart';

// Notifier for the current logged-in user (from Data Connect)
class UserNotifier extends Notifier<GetUserByAuthIdUser?> {
  @override
  GetUserByAuthIdUser? build() => null;

  void setUser(GetUserByAuthIdUser? user) {
    state = user;
  }
}

final userProvider = NotifierProvider<UserNotifier, GetUserByAuthIdUser?>(
  UserNotifier.new,
);

// Notifier for the current business linked to the user
class BusinessNotifier extends Notifier<GetBusinessByIdBusiness?> {
  @override
  GetBusinessByIdBusiness? build() => null;

  void setBusiness(GetBusinessByIdBusiness? business) {
    state = business;
  }
}

final businessProvider =
    NotifierProvider<BusinessNotifier, GetBusinessByIdBusiness?>(
      BusinessNotifier.new,
    );
