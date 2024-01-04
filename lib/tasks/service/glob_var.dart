import 'package:flutter_hw_3/tasks/service/glob_var.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
	
final getIt = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init',
  preferRelativeImports: true, 
  asExtension: true, 
)  
void configureDependencies() => getIt.init();