import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController
    with StateMixin<List<UserModel>>, ScrollMixin {
  final UserRepository _userRepository;

  late final Worker workerPage;
  final _page = 1.obs;
  final _limit = 12;

  UserListController({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  void onInit() {
    workerPage = ever<int>(_page, (_) {
      _findUser();
    });
    super.onInit();
  }

  // Responsável quando a tela estiver montada e pronta.
  @override
  void onReady() {
    _findUser();
    super.onReady();
  }

  @override
  void onClose() {
    workerPage();
  }

  Future<void> _findUser() async {
    final result = await _userRepository.getAllUsers(_page.value, _limit);

    final stateResult = state ?? [];
    stateResult.addAll(result);

    change(stateResult, status: RxStatus.success());
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onEndScroll() async {
    _page.value++;
  }
}
