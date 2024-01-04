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
import '../domain/localization_use_case.dart' as _i5;
import '../domain/warmup_app_use_case.dart' as _i6;
import '../presentation/change_language/state/language_state.dart' as _i7;

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
    gh.factory<_i6.WarmupAppUseCase>(
        () => _i6.WarmupAppUseCase(gh<_i3.InitHiveRepository>()));
    gh.factory<_i5.GetLocalizationUseCase>(
        () => _i5.GetLocalizationUseCase(gh<_i4.LocalisationRepository>()));
    gh.factory<_i7.LanguageBloc>(() => _i7.LanguageBloc(
          gh<_i5.GetLocalizationUseCase>(),
          gh<_i5.SaveLocalizationUseCase>(),
        ));
    return this;
  }
}
