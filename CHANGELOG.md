## 1.2.0

### Added
* **FCPPdfDownloadService**: Download PDFs to public Downloads (Android MediaStore) or app storage, with storage permission handling
* **PDF viewer download UI**: Optional download button, filename override, and success/error callbacks on `FCPPdfViewer`

### Changed
* **Flutter & dependencies**: Updated Flutter SDK constraints and package versions for latest Flutter support (including `fl_chart` 1.2.0, `syncfusion_flutter_*` 33.2.15, `permission_handler` 12.x, and related migrations)
* **Example app**: Added example app demonstrating package usage
* **PDF network loading**: Loads PDFs via `http` + `SfPdfViewer.memory` with header validation for reliable release builds
* **Logging**: Runtime `print` calls replaced with `FCPLoggingService` (`dart:developer` `log()`)
* **CLI**: Removed BLE component and `ble_permissions` commands; simplified permission manager
* **Example app layout**: Edge-to-edge mode with system navigation bar insets so UI sits above Android nav buttons

### Removed
* **BLE support**: `FcpBleService`, `flutter_blue_plus`, `location`, BLE examples, and Bluetooth/location permissions from the example app

### Fixed
* **PDF viewer release builds**: `INTERNET` permission in main Android manifest; ProGuard rules for `media_store_plus` / Gson on Android release
* **PDF download permissions**: MediaStore on Android 10+, clear user messages for denied storage access
* **Charts**: `tooltipBorderRadius` migration for `fl_chart` 1.2.0
* **Dropdown**: Removed unused `_searchQuery` field

## 1.1.0

### Added
* **FCPQuadrantChart**: Configurable 2x2 quadrant chart with threshold-based positioning
* **CLI Component Support**: Added `fcp add component quadrant_chart` and `fcp remove component quadrant_chart`
* **Documentation**: Added README and CLI README usage docs for `quadrant_chart`

## 1.0.0

### Added
* **FCPButton**: Fluent API button component with multiple variants, sizes, and states
* **FCPCard**: Unified card component with flat, shaded, gradient, info, and action variants
* **FCPDropdownBottomSheet**: Professional dropdown with search functionality and custom styling
* **FCPPdfViewer**: Comprehensive PDF viewer with zoom, navigation, and search features
* **FCPChart**: Interactive charts (Area, Bar, Line, Histogram) with fluent API
* **FCPLiveGraph**: Real-time live data visualization with smooth animations
* **FCPSwitch**: Customizable toggle switches with single/multi-select and toggle variants
* **FCPBottomNavigationBar**: Modern bottom navigation with asset-based icons
* **FCPDataTable**: Advanced data tables with sorting, filtering, and pagination
* **FCPInputField**: Customizable input fields with validation and styling
* **FCPMultiSelectDropdown**: Multi-selection dropdown with search and custom styling

### Design System
* **Themes**: Complete light and dark theme support
* **Color Schemes**: Comprehensive color palette with semantic colors
* **Text Styles**: Typography system with predefined text styles
* **Spacing & Layout**: Consistent spacing and layout constants

### Utility Extensions
* **Widget Extensions**: `.padAll()`, `.center()`, `.shadow()`, etc.
* **String Extensions**: `.capitalize`, `.isEmail`, `.truncate()`, etc.
* **Date Extensions**: `.isToday`, `.relativeTime`, `.addDays()`, etc.

### Services
* **HTTP Service**: Complete HTTP client with interceptors and error handling
* **Storage Service**: Local storage management with JSON support
* **Logging Service**: Comprehensive logging with multiple output options

### CLI Tools
* **Component Manager**: Add/remove components and dependencies
* **Permission Manager**: Manage platform permissions automatically
* **File Utils**: Project file management utilities
