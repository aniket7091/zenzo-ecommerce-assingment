# 🛍️ Zenzo - Mini E-Commerce Mobile App

A clean, responsive, and feature-rich mini e-commerce mobile application built with **Flutter**, **Dart**, and **GetX** state management, integrated with the [FakeStore API](https://fakestoreapi.com/).

Developed as part of the **Flutter Developer Intern Technical Assignment**.

---

## 📱 Features

### 1. 🏠 Product Listing Screen
- **API Integration**: Fetches real-time products from `https://fakestoreapi.com/products` using **Dio**.
- **Display Details**: Shows product image, title, category, price, and customer ratings (`rate` and `count`).
- **Loading & Error Handling**: Displays a loading indicator during fetch and clear error messages when API requests fail.
- **Preview & "View All"**: Shows 4 featured products on the home screen with a **"View All"** action to browse the full catalog on a dedicated page (`AllProductsScreen`).

### 2. 🔍 Dedicated Search Screen (Amazon / Flipkart Style)
- Tapping the search bar on the home screen smoothly redirects to a specialized **Search Screen**.
- **Auto-Focused Search Input**: Quick and seamless typing experience.
- **Real-Time Filtering**: Instant search results by title as the user types.
- **Recent Searches**: Tracks and displays recent search queries with one-tap search and clear history options.
- **Popular Categories**: Quick-filter chips for instant category browsing.
- **Empty State**: Clear visual prompt when no products match the query.

### 3. 🎛️ Product Filtering & Sorting
- Accessible directly via the filter button right next to the search bar.
- **Category Filter**: Filter by `electronics`, `jewelery`, `men's clothing`, `women's clothing`, or view `All`.
- **Sorting Options**:
  - Price: Low to High
  - Price: High to Low
  - Rating: High to Low
  - Default
- **Price Range Slider**: Filter products by minimum and maximum budget (₹0 – ₹1000).
- **Reset & Apply**: Instantly clear or apply multi-criteria filters reactively.

### 4. 📄 Product Details Screen
- Shows high-resolution product image, title, category, dynamic price, full description, and rating.
- **Interactive Quantity Selector**: Increase or decrease quantity before adding to cart.
- **Add to Cart**: Adds the selected item and quantity directly into the shared cart state with feedback notifications.

### 5. 🛒 Shopping Cart (Local / In-Memory State)
- **Reactive Cart Management**: Add, update quantities, or remove items in real time.
- **Dynamic Price Calculations**: Automatically updates subtotal, discounts/shipping, and grand total.
- **Empty Cart State**: Thoughtfully designed empty-state graphic with a **"Continue Shopping"** action that redirects back to the Home screen.
- **Clear Cart Option**: Modal dialog confirmation to remove all items.

### 6. 🧭 Navigation & UI Design
- Modern floating pill-style bottom navigation bar.
- Consistent earthy brown color palette (`AppColors`).
- Reusable UI widgets across all screens (`ProductCard`, `ProductGrid`, `EmptyCart`, `HomeHeader`, etc.).

---

## 🏗️ Architecture & Project Structure

The project follows a clean, modular **Controller-Service-Model-View (MVVM-style)** pattern for clear separation of concerns:

```
lib/
├── controllers/          # Business logic & GetX state controllers
│   ├── CartController.dart       # Cart state, item quantities & price calculation
│   ├── FilterController.dart     # Category, price range, and sorting logic
│   └── SearchController.dart     # Search query, recent history & filtered results
├── core/                 # App constants and styling
│   ├── constants/
│   │   └── AppColor.dart         # Color palette definitions
│   └── theme/
│       └── theme.dart            # Global typography & theme setup
├── models/               # Data models
│   └── product_model.dart        # Product & Rating models with JSON serialization
├── screens/              # App screens / views
│   ├── AllProductsScreen.dart    # Full product catalog with filters
│   ├── CartScreen.dart           # Shopping cart view with summary
│   ├── HomeScreen.dart           # Home page with search, featured items & banners
│   ├── SearchScreen.dart         # Amazon-style search screen with recents & chips
│   └── product_details.dart      # Product details and quantity selection
├── services/             # Network and API data-handling logic
│   ├── CartService.dart
│   └── product_service.dart      # Dio HTTP client fetching FakeStore API data
└── widgets/              # Reusable components
    ├── cart/                     # Cart item card, summary & empty state
    ├── common/                   # Bottom nav, headers, product cards & grid
    └── product_details/          # Image viewer, info section, quantity selector
```

---

## ⚡ State Management Approach

### Why **GetX**?
1. **High Performance & Minimal Boilerplate**: No need for `ChangeNotifier` or verbose Redux/BLoC ceremony. Reactive programming using `.obs` and `Obx()` rebuilds only widgets that depend on changing values.
2. **Decoupled Business Logic**: Controllers (`CartController`, `FilterController`, `ProductSearchController`) are fully decoupled from the UI.
3. **Global Dependency Injection**: With `Get.put(..., permanent: true)` and `Get.find<Controller>()`, controllers can easily be shared across multiple screens (e.g., sharing cart data between details screen and cart tab).
4. **Instant In-Memory Reactivity**: Ensures cart totals, product counts, and active filters immediately reflect across all screens without page reloads.

---

## 📦 Packages & Dependencies

| Package | Purpose |
| :--- | :--- |
| **`get`** | State management, reactive variables, and dependency injection |
| **`dio`** | Robust HTTP client for handling REST API requests and error handling |
| **`google_fonts`** | Clean, modern typography (Poppins font family) |
| **`gap`** | Clean and consistent spacing between layout widgets |
| **`cupertino_icons`** | iOS-style iconography for high visual appeal |
| **`go_router`** | Declarative routing capability |

---

## 🚀 Getting Started & Setup Instructions

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.12.0` or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extension
- An Android Emulator, iOS Simulator, or connected physical device

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<your-username>/zenzo.git
   cd zenzo
   ```

2. **Install project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter environment:**
   ```bash
   flutter doctor
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 📸 Screenshots

| Home Screen | Filter Bottom Sheet | Search Screen |
|:---:|:---:|:---:|
| *(Add Home Screenshot)* | *(Add Filter Screenshot)* | *(Add Search Screenshot)* |

| Product Details | Shopping Cart | Empty Cart State |
|:---:|:---:|:---:|
| *(Add Details Screenshot)* | *(Add Cart Screenshot)* | *(Add Empty Cart Screenshot)* |

---

## 📦 Generating APK (Android)

To generate a release APK for submission:

```bash
flutter build apk --release
```

The compiled APK will be located at:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📝 License
This project is open-source and created for educational and assignment assessment purposes.
