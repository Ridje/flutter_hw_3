import 'package:flutter_hw_3/tasks/data/repository/localization_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class InitHiveRepository {
  Future<void> call() async {
    await Hive.initFlutter();
    await Hive.openBox<String?>(localizationBox);
  }
}