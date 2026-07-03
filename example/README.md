# Flutter Components Plus Example

A comprehensive example application showcasing the Flutter Components Plus library with GetX architecture and responsive design.

## Features

- **GetX Architecture**: Clean separation of concerns with controllers, bindings, and views
- **Responsive Design**: Adapts to different screen sizes (mobile, tablet, desktop)
- **Theme Support**: Light and dark theme with dynamic switching
- **Component Showcase**: Interactive examples of all available components
- **Modern UI**: Material Design 3 with custom theming

## Project Structure

```
lib/
├── app/
│   ├── bindings/           # Dependency injection bindings
│   ├── controllers/        # Business logic controllers
│   ├── data/              # Data layer (models, providers, repositories)
│   ├── modules/           # Feature modules
│   │   ├── home/          # Home module with landing page
│   │   ├── components/    # Components showcase module
│   │   └── theme/         # Theme management
│   ├── routes/            # Route definitions
│   └── utils/             # Utility functions
└── main.dart              # App entry point
```

## Architecture

### GetX Pattern
- **Controllers**: Manage state and business logic
- **Bindings**: Handle dependency injection
- **Views**: UI components
- **Routes**: Navigation management

### Responsive Design
- **Mobile**: Bottom tab navigation
- **Desktop**: Sidebar navigation
- **Adaptive**: Automatic layout switching based on screen width

## Components Showcase

The app includes comprehensive examples of:

### Buttons
- **Variants**: Primary, Secondary, Outline, Ghost, Danger
- **Sizes**: Small, Medium, Large, Extra Large
- **States**: Normal, Loading, Disabled
- **Icons**: Start, End, Icon-only

### Navigation
- **Sidebar**: Desktop navigation with active states
- **Tab Bar**: Mobile navigation with icons
- **Responsive**: Automatic layout switching

### Theme
- **Light Theme**: Clean, modern light appearance
- **Dark Theme**: Comfortable dark mode
- **Dynamic Switching**: Toggle between themes
- **Custom Colors**: Using Flutter Components Plus color scheme

## Getting Started

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run
   ```

3. **Development**
   ```bash
   flutter analyze
   flutter test
   ```

## Dependencies

- **GetX**: State management and routing
- **Flutter Components Plus**: Custom component library
- **Flutter**: UI framework

## Key Features

### Landing Page
- Overview with statistics
- Quick action buttons
- Responsive grid layout
- Theme toggle

### Component Tabs
- **Overview**: App introduction and stats
- **Buttons**: All button variants and states
- **Cards**: Card component examples (coming soon)
- **Inputs**: Input field examples (coming soon)
- **Navigation**: Navigation component examples (coming soon)
- **Feedback**: Feedback component examples (coming soon)
- **Layout**: Layout component examples (coming soon)

### Responsive Behavior
- **Mobile (< 600px)**: Bottom tab navigation
- **Desktop (> 600px)**: Sidebar navigation
- **Adaptive Grid**: Responsive grid layouts
- **Touch Friendly**: Optimized for touch and mouse

## Customization

### Adding New Components
1. Create a new tab in `HomeView`
2. Add the component examples
3. Update the navigation

### Theme Customization
1. Modify `AppTheme` in `theme_config.dart`
2. Update color schemes in `FCPColorScheme`
3. Add new theme variants

### Routing
1. Add new routes in `app_routes.dart`
2. Create corresponding views and bindings
3. Update `app_pages.dart`

## Contributing

1. Follow the GetX architecture pattern
2. Use responsive design principles
3. Maintain consistent theming
4. Add comprehensive examples for new components

## License

This project is part of the Flutter Components Plus library.
