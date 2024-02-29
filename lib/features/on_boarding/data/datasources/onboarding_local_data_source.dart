
abstract class OnBoardingLocalDataSource {
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserFirstTimer();
}

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {

  @override
  Future<void> cacheFirstTimer() {
    // TODO: implement cacheFirstTimer
    throw UnimplementedError();
  }

  @override
  Future<bool> checkIfUserFirstTimer() {
    // TODO: implement checkIfUserFirstTimer
    throw UnimplementedError();
  }

}