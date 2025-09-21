# SubTracker - Subscription Management App

SubTracker is a clean, user-friendly Flutter application designed to help you keep track of all your online payments and subscriptions. Never miss a payment date again with timely notifications and a clear overview of your recurring expenses.

## ✨ Features

* **Add & View Subscriptions:** Easily add new subscriptions with details like name, amount, and next payment date.

* **Multi-Currency Support:** Track subscriptions in various currencies (USD, EUR, GBP, JPY, INR, etc.).

* **Flexible Billing Cycles:** Set billing cycles to one-time, daily, weekly, monthly, or yearly.

* **Company Logos:** Add a logo URL to visually identify each subscription.

* **Dynamic UI Colors:** The app automatically picks the dominant color from the company logo and themes the subscription card for a beautiful, personalized look.

* **Notes & Descriptions:** Add short notes or longer descriptions to any subscription for extra details.

* **Upcoming Payment Notifications:** Receive a notification 3 days before a payment is due, helping you manage your finances proactively.

## 🚀 Getting Started

### Prerequisites

* Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)

* A code editor like VS Code or Android Studio.

### Installation

1. **Clone the repository:**


git clone https://github.com/therokibul/subtracker
cd subtracker


2. **Install dependencies:**


flutter pub get


3. **Run the app:**


flutter run


## 📂 Project Structure


lib/
├── main.dart                   # App entry point
├── models/
│   └── subscription.dart       # Data model for a subscription
├── providers/
│   └── subscription_provider.dart # State management for subscriptions
├── screens/
│   ├── home_screen.dart        # Main screen displaying the list
│   └── add_subscription_screen.dart # Screen to add a new subscription
└── services/
└── notification_service.dart # Handles local notifications


## 🗺️ Future Roadmap

We have exciting plans for SubTracker! Here's what we're looking to add:

* \[ \] **Local Persistence:** Save your subscriptions on your device.

* \[ \] **Edit & Delete:** Modify or remove existing subscriptions.

* \[ \] **Dashboard Summary:** View charts and totals of your monthly/yearly spending.

* \[ \] **Categorization:** Group subscriptions by category (e.g., "Entertainment", "Work").

* \[ \] **Cloud Sync:** Sync your data across multiple devices.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project

2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)

3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)

4. Push to the Branch (`git push origin feature/AmazingFeature`)

5. Open a Pull Request

