# Flutter BLoC Clean Architecture Template — AI Rules

These are the rules and conventions for this Flutter project. Follow them strictly when generating, modifying, or reviewing code.

---

## Architecture

- **Clean Architecture**: Presentation → Domain → Data. No shortcuts.
- **No DataSource layer**: Repositories call API clients (Retrofit) and services (CacheService, Firebase) directly.
- **Record-based error handling**: Repositories return `(T?, Failure?)` tuples via the base `Repository.asyncGuard<T>()` method. Never throw exceptions from repositories.
- **Use cases**: One public method per use case. Wraps a single repository call. Annotated `@injectable`.

## State Management

- **BLoC + Cubit** via `flutter_bloc`. Dependency injection via `get_it` + `injectable`. NOT Riverpod.
- **Cubit** for simple features (Auth, Profile, Settings). **Bloc** for complex event-driven features (Home, Search, Chat).
- **All states use freezed + enum status pattern**:
  ```dart
  enum FeatureStatus { initial, loading, success, error }

  @freezed
  abstract class FeatureState with _$FeatureState {
    const factory FeatureState({
      @Default(FeatureStatus.initial) FeatureStatus status,
      @Default(null) DataType? data,
      @Default(null) String? error,
    }) = _FeatureState;
  }
  ```
- State and event files are `part of` their cubit/bloc file. Never standalone.
- Use `state.copyWith(status: FeatureStatus.loading)` to emit. Never construct new state instances manually.
- `UserCubit` in `core/user/` is the **global single source of truth** for the logged-in user. Access via `getIt<UserCubit>()`.

## Dependency Injection

- Use `@injectable` for transient instances (Blocs, UseCases).
- Use `@lazySingleton` for singletons (Cubits, Repositories, Services).
- Use `@LazySingleton(as: AbstractRepository)` to bind implementation to abstract class.
- Use `@module` abstract classes for third-party registrations (Dio, SharedPreferences, APIs).
- Use `@preResolve` for async initialization (SharedPreferences).
- Third-party API clients registered in `lib/core/di/register_modules.dart`.
- Access instances with `getIt<T>()`.
- **Run `dart run build_runner build --delete-conflicting-outputs` after any DI annotation change.**

## Networking

