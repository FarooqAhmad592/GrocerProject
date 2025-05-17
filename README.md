# elgrocer


Login Credentials

Email: test@example.com
Password: 12345678

This project demonstrates a modern iOS architecture with a focus on:

- MVVM architecture
- Async/await
- UICollectionView with Compositional Layout
- Persistent login with secure state handling
- Auto-sliding banners
- Category-based product filtering

Login Flow

- Fields for “email” and “password”
- Basic validations:
  - Valid email format (Regex-based)
  - Minimum password length (e.g., 8+)
- Displays validation errors dynamically
- Shows a “loading spinner” during login
- Uses “Keychain” to persist login state
- Navigates to “Home screen” on success
- Auto-login on next app launch if already logged in

Technologies:
- UIViewController
- MVVM: LoginViewModel handles all logic
- async/await for async login simulation
- Programmatic UI using UIKit

Home Screen

Sections
1. Banner Section (Auto Sliding)
2. Categories Section
   - 4 items per row × 2 rows
   - Horizontally scrollable
   - Tapping a category filters the products
3. Products Section
   - Grid of 2 items per row
   - Shows product name & image
   - Vertical scrolling

Architecture:
- MVVM using HomeViewModel and HomeViewController
- Dependency injection for injecting the ViewModel
- Auto-sliding banners using Timer

UICollectionView Layout:
- Built with UICollectionViewCompositionalLayout
- Each section uses its own custom layout logic
    
