
# SubTracker - Subscription Management App

SubTracker is a clean, user-friendly Flutter application designed to help you keep track of all your subscriptions in one place. Never miss a payment date again with smart reminders and a clear overview of your recurring expenses.

## Screenshots

**Light Mode**

**Dark Mode**

**Add/Edit Screen**

__

__

__

## ✨ Features

-   **Comprehensive Tracking**: Add, edit, and delete all your recurring payments with an intuitive interface.
    
-   **Smart Date Logic**: Simply enter the "Last Paid Date," and the app automatically calculates the correct next payment date for you. The cycle resets automatically after a payment date has passed.
    
-   **Full UI Customization**:
    
    -   **Theme Color**: Personalize the app by choosing your favorite primary color from a selection of Material colors.
        
    -   **Light & Dark Mode**: Seamlessly switch between light and dark themes. Your preference is saved for the next time you open the app.
        
-   **Advanced Personalization**:
    
    -   **Logo Selection**: Choose from a list of predefined logos for popular services (which also auto-fills the title) or upload your own logo from your device's gallery.
        
    -   **Color Coding**: Assign a unique color to each subscription for easy visual identification at a glance.
        
-   **Flexible Reminders**:
    
    -   Toggle reminders on or off for any subscription.
        
    -   Choose to be notified 1, 2, 3, 5, or 7 days before a payment is due.
        
-   **Global Currency Support**: Track subscriptions in a comprehensive list of world currencies, with the correct symbol displayed on both the home and edit screens.
    
-   **Detailed Entries**: Add categories, notes, and various billing cycles (daily, weekly, monthly, yearly) to each subscription.
    
-   **Local Persistence**: Your data is saved securely on your device, so it's always there when you reopen the app.
    
-   **Modern Permission Handling**: The app gracefully requests the necessary permissions for notifications and alarms on the latest versions of Android.
    

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install "null")
    
-   An editor like VS Code or Android Studio.
    

### Installation

1.  **Clone the repo:**
    
    ```
    git clone [https://github.com/therokibul/subtracker.git](https://github.com/your_username/subtracker.git)
    
    ```
    
2.  **Navigate to the project directory:**
    
    ```
    cd subtracker
    
    ```
    
3.  **Install dependencies:**
    
    ```
    flutter pub get
    
    ```
    
4.  **Run the app:**
    
    ```
    flutter run
    
    ```
    

## 🛠️ Built With

-   [Flutter](https://flutter.dev/ "null") - The UI toolkit for building natively compiled applications.
    
-   [Provider](https://pub.dev/packages/provider "null") - For state management.
    
-   [Shared Preferences](https://pub.dev/packages/shared_preferences "null") - For local data and theme persistence.
    
-   [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications "null") - For scheduling reminders.
    
-   [Image Picker](https://pub.dev/packages/image_picker "null") - For uploading custom logos from the gallery.
    
-   [Permission Handler](https://pub.dev/packages/permission_handler "null") - For managing device permissions for notifications.
    
-   [Flutter Color Picker](https://pub.dev/packages/flutter_colorpicker "null") - For the manual color selection UI.
    

## 🛣️ Future Roadmap

-   **Cloud Sync**: Option to back up and sync data across multiple devices.
    
-   **Analytics & Insights**: Visual charts showing spending by category and over time.
    
-   **Payment History**: Log and view past payments for each subscription.
    
-   **Home Screen Widgets**: View upcoming payments directly from your device's home screen.
    

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
    
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
    
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
    
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
    
5.  Open a Pull Request
    