- **Dio** as HTTP client. Configured in `register_modules.dart` with base URL from `F.baseUrl`.
- **Retrofit** `@RestApi()` for type-safe API definitions. One API client per feature.
- Each feature API has an `Endpoints` class with static const paths.
- API clients return `Future<HttpResponse>` (Retrofit's HttpResponse).
- Register each new API in `register_modules.dart`: `@lazySingleton YourApi yourApi(Dio dio) => YourApi(dio);`
- **TokenManager** interceptor handles auth headers and 401 token refresh automatically.

## Routing (GoRouter)

- All routes defined as constants in `lib/core/router/routes.dart`.
- Route definitions split into part files: `authentication_routes.dart`, `on_boarding_routes.dart`, `shell_routes.dart`.
- `StatefulShellRoute.indexedStack` for bottom navigation tabs (Home, Profile).
- Navigation: use `context.goNamed(Routes.routeName)` or `context.pushNamed(Routes.routeName)`. Never `Navigator.push`.
- `rootNavigatorKey` is the global navigator key — used by Dio interceptors and navigation service.
- Redirect logic evaluates: auth status → onboarding completion → login state.

## Theme

- **Never use static colors** like `Colors.red`, `Color(0xFF...)`. Always use `context.color.*`.
- **Never use static text styles** like `TextStyle(fontSize: 16)`. Always use `context.textStyle.*`.
- Access colors: `context.color.primary`, `context.color.error`, `context.color.text.primary`, `context.color.appBar.background`.
- Access text styles: `context.textStyle.bodyMedium`, `context.textStyle.headlineLarge`, `context.textStyle.button.primary`.
- To customize a theme text style: `context.textStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)`.
- Adding new colors: modify `color_extension.dart` + `color_variants.dart` + `primitive.dart` in `core/theme/extensions/colors/`.
- Adding component colors (e.g., CardColors): create a part file in `colors/part/`, add abstract class + Light/Dark impls.
- Theme parts for AppBar, Buttons, Input, etc. live in `core/theme/src/part/`.
- `ThemeCubit` manages `ThemeMode` — toggled via `getIt<ThemeCubit>().toggleTheme()`.

## Localization

- **Never hardcode user-facing strings**. Always use `context.locale.keyName`.
- Strings defined in `.arb` files: `lib/core/localization/l10n/app_en.arb`, `app_ar.arb`.
- Parameterized strings: `context.locale.minLengthValidation(8)`.
- Outside widgets: use `someObject.tr?.keyName` via the `object_extensions.dart` extension.
- Adding a string: add to `app_en.arb` → add to `app_ar.arb` → run `flutter gen-l10n`.
- `LocaleCubit` handles locale switching — `getIt<LocaleCubit>().switchLocale()`.

## File & Folder Conventions

- **Feature folder structure**: `data/` (models, repositories, services/network), `domain/` (entities, repositories, use_cases), `presentation/` (cubit or bloc, pages, widgets).
- **Pages folder**: use `pages/` not `view/`.
- **Each widget in its own file**: page-level widgets in `presentation/widgets/`.
- **No `index.dart` inside features**: only use barrel exports in `core/` subfolders.
- **Import `core/base/export.dart`** in all page/widget files.
- **Package imports** for core modules: `import 'package:flutter_template_2025/core/base/export.dart';`

## Responsive Design

- **ScreenUtil** initialized with `375×812` design size.
- Use `.w` for width, `.h` for height, `.sp` for font sizes, `.r` for radius.
- Use `Gap(16)` instead of `SizedBox(height: 16)` for spacing.

## Models & Serialization

- **Entities** in domain layer: plain Dart classes with final fields. No serialization.
- **Models** in data layer: extend entities. Include `fromJson`/`toJson` (manual or dart_mappable).
- For Retrofit request bodies: use manual `toJson() → Map<String, dynamic>` (not dart_mappable's `toJson() → String`).
- For API response parsing: use `dart_mappable` with `@MappableClass(generateMethods: GenerateMethods.decode)` for decode-only.
- Freezed for: states, events, exceptions, failures, results. NOT for entities or models.

## Error Handling

- **In repositories**: wrap API calls with `asyncGuard<T>()` which returns `(T?, Failure?)`.
- **In cubits/blocs**: destructure the result: `final (data, failure) = await useCase();`
- **Never try/catch in use cases or presentation layer** — the repository handles it.
- `Failure` has a `type` (FailureType enum) and `message`. Mapped from DioException, CustomException, TypeError.

## Code Generation

- `dart run build_runner build --delete-conflicting-outputs` — after any injectable/freezed/retrofit/dart_mappable change.
- `dart run build_runner watch --delete-conflicting-outputs` — during active development.
- `flutter gen-l10n` — after `.arb` file changes (also runs during build).
- `flutter pub run flutter_flavorizr` — after `flavorizr.yaml` changes.

## Config & Flavors

- 4 flavors: `dev`, `qa`, `uat`, `prod` — configured in `lib/core/config/flavor.dart`.
- Access via `F.baseUrl`, `F.apiTimeout`, `F.title`, `F.appFlavor`, `F.isDev`, etc.
- Never hardcode base URLs or timeouts — always use `F.*`.
- Run with: `flutter run --flavor dev --dart-define=flavor=dev`.

## Cache & Persistence

- `CacheService` abstraction over `SharedPreferences`.
- Keys defined in `CacheKey` enum: `accessToken`, `refreshToken`, `isOnBoardingCompleted`, `isLoggedIn`, `rememberMe`, `rememberedEmail`, `rememberedPassword`, `language`, `user`.
- Usage: `cacheService.save<bool>(CacheKey.isLoggedIn, true)`, `cacheService.get<String>(CacheKey.accessToken)`.
- To add a cache key: add to `CacheKey` enum in `cache_service.dart`.

## Logger

- Use `Log.debug()`, `Log.info()`, `Log.warning()`, `Log.error()`, `Log.fatal()`.
- Never use `print()` or `debugPrint()` for logging.

## Toast Notifications

- **toastification** package with `ToastificationWrapper` wrapping the app in `main.dart`.
- Toast methods via **BuildContext extension** in `lib/core/utils/app_toast.dart`.
- Usage: `context.showSuccess(title: 'Done', message: 'Saved successfully')`.
- Available methods: `context.showSuccess()`, `context.showError()`, `context.showWarning()`, `context.showInfo()`, `context.dismissAllToasts()`.
- Error toasts have 6s duration, warning 5s, others 4s by default.
- Style: `ToastificationStyle.flatColored`, `Alignment.topCenter`, drag-to-close.
- **Never use `ScaffoldMessenger.showSnackBar`** — use `context.showError()`, `context.showSuccess()`, etc.
- Parameters: `title` (required), `message` (optional), `duration`, `alignment`, `showProgressBar`.

## Validators & Utils

- Use `Validators.validateEmail()`, `Validators.validatePassword()`, etc. from `core/utils/validators.dart`.
- Use `Formatters.formatDate()`, `Formatters.formatCurrency()` from `core/utils/formatters.dart`.
- Use `AppConstants` from `core/utils/constants.dart` for magic numbers and regex patterns.

## What NOT To Do

- Don't create DataSource classes between repository and API.
- Don't throw exceptions from repositories — return `(T?, Failure?)`.
- Don't use `Colors.*` or inline `Color(...)` — use `context.color.*`.
- Don't use inline `TextStyle(...)` — use `context.textStyle.*`.
- Don't hardcode strings — use `context.locale.*`.
- Don't use `Navigator.push/pop` — use GoRouter.
- Don't use `setState` for business logic — use Cubit/Bloc.
- Don't use `print()` — use `Log.*`.
- Don't use `SizedBox` for spacing — use `Gap`.
- Don't use `ScaffoldMessenger.showSnackBar` or raw `toastification.show()` — use `context.showSuccess()`, `context.showError()`, etc.
- Don't create singleton instances manually — use `@lazySingleton` + `getIt<T>()`.
- Don't edit `.g.dart`, `.freezed.dart`, `.mapper.dart`, `.config.dart` files — they are generated.
- Don't add features without running `build_runner` after annotating files.
