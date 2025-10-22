# FCPNavigation Component

A customizable navigation component with bottom navigation bar support and various navigation patterns.

## Features

- **Bottom Navigation**: Modern bottom navigation bar with customizable styling
- **Multiple Variants**: Different navigation bar styles and configurations
- **Custom Icons**: Support for custom icons and badges
- **Animations**: Smooth transitions and animations
- **Accessibility**: Proper touch targets and screen reader support
- **Responsive**: Automatic sizing and responsive design

## Basic Usage

### Simple Bottom Navigation
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.person,
      label: 'Profile',
    ),
  ],
)
```

### Bottom Navigation with Badges
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.notifications,
      label: 'Notifications',
      badge: '3',
      badgeColor: Colors.red,
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.shopping_cart,
      label: 'Cart',
      badge: '5',
      badgeColor: Colors.orange,
    ),
  ],
)
```

### Bottom Navigation with Custom Styling
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
      activeIcon: Icons.home_filled,
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.favorite_border,
      label: 'Favorites',
      activeIcon: Icons.favorite,
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      activeIcon: Icons.settings,
    ),
  ],
  backgroundColor: Colors.blue[50],
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  type: FCPBottomNavigationBarType.fixed,
  elevation: 8,
)
```

## Advanced Usage

### Bottom Navigation with Custom Colors
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
      activeColor: Colors.green,
      inactiveColor: Colors.grey,
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.person,
      label: 'Profile',
      activeColor: Colors.purple,
      inactiveColor: Colors.grey,
    ),
  ],
  backgroundColor: Colors.white,
  elevation: 12,
  shadowColor: Colors.black.withOpacity(0.1),
)
```

### Bottom Navigation with Custom Badges
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.notifications,
      label: 'Notifications',
      badge: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          '3',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.shopping_cart,
      label: 'Cart',
      badge: CircleAvatar(
        radius: 8,
        backgroundColor: Colors.orange,
        child: Text(
          '5',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
)
```

### Bottom Navigation with Custom Animation
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.person,
      label: 'Profile',
    ),
  ],
  animationDuration: Duration(milliseconds: 300),
  animationCurve: Curves.easeInOut,
  showLabels: true,
  labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
)
```

### Bottom Navigation with Custom Shape
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    FCPBottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
    ),
    FCPBottomNavigationBarItem(
      icon: Icons.person,
      label: 'Profile',
    ),
  ],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  backgroundColor: Colors.white,
  elevation: 8,
)
```

## Navigation Types

### Fixed Navigation
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: items,
  type: FCPBottomNavigationBarType.fixed,
)
```

### Shifting Navigation
```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: items,
  type: FCPBottomNavigationBarType.shifting,
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class NavigationExample extends StatefulWidget {
  @override
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int _currentIndex = 0;
  int _notificationCount = 3;
  int _cartCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: FCPBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          FCPBottomNavigationBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          FCPBottomNavigationBarItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Search',
            activeColor: Colors.green,
            inactiveColor: Colors.grey,
          ),
          FCPBottomNavigationBarItem(
            icon: Icons.notifications_outlined,
            activeIcon: Icons.notifications,
            label: 'Notifications',
            badge: _notificationCount > 0 ? '$_notificationCount' : null,
            badgeColor: Colors.red,
            activeColor: Colors.orange,
            inactiveColor: Colors.grey,
          ),
          FCPBottomNavigationBarItem(
            icon: Icons.shopping_cart_outlined,
            activeIcon: Icons.shopping_cart,
            label: 'Cart',
            badge: _cartCount > 0 ? '$_cartCount' : null,
            badgeColor: Colors.purple,
            activeColor: Colors.purple,
            inactiveColor: Colors.grey,
          ),
          FCPBottomNavigationBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            activeColor: Colors.teal,
            inactiveColor: Colors.grey,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
        type: FCPBottomNavigationBarType.fixed,
        showLabels: true,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildSearchPage();
      case 2:
        return _buildNotificationsPage();
      case 3:
        return _buildCartPage();
      case 4:
        return _buildProfilePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text('Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Welcome to the home page'),
        ],
      ),
    );
  }

  Widget _buildSearchPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text('Search Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Search for content'),
        ],
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text('Notifications', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('You have $_notificationCount notifications'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() => _notificationCount = 0);
            },
            child: Text('Clear Notifications'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 64, color: Colors.purple),
          SizedBox(height: 16),
          Text('Shopping Cart', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('You have $_cartCount items in your cart'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() => _cartCount = 0);
            },
            child: Text('Clear Cart'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.teal),
          SizedBox(height: 16),
          Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Manage your profile'),
        ],
      ),
    );
  }
}
```

## API Reference

### FCPBottomNavigationBar Properties

| Property | Type | Description |
|----------|--------|-------------|
| `currentIndex` | `int` | Currently selected index |
| `onTap` | `Function(int)?` | Tap callback |
| `items` | `List<FCPBottomNavigationBarItem>` | Navigation items |
| `type` | `FCPBottomNavigationBarType?` | Navigation type |
| `backgroundColor` | `Color?` | Background color |
| `elevation` | `double?` | Elevation |
| `shadowColor` | `Color?` | Shadow color |
| `selectedItemColor` | `Color?` | Selected item color |
| `unselectedItemColor` | `Color?` | Unselected item color |
| `showLabels` | `bool?` | Show labels |
| `labelStyle` | `TextStyle?` | Label text style |
| `animationDuration` | `Duration?` | Animation duration |
| `animationCurve` | `Curve?` | Animation curve |
| `shape` | `ShapeBorder?` | Custom shape |

### FCPBottomNavigationBarItem Properties

| Property | Type | Description |
|----------|--------|-------------|
| `icon` | `IconData` | Icon |
| `activeIcon` | `IconData?` | Active icon |
| `label` | `String?` | Label text |
| `badge` | `Widget?` | Badge widget |
| `badgeColor` | `Color?` | Badge color |
| `activeColor` | `Color?` | Active color |
| `inactiveColor` | `Color?` | Inactive color |

### FCPBottomNavigationBarType

| Type | Description |
|------|-------------|
| `fixed` | Fixed navigation bar |
| `shifting` | Shifting navigation bar |

## Best Practices

1. **Consistent Icons**: Use consistent icon styles throughout your app
2. **Clear Labels**: Use descriptive labels for navigation items
3. **Badge Usage**: Use badges sparingly and only for important notifications
4. **Color Scheme**: Use colors that match your app's theme
5. **Touch Targets**: Ensure proper touch targets for navigation items
6. **Accessibility**: Provide proper labels and descriptions
7. **Performance**: Avoid excessive animations and complex badges

## Accessibility

- All navigation items support proper touch targets
- Screen reader support for navigation labels
- High contrast mode support
- Keyboard navigation support
- Proper semantic structure for assistive technologies
