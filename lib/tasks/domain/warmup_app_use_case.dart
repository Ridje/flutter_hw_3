import 'package:flutter_hw_3/tasks/data/repository/init_hive_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class WarmupAppUseCase {
  final InitHiveRepository initHive;

  WarmupAppUseCase(this.initHive);

  Future<void> call() async {
    await initHive();
  }
}