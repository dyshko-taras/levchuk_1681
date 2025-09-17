# Privacy Plugin

A comprehensive Flutter plugin that handles app initialization, privacy policy management, and WebView functionality with immersive Android experience.

## Features

- **Complete App Initialization**: User ID generation, Google Ad ID retrieval
- **Privacy Policy Management**: Automatic privacy policy acceptance flow with connection retry loops
- **Advanced WebView**: Full-featured WebView with file uploads, popup windows, deeplinks, and pull-to-refresh
- **Display Mode Control**: Immersive and normal display modes for Android with seamless transitions
- **Orientation Management**: Automatic orientation unlocking for WebView with host app restoration
- **Back Button Handling**: Context-aware Android back button management with quit confirmation
- **Connectivity Checking**: Real internet connection verification with automatic retry dialogs
- **Multi-language Support**: Built-in localization for 11 languages with automatic device locale detection
- **Event-Driven Architecture**: Clean separation between plugin logic and host app UI

## Architecture

The plugin follows an event-driven architecture with direct navigation capabilities:
- **PrivacyPluginService** - Main singleton service handling initialization and state management
- **PrivacyNavigationController** - Direct navigation for WebView screens with proper display mode switching
- **LocalizationService** - Built-in multi-language support (11 languages)
- **Native Android Integration** - Google Ad ID and system UI management
- **Event-based Communication** - Plugin emits events, host app responds to state changes

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  privacy_plugin:
    git:
      url: https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
      ref: privacy_plugin
```

**Alternative installation methods:**

For a specific commit:
```yaml
dependencies:
  privacy_plugin:
    git:
      url: https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
      ref: commit_hash_here
```

For local development:
```yaml
dependencies:
  privacy_plugin:
    path: ../path/to/local/privacy_plugin
```

**Note:** Replace `YOUR_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.

## Setup

### 1. Android Configuration

The plugin automatically includes the following dependencies and permissions:

**Dependencies (automatically included):**
- `org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3`

**Permissions (automatically included):**
- `android.permission.INTERNET`
- `android.permission.ACCESS_NETWORK_STATE`
- `com.google.android.gms.permission.AD_ID`
- `android.permission.ACCESS_WIFI_STATE`

**Optional:** Configure your styles in `android/app/src/main/res/values/styles.xml` for optimal immersive mode support:

```xml
<style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
    <item name="android:windowBackground">@drawable/launch_background</item>
    <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
</style>

<style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
    <item name="android:windowBackground">?android:colorBackground</item>
    <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
</style>
```

**Your MainActivity.kt becomes minimal:**
```kotlin
package com.yourapp.package

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    // Privacy plugin handles all native functionality
}
```

### 2. Flutter Integration

#### Main App Setup

```dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_plugin/privacy_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PrivacyPluginInitState _currentState = PrivacyPluginInitState.idle;

  @override
  void initState() {
    super.initState();
    _initializePlugin();
  }

  Future<void> _initializePlugin() async {
    // Listen to events first (before calling init)
    PrivacyPluginService.instance.events.listen((event) {
      if (!mounted) return;

      switch (event.type) {
        case PrivacyPluginEventType.initializationStarted:
          setState(() => _currentState = PrivacyPluginInitState.loading);
          break;
        case PrivacyPluginEventType.privacyPolicyRequired:
          setState(() => _currentState = PrivacyPluginInitState.privacyRequired);
          break;
        case PrivacyPluginEventType.initializationCompleted:
          setState(() => _currentState = PrivacyPluginInitState.ready);
          break;
        case PrivacyPluginEventType.error:
          setState(() => _currentState = PrivacyPluginInitState.error);
          break;
      }
    });

    // Configure and initialize plugin (automatically starts initialization)
    final config = PrivacyPluginConfig(
      installerParam: 'INSTALLER_PARAM',
      userIdParam: 'USER_ID_PARAM',
      gaidParam: 'GAID_PARAM',
      supportLink: 'SUPPORT_LINK',
      privacyLink: 'PRIVACY_LINK',
      privacyCallback: 'PRIVACY_CALLBACK',
      privacyAcceptedParam: 'PRIVACY_ACCEPTED_PARAM',
      verboseWebViewLogging: kDebugMode,
    );

    await PrivacyPluginService.instance.init(config);
  }

  // Optional: Configure orientation management
  Future<void> _initializePluginWithOrientation() async {
    // Same event listening setup as above...

    // Configure plugin with host app orientation restrictions
    await PrivacyPluginService.instance.init(
      config,
      hostAppOrientations: [DeviceOrientation.portraitUp], // Optional: specify host app restrictions
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      home: _buildCurrentScreen(),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentState) {
      case PrivacyPluginInitState.loading:
      case PrivacyPluginInitState.privacyRequired:
        return const LoadingScreen();
      case PrivacyPluginInitState.ready:
        return const YourMainScreen();
      default:
        return const LoadingScreen();
    }
  }
}
```

