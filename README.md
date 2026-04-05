# Flutter BLoC Clean Architecture Template (2025)

A production-ready Flutter template with **BLoC/Cubit** state management, **Clean Architecture**, **get_it + injectable** dependency injection, **GoRouter** navigation, **Retrofit + Dio** networking, multi-flavor support, and a complete theme system with light/dark mode.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Architecture Overview](#architecture-overview)
- [Folder Structure](#folder-structure)
- [App Startup Flow](#app-startup-flow)
- [Router & Navigation](#router--navigation)
- [State Management](#state-management)
- [Dependency Injection](#dependency-injection)
- [Networking (Dio + Retrofit)](#networking-dio--retrofit)
- [Theme System](#theme-system)
- [Localization](#localization)
- [Error Handling](#error-handling)
- [Toast Notifications](#toast-notifications)
- [App Security (freeRASP)](#app-security-freerasp)
- [Screen Capture Protection](#screen-capture-protection)
- [Creating a New Feature](#creating-a-new-feature)
- [Code Generation](#code-generation)
- [Flavors](#flavors)
- [Key Conventions](#key-conventions)

---

## Quick Start

```bash
# Install dependencies
flutter pub get

# Generate code (injectable, freezed, retrofit, dart_mappable)
dart run build_runner build --delete-conflicting-outputs

# Run with flavor
flutter run --flavor dev --dart-define=flavor=dev

# Run build_runner in watch mode during development
dart run build_runner watch --delete-conflicting-outputs
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                     │
│  Pages → Widgets → Cubit/Bloc → State (freezed + enum)  │
├─────────────────────────────────────────────────────────┤
│                      Domain Layer                        │
│         Use Cases → Repository (abstract) → Entities     │
├─────────────────────────────────────────────────────────┤
│                       Data Layer                         │
│    Repository Impl → API (Retrofit) → Models             │
│    (Repos call services directly)                        │
└─────────────────────────────────────────────────────────┘
```

**Key decisions:**
- **Repositories call services directly** — API clients (Retrofit), CacheService, Firebase, etc.
- **Record-based error handling** — `(T?, Failure?)` tuples via `asyncGuard` in the base `Repository`
- **Global `UserCubit`** — single source of truth for the logged-in user, lives in `core/user/`
- **Freezed + enum status** for ALL state classes — consistent `state.copyWith(status: ...)` pattern

---

## Folder Structure

```
lib/
├── main.dart                          # Entry point, flavor init, DI, runApp
│
├── core/                              # Shared infrastructure
│   ├── base/
│   │   ├── export.dart                # Centralized exports (Material, BLoC, GoRouter, etc.)
│   │   ├── repository.dart            # Abstract base with asyncGuard<T> / guard<T>
│   │   └── models/
│   │       ├── failure.dart           # Freezed Failure + FailureType enum + DioException mapping
│   │       ├── exceptions.dart        # Freezed CustomException variants
│   │       ├── result.dart            # Freezed Result<T, E> (success/error)
│   │       └── status.dart            # Generic Status enum with extensions
│   │
│   ├── config/
│   │   ├── flavor.dart                # Flavor enum (dev/qa/uat/prod) + F class with baseUrl, apiTimeout, feature flags
│   │   └── app_config.dart            # Static app metadata (appName, packageName)
│   │
│   ├── di/
│   │   ├── injectable.dart            # GetIt instance + configureDependencies()
│   │   ├── injectable.config.dart     # Generated — DO NOT EDIT
│   │   └── register_modules.dart      # Manual DI: SharedPreferences → CacheService → Dio → Feature APIs
│   │
│   ├── router/
│   │   ├── router.dart                # GoRouter config + redirect logic + GoRouterRefreshStream
│   │   ├── routes.dart                # Route path constants
│   │   └── parts/
│   │       ├── authentication_routes.dart
│   │       ├── on_boarding_routes.dart
│   │       └── shell_routes.dart      # StatefulShellRoute (bottom nav)
│   │
│   ├── services/
│   │   ├── cache/
│   │   │   ├── cache_service.dart     # CacheKey enum + abstract CacheService
│   │   │   └── shared_preference_service.dart  # SharedPreferences implementation
│   │   ├── interceptor/
│   │   │   └── token_manager.dart     # Dio interceptor: auth header, 401 refresh, queue
│   │   ├── navigation_service.dart    # Global navigator key access
│   │   ├── analytics_service.dart     # Analytics (stub)
│   │   ├── connectivity_service.dart  # Network monitoring (stub)
│   │   ├── notification_service.dart  # Local notifications (stub)
│   │   └── security/
│   │       ├── app_security_service.dart       # freeRASP initialization + threat callbacks
│   │       ├── threat_type.dart                # ThreatType enum (title, message, isBlocking)
│   │       ├── screen_protection_service.dart  # Route-based screen capture blocking
│   │       └── screen_protection_observer.dart # GoRouter listener for auto block/unblock
│   │
│   ├── theme/
│   │   ├── theme.dart                 # context.color, context.textStyle, context.lightTheme, context.darkTheme
│   │   ├── theme_cubit.dart           # ThemeCubit: toggleTheme(), setTheme()
│   │   ├── src/
│   │   │   ├── theme_data.dart        # $LightThemeData / $DarkThemeData builders
│   │   │   └── part/                  # AppBar, Button, Input, etc. theme parts
│   │   └── extensions/
│   │       ├── colors/
│   │       │   ├── color_extension.dart   # ColorExtension class (all color fields)
│   │       │   ├── color_variants.dart    # LightColorExtension / DarkColorExtension
│   │       │   ├── primitive.dart         # _Primitive color constants
│   │       │   └── part/                  # AppBarColors, TextColors, etc.
│   │       └── text_styles/
│   │           ├── text_style_extension.dart  # TextStyleExtension class
│   │           ├── text_style_variants.dart   # Light/Dark variants
│   │           ├── primitive.dart             # _Primitive text style constants
│   │           └── part/                      # AppBarTextStyles, BodyTextStyles, etc.
│   │
│   ├── localization/
│   │   ├── locale_cubit.dart          # LocaleCubit: switchLocale(), persists to SharedPreferences
│   │   └── l10n/
│   │       ├── app_en.arb             # English strings
│   │       ├── app_ar.arb             # Arabic strings
│   │       └── app_localizations.dart # Generated
│   │
│   ├── user/
│   │   ├── user_entity.dart           # User class (id, username, email, etc.)
│   │   ├── user_model.dart            # UserModel: fromMap/toMap/fromJson/toJson/fromUser
│   │   ├── user_cubit.dart            # @lazySingleton — global user state
│   │   └── user_state.dart            # Freezed: UserStatus { initial, loaded, guest }
│   │
│   ├── context_extensions/
│   │   ├── context_extensions.dart    # context.locale, pushNamedAndRemoveUntil
│   │   └── object_extensions.dart     # .globalContext, .tr for non-widget localization
│   │
│   ├── utils/
│   │   ├── app_toast.dart             # BuildContext extension: context.showSuccess(), showError(), etc.
│   │   ├── validators.dart            # Validators.validateEmail, validatePassword, etc.
│   │   ├── constants.dart             # AppConstants (timeouts, regex, page sizes)
│   │   ├── formatters.dart            # Formatters.formatDate, formatCurrency, etc.
│   │   ├── helpers.dart               # Helpers.executeWithRetry, debounce, throttle
│   │   └── enums.dart                 # Shared enums (LoadingStatus, SortOrder, etc.)
│   │
│   ├── widgets/
│   │   ├── app_startup/
│   │   │   ├── app_startup_widget.dart    # Shows SplashPage or error
│   │   │   └── startup_error_widget.dart  # Error UI with retry
│   │   ├── splash/
│   │   │   └── splash_page.dart       # Splash screen UI
│   │   ├── navigation_shell.dart      # BottomNavigationBar shell
│   │   ├── loading_indicator.dart     # Reusable loading spinner
│   │   ├── link_text.dart             # Tappable rich text
│   │   └── security/
│   │       └── threat_warning_page.dart   # Full-screen threat warning (blocking/non-blocking)
│   │
│   └── logger/
│       └── log.dart                   # Log.debug(), Log.error(), Log.info(), etc.
│
├── features/
│   ├── authentication/                # Cubit pattern
│   │   ├── data/
│   │   │   ├── models/                # LoginRequestModel, LoginResponseModel, SignUpModel
│   │   │   ├── repositories/          # AuthRepositoryApiImpl, AuthRepositoryFirebaseImpl
│   │   │   └── services/
│   │   │       └── network/           # AuthApi (Retrofit), AuthEndpoints
│   │   ├── domain/
│   │   │   ├── entities/              # LoginEntity, SignUpEntity, RememberMeEntity
│   │   │   ├── repositories/          # AuthRepository (abstract)
│   │   │   └── use_cases/             # LoginUseCase, LogoutUseCase, SignUpUseCase, RememberMeUseCase
│   │   └── presentation/
│   │       ├── cubit/                 # AuthCubit + AuthState (freezed)
│   │       ├── login/
│   │       │   ├── page/              # LoginPage (StatefulWidget)
│   │       │   └── widgets/           # LoginForm, LoginFormFooter, LanguageSwitcher
│   │       ├── registration/
│   │       │   └── pages/             # RegistrationPage
│   │       └── forgot_password/
│   │           └── pages/             # ResetPasswordPage, EmailVerificationPage, etc.
│   │
│   ├── home/                          # Bloc pattern
│   │   ├── data/
│   │   │   ├── models/                # HomeModel
│   │   │   ├── repositories/          # HomeRepositoryImpl
│   │   │   └── services/
│   │   │       └── network/           # HomeApi (Retrofit), HomeEndpoints
│   │   ├── domain/
│   │   │   ├── entities/              # HomeEntity
│   │   │   ├── repositories/          # HomeRepository (abstract)
│   │   │   └── use_cases/             # GetHomeItemsUseCase
│   │   └── presentation/
│   │       ├── bloc/                  # HomeBloc + HomeEvent + HomeState (all freezed)
│   │       ├── pages/                 # HomePage
│   │       └── widgets/               # CarouselBanner, FeaturedSection, etc.
│   │
│   ├── profile/                       # Cubit pattern
│   │   ├── data/
│   │   │   ├── models/                # ProfileModel
│   │   │   ├── repositories/          # ProfileRepositoryImpl
│   │   │   └── services/
│   │   │       └── network/           # ProfileApi (Retrofit), ProfileEndpoints
│   │   ├── domain/
│   │   │   ├── entities/              # ProfileEntity
│   │   │   ├── repositories/          # ProfileRepository (abstract)
│   │   │   └── use_cases/             # GetProfileUseCase
│   │   └── presentation/
│   │       ├── cubit/                 # ProfileCubit + ProfileState (freezed)
│   │       └── pages/                 # ProfilePage, InstagramProfilePage
│   │
│   └── onboarding/                    # Presentation-only (no data/domain)
│       └── presentation/
│           └── pages/                 # OnboardingPage, OnboardingModel
```

---

## App Startup Flow

```
main() → WidgetsBinding → Flavor init → configureDependencies() → runApp(MyApp)
  │
  ▼
MyApp (MaterialApp.router)
  ├── MultiBlocProvider (LocaleCubit, ThemeCubit)
  ├── ScreenUtilInit (375×812 design size)
  ├── routerConfig: getIt<GoRouter>()
  └── Debug: Flavor banner (dev=green, qa=orange, uat=blue, prod=red)
  │
  ▼
GoRouter initialLocation: "/" → AppStartupWidget
  │
  ├── AuthCubit constructor calls _checkAuthStatus()
  │   ├── UserCubit.loadFromCache() → reads cached user JSON
  │   └── Emits: authenticated (user found) or unauthenticated (no user)
  │
  ├── While AuthStatus.unknown / .loading → redirect returns null → stays on "/"
  │   └── AppStartupWidget shows SplashPage (or error UI on failure)
  │
  ├── Auth settles → redirect evaluates:
  │   ├── Not onboarded → /onboarding
  │   ├── Onboarded + not logged in → /login
  │   └── Onboarded + logged in → /home
  │
  └── GoRouterRefreshStream listens to authCubit.stream.distinct()
      └── Every auth state change triggers redirect re-evaluation
```

---

## Router & Navigation

### Redirect Logic (priority order)

| # | Condition | Action |
|---|-----------|--------|
| 1 | Auth is `unknown` or `loading` | Return `null` (stay on current page — splash visible) |
| 2 | Not onboarded (`CacheKey.isOnBoardingCompleted == false`) | → `/onboarding` (unless already there) |
| 3 | Onboarded + not logged in + on protected page | → `/login` |
| 4 | Onboarded + not logged in + on public auth page | Stay (return `null`) |
| 5 | Logged in + navigating to `/login`, `/onboarding`, `/`, `/splash` | → `/home` |
| 6 | Otherwise | Stay (return `null`) |

**Public pages** (accessible when not logged in): login, registration, reset-password, email-verification, create-new-password, reset-password-success.

### Route Structure

```
/                          → AppStartupWidget (splash/error)
/splash                    → SplashPage
/onboarding                → OnboardingPage
/login                     → LoginPage
/login/registration        → RegistrationPage
/login/reset-password      → ResetPasswordPage
  /email-verification      → EmailVerificationPage
  /create-new-password     → CreateNewPasswordPage
    /reset-password-success → ResetPasswordSuccessPage
/home                      → HomePage (Shell tab 1)
  /home/profile            → ProfilePage (nested under home)
/profile                   → ProfilePage (Shell tab 2)
```

### Adding a New Route

1. Add the path constant in `lib/core/router/routes.dart`
2. Add the `GoRoute` in the appropriate part file (`shell_routes.dart`, `authentication_routes.dart`, etc.)
3. Create the page widget in the feature's `presentation/pages/` folder

---

## State Management

### Pattern: Freezed + Enum Status

Every state class follows this pattern:

```dart
// In the state file (part of cubit/bloc):
enum FeatureStatus { initial, loading, success, error }

@freezed
abstract class FeatureState with _$FeatureState {
  const factory FeatureState({
    @Default(FeatureStatus.initial) FeatureStatus status,
    @Default(null) SomeEntity? data,
    @Default(null) String? error,
  }) = _FeatureState;
}
```

**Usage in cubit/bloc:**
```dart
emit(state.copyWith(status: FeatureStatus.loading, error: null));
// ... do work ...
emit(state.copyWith(status: FeatureStatus.success, data: result));
```

**Usage in UI:**
```dart
BlocBuilder<FeatureCubit, FeatureState>(
  builder: (context, state) {
    return switch (state.status) {
      FeatureStatus.initial => const SizedBox.shrink(),
      FeatureStatus.loading => const LoadingIndicator(),
      FeatureStatus.success => SuccessWidget(data: state.data!),
      FeatureStatus.error => ErrorWidget(message: state.error!),
    };
  },
)
```

### Cubit (simpler features)

State file is `part of` the cubit file. Used by: Auth, Profile, User, Theme, Locale.

```dart
// feature_cubit.dart
part 'feature_state.dart';
part 'feature_cubit.freezed.dart';

@lazySingleton  // or @injectable
class FeatureCubit extends Cubit<FeatureState> {
  final SomeUseCase useCase;
  FeatureCubit(this.useCase) : super(const FeatureState());

  Future<void> doSomething() async {
    emit(state.copyWith(status: FeatureStatus.loading));
    final (result, failure) = await useCase();
    if (failure != null) {
      emit(state.copyWith(status: FeatureStatus.error, error: failure.message));
      return;
    }
    emit(state.copyWith(status: FeatureStatus.success, data: result));
  }
}
```

### Bloc (complex features with events)

All files are `part of` the bloc file. Used by: Home.

```dart
// feature_bloc.dart
part 'feature_event.dart';
part 'feature_state.dart';
part 'feature_bloc.freezed.dart';

@injectable
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final SomeUseCase useCase;

  FeatureBloc(this.useCase) : super(const FeatureState()) {
    on<_LoadFeature>(_onLoad);
  }

  Future<void> _onLoad(_LoadFeature event, Emitter<FeatureState> emit) async {
    emit(state.copyWith(status: FeatureStatus.loading));
    // ...
  }
}

// feature_event.dart
part of 'feature_bloc.dart';

@freezed
class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.load() = _LoadFeature;
  const factory FeatureEvent.refresh() = _RefreshFeature;
}
```

### When to Use Cubit vs Bloc

| Use Cubit | Use Bloc |
|-----------|----------|
| Simple CRUD operations | Complex event-driven flows |
| Direct method calls (`cubit.load()`) | Need event traceability |
| Auth, Profile, Settings | Home feed, Search, Chat |
| Fewer than 5 operations | Many distinct events/transformers |

---

## Dependency Injection

### How It Works

1. **`@injectable` / `@lazySingleton`** annotations on classes → auto-registered by `injectable_generator`
2. **`@module` abstract classes** in `register_modules.dart` → manual registration for third-party deps
3. **`@preResolve`** on `SharedPreferences` → resolved before app starts (async)
4. **`getIt<T>()`** to retrieve instances anywhere

### Registration Chain

```
SharedPreferences (@preResolve)
    └─► CacheService (@lazySingleton)
        └─► Dio (@lazySingleton) ── uses F.baseUrl, F.apiTimeout
        │   ├── TokenManager interceptor (uses CacheService + rootNavigatorKey)
        │   └── PrettyDioLogger (debug only)
        └─► GoRouter (@singleton) ── uses AuthCubit + CacheService
            └─► Feature APIs (@lazySingleton each)
                ├── AuthApi(dio)
                ├── HomeApi(dio)
                └── ProfileApi(dio)
```

### DI Annotations Quick Reference

| Annotation | Scope | Use For |
|-----------|-------|---------|
| `@injectable` | New instance each time | Blocs, transient use cases |
| `@lazySingleton` | Single instance (lazy) | Cubits, repositories, services |
| `@singleton` | Single instance (eager) | Router |
| `@LazySingleton(as: AbstractClass)` | Bind impl → interface | Repository implementations |
| `@module` | Manual registration | Third-party classes (Dio, SharedPrefs) |
| `@preResolve` | Async init before app | SharedPreferences |

---

## Networking (Dio + Retrofit)

### Dio Setup (`register_modules.dart`)

- **Base URL**: from `F.baseUrl` (flavor-dependent)
- **Timeouts**: from `F.apiTimeout` (dev/qa: 60s, uat/prod: 30s)
- **Interceptors**:
  1. `TokenManager` — injects `Authorization: Bearer <token>`, handles 401 refresh
  2. `PrettyDioLogger` — logs requests/responses (debug only)

### Retrofit API Client Pattern

Each feature has its own API client:

```dart
// lib/features/your_feature/data/services/network/your_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'your_endpoints.dart';

part 'your_api.g.dart';  // Generated by retrofit_generator

@RestApi()
abstract class YourApi {
  factory YourApi(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) = _YourApi;

  @GET(YourEndpoints.items)
  Future<HttpResponse> getItems();

  @POST(YourEndpoints.create)
  Future<HttpResponse> create(@Body() Map<String, dynamic> body);
}
```

```dart
// lib/features/your_feature/data/services/network/your_endpoints.dart
class YourEndpoints {
  static const String items = '/your-feature/items';
  static const String create = '/your-feature/create';
}
```

### Registering a New API

Add to `lib/core/di/register_modules.dart`:

```dart
@lazySingleton
YourApi yourApi(Dio dio) => YourApi(dio);
```

Then run `dart run build_runner build --delete-conflicting-outputs`.

### Token Flow

1. **Login** → API returns access token + refresh token → saved to `CacheService`
2. **Every request** → `TokenManager.onRequest` reads access token from cache → adds to header
3. **401 response** → `TokenManager.onError` queues concurrent requests → calls refresh endpoint → retries all with new token
4. **Refresh fails** → clears tokens → navigates to login

---

## Theme System

### Usage in Widgets

```dart
// Colors — NEVER use static colors like Colors.red
context.color.primary
context.color.error
context.color.scaffoldBackground
context.color.text.primary       // Component-specific
context.color.appBar.background
context.color.bottomNavBar.selectedItem

// Text styles — NEVER use static TextStyle()
context.textStyle.headlineLarge
context.textStyle.bodyMedium
context.textStyle.button.primary  // Component-specific
context.textStyle.appBar.title

// Theme mode
getIt<ThemeCubit>().toggleTheme();
getIt<ThemeCubit>().setTheme(ThemeMode.dark);
```

### Adding New Colors

1. Add the field to `ColorExtension` in `color_extension.dart`
2. Set the light value in `LightColorExtension` in `color_variants.dart`
3. Set the dark value in `DarkColorExtension` in `color_variants.dart`
4. Add primitive constants in `primitive.dart` if needed
5. Update `copyWith` and `lerp` in both variants

### Adding Component Colors (e.g., CardColors)

1. Create `lib/core/theme/extensions/colors/part/card_colors.dart`:
   ```dart
   part of '../colors.dart';

   abstract class CardColors {
     const CardColors();
     Color get background;
     Color get border;
     Color get shadow;
   }

   class _LightCardColors extends CardColors {
     const _LightCardColors();
     @override Color get background => _Primitive.neutral0;
     @override Color get border => _Primitive.neutral30;
     @override Color get shadow => _Primitive.neutral20;
   }

   class _DarkCardColors extends CardColors {
     const _DarkCardColors();
     @override Color get background => _Primitive.neutral60;
     @override Color get border => _Primitive.neutral50;
     @override Color get shadow => _Primitive.neutral90;
   }
   ```
2. Add `part 'part/card_colors.dart';` in `colors.dart`
3. Add `required this.card` → `final CardColors card;` in `ColorExtension`
4. Set `card: const _LightCardColors()` in light variant, `card: const _DarkCardColors()` in dark

### Adding Component Text Styles

Same pattern — create a part file in `text_styles/part/`, add to `TextStyleExtension`, set in variants.

---

## Localization

### Usage in Widgets

```dart
// NEVER hardcode strings. Always use localization:
Text(context.locale.login)          // "Login" / "تسجيل الدخول"
Text(context.locale.emailRequired)  // "Email is required"

// With parameters:
context.locale.minLengthValidation(8)  // "Must be at least 8 characters"

// Outside widgets (using object extension):
someObject.tr?.login  // Access via global context
```

### Adding New Strings

1. Add the key + value to `lib/core/localization/l10n/app_en.arb`:
   ```json
   "yourKey": "Your string",
   "@yourKey": { "description": "Description for translators" }
   ```
2. Add the translation to `app_ar.arb`
3. Run `flutter gen-l10n` (auto-runs on build)
4. Use: `context.locale.yourKey`

### Adding a New Locale

1. Create `lib/core/localization/l10n/app_XX.arb`
2. Add `const Locale('XX')` to `supportedLocales` in `MaterialApp.router`
3. Update `LocaleCubit.switchLocale()` to include the new locale
4. Update `AppLocalizationExtension.getLanguageName()` in `context_extensions.dart`

---

## Error Handling

### Record-Based Pattern: `(T?, Failure?)`

Repositories return tuples — no thrown exceptions in the domain/presentation layers:

```dart
// In repository implementation
@override
Future<(LoginResponseEntity?, Failure?)> login(LoginRequestEntity data) {
  return asyncGuard(() async {
    final response = await api.login(model);
    // ... process response ...
    return loginResponse;
  });
}

// In cubit/bloc
final (response, failure) = await loginUseCase(data);
if (failure != null) {
  emit(state.copyWith(status: AuthStatus.error, error: failure.message));
  return;
}
// Use response
```

### Failure Mapping

`asyncGuard` in the base `Repository` automatically catches exceptions and maps them:

| Exception Type | FailureType |
|---------------|-------------|
| `DioException.connectionTimeout` | `.timeout` |
| `DioException.badResponse` (4xx/5xx) | `.badResponse` |
| `DioException.connectionError` | `.network` |
| `CustomException.validation` | `.validation` |
| `CustomException.unauthorized` | `.unauthorized` |
| `CustomException.notFound` | `.notFound` |
| `TypeError` | `.typeError` |
| Everything else | `.unknown` |

---

## Toast Notifications

The project uses **toastification** with a `BuildContext` extension for consistent, styled toast messages.

### Setup

`ToastificationWrapper` wraps the entire app in `main.dart` — no additional setup needed.

### Usage

```dart
// Import the extension
import 'package:flutter_template_2025/core/utils/app_toast.dart';

// Show toasts via context
context.showSuccess(title: 'Done', message: 'Profile saved successfully');
context.showError(title: 'Login Failed', message: state.error!);
context.showWarning(title: 'Careful', message: 'Check your input');
context.showInfo(title: 'Tip', message: 'Pull down to refresh');

// Dismiss all active toasts
context.dismissAllToasts();
```

### Available Methods

| Method | Default Duration | Use Case |
|--------|-----------------|----------|
| `context.showSuccess()` | 4s | Successful operations |
| `context.showError()` | 6s | Errors and failures |
| `context.showWarning()` | 5s | Non-critical warnings |
| `context.showInfo()` | 4s | Informational tips |
| `context.dismissAllToasts()` | — | Clear all toasts |

### Parameters

All toast methods accept:
- `title` (required) — bold heading text
- `message` (optional) — description text below the title
- `duration` — override the default auto-close duration
- `alignment` — override position (default: `Alignment.topCenter`)
- `showProgressBar` — show/hide the auto-close progress bar (default: `true`)

### In BlocListener

```dart
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state.status == AuthStatus.error && state.error != null) {
      context.showError(
        title: context.locale.login,
        message: state.error!,
      );
    }
  },
  child: // ...
)
```

> **Never use `ScaffoldMessenger.showSnackBar`** — always use `context.showSuccess()`, `context.showError()`, etc.

---

## App Security (freeRASP)

The template integrates **freeRASP** (`freerasp`) for runtime application self-protection (RASP), protecting against reverse engineering, tampering, rooted/jailbroken devices, hooking frameworks, and more.

### Architecture

```
lib/core/
├── services/security/
│   ├── app_security_service.dart  # Singleton — configures & starts freeRASP
│   └── threat_type.dart           # ThreatType enum with title, message, isBlocking
└── widgets/security/
    └── threat_warning_page.dart   # Full-screen modal for detected threats
```

### How It Works

1. `AppInitializer.initialize()` is called in `main()` after DI, which calls `AppSecurityService.instance.initialize()`.
2. It configures `TalsecConfig` with per-flavor package names, bundle IDs, and `isProd` from `F.isProd`.
3. `ThreatCallback` is attached — each threat type maps to a `ThreatType` enum value.
4. When a threat is detected, `ThreatWarningPage` is pushed as a full-screen modal over the current screen via `rootNavigatorKey`.

### Threat Categories

| Threat | Type | Behavior |
|--------|------|----------|
| Root/Jailbreak | Blocking | "Close App" only |
| Hooking (Frida, etc.) | Blocking | "Close App" only |
| App Tampering | Blocking | "Close App" only |
| Debugger Attached | Blocking | "Close App" only |
| Unofficial Store | Blocking | "Close App" only |
| Malware Detected | Blocking | "Close App" only |
| Passcode Not Set | Non-blocking | "I Understand" dismiss |
| VPN Active | Non-blocking | "I Understand" dismiss |
| Developer Mode | Non-blocking | "I Understand" dismiss |
| ADB/USB Debugging | Non-blocking | "I Understand" dismiss |
| Screenshot | Non-blocking | "I Understand" dismiss |
| Screen Recording | Non-blocking | "I Understand" dismiss |
| Emulator/Simulator | Non-blocking | "I Understand" dismiss |
| Device Binding | Non-blocking | "I Understand" dismiss |

### Configuration

Per-flavor config is in `AppSecurityService`:

```dart
// Android package names per flavor
'com.fluttertemplate2025.dev'  // dev
'com.fluttertemplate2025.qa'   // qa
'com.fluttertemplate2025.uat'  // uat
'com.fluttertemplate2025'      // prod
```

### Before Production Release

Three items must be updated in `app_security_service.dart`:

1. **Android signing hash** — Replace `_debugSigningHash` with your release keystore's SHA-256 hash in Base64:
   ```bash
   # Get the SHA-256 fingerprint
   keytool -list -v -keystore your-release.jks -storepass <password>

   # Convert to Base64 (copy the SHA256 line)
   echo "AB:CD:EF:..." | tr -d ':' | xxd -r -p | base64
   ```
   For Google Play App Signing: Play Console → Setup → App signing → SHA-256.

2. **iOS Team ID** — Replace `M8AK35` placeholder with your Apple Developer Team ID from [developer.apple.com/account](https://developer.apple.com/account).

3. **Watcher email** — Replace `security@yourcompany.com` with your real email for Talsec security reports.

> In debug mode, a log box is printed at startup reminding developers about these items.

### Template Keystore (Development Only)

A debug keystore is included for development convenience:

| File | Location |
|------|----------|
| Keystore | `android/app/template-keystore.jks` |
| Key properties | `android/key.properties` |
| Alias | `template-key` |
| Store/Key password | `template123` |

Both files are in `.gitignore`. For a real project, generate your own keystore and update `key.properties`.

### Android Requirements

- `minSdk` set to 23 in `android/app/build.gradle.kts` (required by freeRASP).
- Gradle wrapper updated to 8.12.1.
- Signing config loads from `android/key.properties`.

---

## Screen Capture Protection

Route-based screen capture blocking using freeRASP's `blockScreenCapture`. Automatically prevents screenshots and screen recording on sensitive pages.

### How It Works

1. `ScreenProtectionObserver` listens to GoRouter's `routerDelegate` for route changes.
2. On each navigation event, it reads the current location from `routeInformationProvider` (deferred to the next frame to ensure GoRouter's state is settled).
3. `ScreenProtectionService` checks the path against two sets:
   - **`_protectedRoutes`** — exact match only (e.g., `/profile` blocks `/profile` but NOT `/profile/edit`).
   - **`_protectedRoutePrefixes`** — prefix match (e.g., `/payment` also blocks `/payment/confirm`).
4. If matched, screen capture is blocked via `Talsec.instance.blockScreenCapture(enabled: true)`.
5. When navigating away from a protected route, capture is unblocked automatically.

### Adding Protected Routes

Edit `_protectedRoutes` and/or `_protectedRoutePrefixes` in `lib/core/services/security/screen_protection_service.dart`.

> **Important:** Always use **full paths** as shown in GoRouter's "Full paths for routes" debug log.
> Relative route names like `registration` won't match — use `'${Routes.login}/${Routes.registration}'` instead.

```dart
/// Exact match only — child routes are NOT affected.
static final Set<String> _protectedRoutes = {
  Routes.profile,           // blocks /profile only
  // '/otp-verification',
};

/// Prefix match — the route AND all its children are blocked.
static final Set<String> _protectedRoutePrefixes = {
  '${Routes.login}/${Routes.registration}',  // blocks /login/registration
  // '/payment',                              // would block /payment/**
};
```

### Manual Control

For scenarios outside of routing (e.g., showing a sensitive dialog):

```dart
// Block
await ScreenProtectionService.instance.block();

// Unblock
await ScreenProtectionService.instance.unblock();

// Check status
final isBlocked = ScreenProtectionService.instance.isBlocked;
```

### Testing Screenshot Protection

Use `adb` to verify that screen capture is blocked on protected routes:

```bash
adb shell screencap -p /sdcard/test.png && adb pull /sdcard/test.png
```

- On **protected routes**: the pulled image will be a black screen.  
- On **unprotected routes**: the pulled image will show the actual screen content.

### Architecture

```
lib/core/services/security/
├── screen_protection_service.dart   # Singleton — manages block/unblock + protected routes
└── screen_protection_observer.dart  # Listens to GoRouter delegate changes
```

The observer is created and attached in `router.dart`:
```dart
final screenProtectionObserver = ScreenProtectionObserver();
final router = GoRouter(...);
screenProtectionObserver.attachRouter(router);
return router;
```

---

## Creating a New Feature

### Step 1: Create the Folder Structure

```
lib/features/your_feature/
├── data/
│   ├── models/
│   │   └── your_model.dart
│   ├── repositories/
│   │   └── your_repository_impl.dart
│   └── services/
│       └── network/
│           ├── your_api.dart
│           └── your_endpoints.dart
├── domain/
│   ├── entities/
│   │   └── your_entity.dart
│   ├── repositories/
│   │   └── your_repository.dart
│   └── use_cases/
│       └── get_your_data_usecase.dart
└── presentation/
    ├── cubit/  (or bloc/)
    │   ├── your_cubit.dart
    │   └── your_state.dart
    ├── pages/
    │   └── your_page.dart
    └── widgets/
        ├── your_widget_a.dart
        └── your_widget_b.dart
```

### Step 2: Entity (Domain Layer)

```dart
// lib/features/your_feature/domain/entities/your_entity.dart
class YourEntity {
  final String id;
  final String name;
  const YourEntity({required this.id, required this.name});
}
```

### Step 3: Model (Data Layer)

```dart
// lib/features/your_feature/data/models/your_model.dart
import '../../domain/entities/your_entity.dart';

class YourModel extends YourEntity {
  const YourModel({required super.id, required super.name});

  factory YourModel.fromJson(Map<String, dynamic> json) {
    return YourModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
```

### Step 4: API Client (Data Layer)

```dart
// lib/features/your_feature/data/services/network/your_endpoints.dart
class YourEndpoints {
  static const String items = '/your-feature/items';
}

// lib/features/your_feature/data/services/network/your_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'your_endpoints.dart';

part 'your_api.g.dart';

@RestApi()
abstract class YourApi {
  factory YourApi(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) = _YourApi;

  @GET(YourEndpoints.items)
  Future<HttpResponse> getItems();
}
```

Register in `register_modules.dart`:
```dart
@lazySingleton
YourApi yourApi(Dio dio) => YourApi(dio);
```

### Step 5: Repository

```dart
// lib/features/your_feature/domain/repositories/your_repository.dart
import '../../../../core/base/models/failure.dart';
import '../../../../core/base/repository.dart';
import '../entities/your_entity.dart';

abstract base class YourRepository extends Repository {
  Future<(List<YourEntity>?, Failure?)> getItems();
}

// lib/features/your_feature/data/repositories/your_repository_impl.dart
import 'package:injectable/injectable.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/repositories/your_repository.dart';
import '../models/your_model.dart';
import '../services/network/your_api.dart';

@LazySingleton(as: YourRepository)
final class YourRepositoryImpl extends YourRepository {
  final YourApi api;
  YourRepositoryImpl(this.api);

  @override
  Future<(List<YourEntity>?, Failure?)> getItems() {
    return asyncGuard(() async {
      final response = await api.getItems();
      final List data = response.data as List;
      return data.map((e) => YourModel.fromJson(e as Map<String, dynamic>)).toList();
    });
  }
}
```

### Step 6: Use Case

```dart
// lib/features/your_feature/domain/use_cases/get_your_data_usecase.dart
import 'package:injectable/injectable.dart';
import '../../../../core/base/models/failure.dart';
import '../entities/your_entity.dart';
import '../repositories/your_repository.dart';

@injectable
class GetYourDataUseCase {
  final YourRepository repository;
  GetYourDataUseCase(this.repository);

  Future<(List<YourEntity>?, Failure?)> call() => repository.getItems();
}
```

### Step 7a: Cubit + State (simple feature)

```dart
// lib/features/your_feature/presentation/cubit/your_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/use_cases/get_your_data_usecase.dart';

part 'your_state.dart';
part 'your_cubit.freezed.dart';

@injectable
class YourCubit extends Cubit<YourState> {
  final GetYourDataUseCase getDataUseCase;
  YourCubit(this.getDataUseCase) : super(const YourState());

  Future<void> loadData() async {
    emit(state.copyWith(status: YourStatus.loading, error: null));
    final (items, failure) = await getDataUseCase();
    if (failure != null) {
      emit(state.copyWith(status: YourStatus.error, error: failure.message));
      return;
    }
    emit(state.copyWith(status: YourStatus.success, items: items ?? []));
  }
}

// lib/features/your_feature/presentation/cubit/your_state.dart
part of 'your_cubit.dart';

enum YourStatus { initial, loading, success, error }

@freezed
abstract class YourState with _$YourState {
  const factory YourState({
    @Default(YourStatus.initial) YourStatus status,
    @Default(<YourEntity>[]) List<YourEntity> items,
    @Default(null) String? error,
  }) = _YourState;
}
```

### Step 7b: Bloc + Event + State (complex feature)

```dart
// lib/features/your_feature/presentation/bloc/your_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/use_cases/get_your_data_usecase.dart';

part 'your_event.dart';
part 'your_state.dart';
part 'your_bloc.freezed.dart';

@injectable
class YourBloc extends Bloc<YourEvent, YourState> {
  final GetYourDataUseCase getDataUseCase;

  YourBloc(this.getDataUseCase) : super(const YourState()) {
    on<_LoadYour>(_onLoad);
    on<_RefreshYour>(_onRefresh);
  }

  Future<void> _onLoad(_LoadYour event, Emitter<YourState> emit) async {
    emit(state.copyWith(status: YourStatus.loading));
    final (items, failure) = await getDataUseCase();
    if (failure != null) {
      emit(state.copyWith(status: YourStatus.error, error: failure.message));
      return;
    }
    emit(state.copyWith(status: YourStatus.success, items: items ?? []));
  }

  Future<void> _onRefresh(_RefreshYour event, Emitter<YourState> emit) async {
    // Refresh without showing loading
    final (items, failure) = await getDataUseCase();
    if (failure != null) return;
    emit(state.copyWith(items: items ?? []));
  }
}

// lib/features/your_feature/presentation/bloc/your_event.dart
part of 'your_bloc.dart';

@freezed
class YourEvent with _$YourEvent {
  const factory YourEvent.load() = _LoadYour;
  const factory YourEvent.refresh() = _RefreshYour;
}

// lib/features/your_feature/presentation/bloc/your_state.dart
part of 'your_bloc.dart';

enum YourStatus { initial, loading, success, error }

@freezed
abstract class YourState with _$YourState {
  const factory YourState({
    @Default(YourStatus.initial) YourStatus status,
    @Default(<YourEntity>[]) List<YourEntity> items,
    @Default(null) String? error,
  }) = _YourState;
}
```

### Step 8: Page & Widgets

```dart
// lib/features/your_feature/presentation/pages/your_page.dart
import 'package:flutter_template_2025/core/base/export.dart';
import '../cubit/your_cubit.dart';
import '../widgets/your_list_item.dart';

class YourPage extends StatelessWidget {
  const YourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<YourCubit>()..loadData(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.locale.yourFeatureTitle)),
        body: BlocBuilder<YourCubit, YourState>(
          builder: (context, state) {
            return switch (state.status) {
              YourStatus.initial => const SizedBox.shrink(),
              YourStatus.loading => const Center(child: LoadingIndicator()),
              YourStatus.error => Center(child: Text(state.error ?? '')),
              YourStatus.success => ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) => YourListItem(item: state.items[index]),
              ),
            };
          },
        ),
      ),
    );
  }
}

// lib/features/your_feature/presentation/widgets/your_list_item.dart
import 'package:flutter_template_2025/core/base/export.dart';
import '../../domain/entities/your_entity.dart';

class YourListItem extends StatelessWidget {
  const YourListItem({super.key, required this.item});
  final YourEntity item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name, style: context.textStyle.bodyLarge),
    );
  }
}
```

### Step 9: Generate & Run

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Code Generation

| Command | What It Generates |
|---------|-------------------|
| `dart run build_runner build --delete-conflicting-outputs` | All generated code (injectable, freezed, retrofit, dart_mappable) |
| `dart run build_runner watch --delete-conflicting-outputs` | Same, but watches for changes |
| `flutter gen-l10n` | Localization files from `.arb` files |
| `flutter pub run flutter_flavorizr` | Flavor-specific configs (icons, bundle IDs) |

**When to run build_runner:**
- After adding/changing `@injectable`, `@lazySingleton`, `@module` annotations
- After adding/changing `@freezed` state/event classes
- After adding/changing `@RestApi()` Retrofit API clients
- After adding/changing `@MappableClass()` models

---

## Flavors

| Flavor | App Name | Base URL | Timeouts | Analytics |
|--------|----------|----------|----------|-----------|
| `dev` | Flutter Template Dev | `https://dummyjson.com` | 60s | Off |
| `qa` | Flutter Template QA | QA server | 60s | On |
| `uat` | Flutter Template UAT | UAT server | 30s | On |
| `prod` | Flutter Template | Prod server | 30s | On |

### Run Commands

```bash
# Development
flutter run --flavor dev --dart-define=flavor=dev

# QA
flutter run --flavor qa --dart-define=flavor=qa

# UAT
flutter run --flavor uat --dart-define=flavor=uat

# Production
flutter run --flavor prod --dart-define=flavor=prod

# Build APK
flutter build apk --flavor prod --dart-define=flavor=prod

# Build iOS
flutter build ios --flavor prod --dart-define=flavor=prod
```

---

## Key Conventions

### DO

- **Import `core/base/export.dart`** in all page/widget files — it re-exports Material, BLoC, GoRouter, ScreenUtil, Gap, FlutterAnimate, getIt, localization
- **Use `context.color.*`** for all colors — supports light/dark mode automatically
- **Use `context.textStyle.*`** for all text styles — never `TextStyle()` inline
- **Use `context.locale.*`** for all user-facing strings — never hardcode text
- **Use `Gap(16)`** instead of `SizedBox(height: 16)` for spacing
- **Use `.w`, `.h`, `.sp`, `.r`** from ScreenUtil for responsive sizing
- **Put each widget in its own file** — page-level widgets in `widgets/` folder
- **Use `part of`** for state/event files — they are `part of` their cubit/bloc
- **Use `@injectable` / `@lazySingleton`** for DI — never manually instantiate singletons
- **Run `build_runner`** after changing any annotated file
- **Use `asyncGuard`** in repositories for all API calls — never try/catch in use cases or cubits
- **Use `context.showError()`, `context.showSuccess()`** etc. for toast notifications — import `app_toast.dart`

### DON'T

- **Don't use static `Colors.*`** — use `context.color.*` instead
- **Don't use static `TextStyle(...)`** — use `context.textStyle.*` instead
- **Don't hardcode strings** — add to `.arb` files and use `context.locale.*`
- **Don't create DataSource classes** — repositories call services directly
- **Don't throw exceptions** from repositories — return `(T?, Failure?)` tuples
- **Don't use `setState`** for business logic — use Cubit/Bloc
- **Don't put business logic in widgets** — delegate to use cases
- **Don't import internal theme files directly** — access via `context.color` / `context.textStyle`
- **Don't use `Navigator.push`** — use GoRouter: `context.goNamed()`, `context.pushNamed()`
- **Don't create `index.dart` inside features** — only in `core/` subfolders
- **Don't use `ScaffoldMessenger.showSnackBar`** or raw `toastification.show()` — use `context.showSuccess()`, `context.showError()`, etc.
