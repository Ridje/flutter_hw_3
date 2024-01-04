import 'package:flutter_hw_3/tasks/data/repository/init_hive_repository.dart';

class WarmupAppUseCase {
  final initHive = InitHiveRepository();

  Future<void> call() async {
    await initHive();
  }
}