#### Critical: Navigator Registration

**REQUIRED for WebView navigation to work:**

```dart
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String _loadingText = 'Loading...';

  @override
  void initState() {
    super.initState();
    _setupEventListening();

    // CRITICAL: Register Navigator with privacy plugin
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        PrivacyPluginService.instance.registerNavigator(Navigator.of(context));
      } catch (e) {
        if (kDebugMode) {
          print('Failed to register Navigator: $e');
        }
      }
    });
  }

  void _setupEventListening() {
    PrivacyPluginService.instance.events.listen((event) {
      if (!mounted) return;

      switch (event.type) {
        case PrivacyPluginEventType.initializationStarted:
          setState(() => _loadingText = 'Initializing...');
          break;
        case PrivacyPluginEventType.privacyPolicyRequired:
          setState(() => _loadingText = 'Loading privacy policy...');
          break;
        case PrivacyPluginEventType.connectionRequired:
          setState(() => _loadingText = 'Checking connection...');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(_loadingText),
          ],
        ),
      ),
    );
  }
}
```

## Usage

### Basic Operations

```dart
// Access plugin data
final userId = PrivacyPluginService.instance.userId;
final googleAdId = PrivacyPluginService.instance.googleAdId;
final analyticsParams = PrivacyPluginService.instance.analyticsParams;
final privacyAccepted = PrivacyPluginService.instance.privacyAccepted;

// Direct navigation actions (requires navigator registration)
await PrivacyPluginService.instance.openWebView('https://example.com');
await PrivacyPluginService.instance.openPrivacyPolicy();
await PrivacyPluginService.instance.openCustomerSupport();

// Utility functions
final hasConnection = await PrivacyPluginService.instance.hasConnection();
await PrivacyPluginService.instance.moveToBackground();

// Handle back button
await PrivacyPluginService.instance.handleBackButtonPress();

// Show built-in dialogs
await PrivacyPluginService.instance.showQuitConfirmationDialog();
```

### Privacy Policy Integration

Your privacy policy webpage should include this JavaScript code:

```javascript
// When user accepts privacy policy
if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
  window.flutter_inappwebview.callHandler('[PRIVACY_CALLBACK]');
}
```

## Advanced Usage

### Orientation Management

The plugin automatically manages device orientation for optimal WebView experience:

- **WebView screens**: Unlocks all orientations (portrait/landscape) for better user experience
- **Host app restoration**: Restores original orientation restrictions when WebView closes
- **Backward compatible**: Optional parameter maintains existing functionality

```dart
// Option 1: No orientation restrictions (default behavior)
await PrivacyPluginService.instance.init(config);

// Option 2: Specify host app orientation restrictions to restore after WebView
await PrivacyPluginService.instance.init(
  config,
  hostAppOrientations: [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ], // WebView allows all orientations, restores these when closed
);

// Option 3: Portrait-only host app
await PrivacyPluginService.instance.init(
  config,
  hostAppOrientations: [DeviceOrientation.portraitUp],
);
```

**Behavior:**
- When WebView opens → All orientations unlocked automatically
- When WebView closes → Host app orientations restored (if specified)
- No host orientations specified → No restoration (Flutter default behavior)

### Manual Initialization Control

By default, calling `init()` automatically starts the initialization process. For advanced use cases where you need to control the exact timing of initialization (e.g., waiting for user permissions), you can disable auto-start:

```dart
// Configure plugin without starting initialization
await PrivacyPluginService.instance.init(config, autoStart: false);

// Later, when you're ready to start initialization
await PrivacyPluginService.instance.startInitialization();
```

## Configuration

### Required Parameters

```dart
PrivacyPluginConfig(
  supportLink: 'SUPPORT_LINK',      // Support page URL
  privacyLink: 'PRIVACY_LINK',      // Privacy policy URL
  privacyCallback: 'PRIVACY_CALLBACK',             // JS callback name
  privacyAcceptedParam: 'PRIVACY_ACCEPTED_PARAM',                 // URL parameter name
)
```

### URL Parameters

These parameters are automatically added to WebView URLs:

```dart
PrivacyPluginConfig(
  installerParam: 'INSTALLER_PARAM',        // Installer package parameter
  userIdParam: 'USER_ID_PARAM',          // User ID parameter
  gaidParam: 'GAID_PARAM',               // Google Ad ID parameter
)
```

### Built-in WebView Features

The plugin includes a complete WebView implementation with:

