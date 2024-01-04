// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/repository/init_hive_repository.dart' as _i3;
import '../data/repository/localization_repository.dart' as _i4;
import '../data/repository/tasks_repository.dart' as _i9;
import '../data/todos_remote_source.dart' as _i6;
import '../domain/add_task_use_case.dart' as _i11;
import '../domain/delete_task_use_case.dart' as _i12;
import '../domain/get_tasks_use_case.dart' as _i13;
import '../domain/localization_use_case.dart' as _i5;
import '../domain/update_task_use_case.dart' as _i10;
import '../domain/warmup_app_use_case.dart' as _i7;
import '../presentation/change_language/state/language_state.dart' as _i8;
import '../presentation/tasks/state/task_state.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.InitHiveRepository>(() => _i3.InitHiveRepository());
    gh.singleton<_i4.LocalisationRepository>(_i4.LocalisationRepository());
    gh.factory<_i5.SaveLocalizationUseCase>(
        () => _i5.SaveLocalizationUseCase(gh<_i4.LocalisationRepository>()));
    gh.singleton<_i6.TodosRemoteSource>(_i6.TodosRemoteSource());
    gh.factory<_i7.WarmupAppUseCase>(
        () => _i7.WarmupAppUseCase(gh<_i3.InitHiveRepository>()));
    gh.factory<_i5.GetLocalizationUseCase>(
        () => _i5.GetLocalizationUseCase(gh<_i4.LocalisationRepository>()));
    gh.factory<_i8.LanguageBloc>(() => _i8.LanguageBloc(
          gh<_i5.GetLocalizationUseCase>(),
          gh<_i5.SaveLocalizationUseCase>(),
        ));
    gh.singleton<_i9.TasksRepository>(
        _i9.TasksRepository(gh<_i6.TodosRemoteSource>()));
    gh.singleton<_i10.UpdateTaskUseCase>(
        _i10.UpdateTaskUseCase(repository: gh<_i9.TasksRepository>()));
    gh.singleton<_i11.AddTaskUseCase>(
        _i11.AddTaskUseCase(repository: gh<_i9.TasksRepository>()));
    gh.singleton<_i12.DeleteTaskUseCase>(
        _i12.DeleteTaskUseCase(repository: gh<_i9.TasksRepository>()));
    gh.singleton<_i13.GetTasksUseCase>(
        _i13.GetTasksUseCase(repository: gh<_i9.TasksRepository>()));
    gh.factory<_i14.TasksBloc>(() => _i14.TasksBloc(
          gh<_i13.GetTasksUseCase>(),
          gh<_i11.AddTaskUseCase>(),
          gh<_i12.DeleteTaskUseCase>(),
          gh<_i10.UpdateTaskUseCase>(),
        ));
    return this;
  }
}
