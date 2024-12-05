import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';

AppLocalizations get l10n =>
    AppLocalizations.of(locator<NavigationService>().getNavigationContext())!;