- **Automatic URL parameter injection**: All analytics parameters are automatically added to WebView URLs
- **File upload support**: Gallery, documents, multiple selection
- **Popup window handling**: OAuth, Google Pay, payment gateways with dynamic titles
- **Deeplink support**: All custom URL schemes automatically handled via url_launcher
- **Pull-to-refresh**: Native gesture implementation
- **Display mode management**: Automatic switching between immersive and normal modes
- **Orientation management**: Automatic unlocking for WebView, restoration for host app
- **Back button handling**: Context-aware navigation with WebView history support
- **Connection checking**: Automatic retry dialogs for network issues
- **Multi-language dialogs**: Built-in localized "App Not Installed" dialogs

### Custom WebView Usage

If you need to create custom WebView screens, use the plugin's helper methods:

```dart
// Build URL with analytics parameters
final finalUrl = PrivacyPluginService.instance.buildWebViewUrl('https://example.com');

// Get proper headers (User-Agent, Accept-Language)
final headers = PrivacyPluginService.instance.getWebViewHeaders();

// Use in your custom WebView
InAppWebView(
  initialUrlRequest: URLRequest(
    url: WebUri(finalUrl),
    headers: headers,
  ),
  initialSettings: InAppWebViewSettings(
    javaScriptEnabled: true,
    supportMultipleWindows: true,
    javaScriptCanOpenWindowsAutomatically: true,
    allowFileAccess: true,
    useShouldOverrideUrlLoading: true,
    transparentBackground: true,
    useHybridComposition: false,
  ),
)
```

## Plugin Events

The plugin emits the following events:

- `initializationStarted` - Plugin started initialization process
- `privacyPolicyRequired` - Privacy policy needs to be accepted (automatically opens WebView)
- `privacyPolicyAccepted` - Privacy policy was accepted by user
- `initializationCompleted` - Initialization finished successfully, app is ready
- `backButtonPressed` - Android back button was pressed
- `connectionRequired` - Network connection is required (fallback event if no navigator)
- `webViewClosed` - WebView screen was closed
- `error` - An error occurred during initialization

### Event Data Structure

```dart
class PrivacyPluginEvent {
  final PrivacyPluginEventType type;
  final Map<String, dynamic>? data;
  final String? error;
  final DateTime timestamp;
}
```

## Available Data

Access plugin state through `PrivacyPluginService.instance`:

- `userId` - Generated UUID for the user (persisted in SharedPreferences)
- `installerPackage` - App installer package name (or "debug" in debug mode)
- `googleAdId` - Google Advertising ID
- `privacyAccepted` - Privacy policy acceptance status
- `analyticsParams` - Map of all analytics parameters
- `config` - Current plugin configuration
- `state` - Current initialization state (idle, loading, privacyRequired, ready, error)
- `userAgent` - Dynamic user agent string based on device info (auto-generated using device_info_plus)

## Supported Languages

The plugin includes built-in localization for the following languages:

- **English** (en) - Default fallback
- **German** (de) - Deutsch
- **Spanish** (es) - Español
- **French** (fr) - Français
- **Italian** (it) - Italiano
- **Polish** (pl) - Polski
- **Portuguese** (pt) - Português
- **Russian** (ru) - Русский
- **Slovak** (sk) - Slovenčina
- **Turkish** (tr) - Türkçe
- **Ukrainian** (uk) - Українська

The plugin automatically detects the device locale and uses the appropriate language for dialogs and messages.

## Key Features


### Display Mode Management
- **Immersive mode**: Complete fullscreen for non-WebView screens
- **Normal mode**: Standard system bars for WebView screens
- **Automatic switching**: Seamless transitions between modes
- **Android 15 compatible**: Proper edge-to-edge support

### Orientation Management
- **WebView orientation unlock**: All orientations enabled for optimal user experience
- **Host app restoration**: Original orientation restrictions restored after WebView closes
- **Configuration options**: Optional `hostAppOrientations` parameter in `init()` method
- **Backward compatible**: Existing apps continue working without changes

### WebView Features
- **flutter_inappwebview**: Version 6.1.5
- **Dynamic user agent**: Automatically generated based on device info
- **File uploads**: Full support for gallery and document selection
- **Popup windows**: OAuth, payments, with dynamic titles
- **Deeplinks**: Universal custom URL scheme handling
- **Pull-to-refresh**: Native gesture support
- **Error handling**: Silent recovery, no user-facing errors

## Known Issues

### 1. App Stuck on Loading Screen ✅ FIXED
- **Problem**: Privacy plugin's init() method only configures the plugin but doesn't start the actual initialization process
- **Solution**: The plugin now automatically starts initialization when `init()` is called. No additional steps required.
- **For advanced users**: Use `init(config, autoStart: false)` if you need manual control over initialization timing

## License

This plugin is proprietary software.