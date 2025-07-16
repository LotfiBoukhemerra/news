# news

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Setup Instructions

1. **Clone the repository:**

    ```bash
    git clone <your-repo-url>
    cd news
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up environment variables:**

    - Create a `.env` file in the project root (if not present).
    - Add your NewsAPI key:
        ```env
        NEWS_API_KEY=your_newsapi_key_here
        ```
    - You can get a free API key from [https://newsapi.org/](https://newsapi.org/)

4. **Run the app:**
    - For Android:
        ```bash
        flutter run -d android
        ```
    - For iOS:
        ```bash
        flutter run -d ios
        ```
    - For Web:
        ```bash
        flutter run -d chrome
        ```
    - For Windows/macOS/Linux:
        ```bash
        flutter run -d windows   # or macos, linux
        ```

## Notes

-   The app requires an active internet connection.
-   News updates automatically every 5 minutes, or you can pull-to-refresh manually.
-   Search functionality is available from the top app bar.
