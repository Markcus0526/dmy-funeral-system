# BinZang Funeral Management System (殡葬管理系统)

A comprehensive cross-platform funeral service management system for managing cemeteries, burial services, memorial reservations, and related business operations.

## 📋 Project Overview

BinZang (殡葬) is a full-featured funeral management system designed to digitize and streamline funeral service operations. The system provides management for cemetery plots, burial reservations, memorial services, product sales, and performance tracking.

## 🏗️ System Architecture

```
dmy-funeral-system/
├── Backend/              # ASP.NET MVC 5 Backend
├── Service/              # WCF Services & Windows Services
├── Android/              # Android Mobile Application
├── iOS/                  # iOS Mobile Application
├── Database/             # SQL Server Database Files
└── README.md
```

## 🖥️ Backend (ASP.NET MVC 5)

### Technology Stack
- **Framework:** ASP.NET MVC 5
- **Language:** C#
- **Database:** SQL Server
- **Authentication:** Forms Authentication with Role-based Access Control

### Controllers & Modules

| Controller | Module | Description |
|------------|--------|-------------|
| `LingMuOrderController` | 陵墓管理 | Cemetery/Tomb ordering and management |
| `LuoZangReserveController` | 落葬预约 | Burial reservation management |
| `ZoneInformationController` | 区域信息 | Cemetery zone information management |
| `JiBaiReserveController` | 祭拜预约 | Memorial/worship service reservations |
| `ViewsReserveController` | 参观预约 | Visit/tour reservations |
| `ShangPinOrderController` | 商品订单 | Product and merchandise orders |
| `PersonController` | 人员管理 | Person/Staff management |
| `ManagePersonController` | 人员管理 | Extended person management features |
| `AccountController` | 账户管理 | User account management |
| `OtherFeatureController` | 其他功能 | Additional features |
| `RemarkInfoController` | 备注信息 | Remarks and notes management |
| `VacationManageController` | 休假管理 | Vacation/leave management |
| `PerformanceManagementController` | 业绩管理 | Performance tracking and management |

### Project Structure

```
Backend/BinZangBackend/
├── BinZangBackend/
│   ├── Controllers/           # MVC Controllers
│   ├── Models/               # Data models & LINQ to SQL
│   ├── Views/                # Razor Views
│   ├── Content/              # CSS, Images, JS, Plugins
│   ├── Scripts/              # JavaScript libraries
│   └── PushLib/              # JPush integration
```

### Third-Party Libraries
- **KindEditor** - Rich text editor
- **jqPlot** - Charting library
- **dhtmlxScheduler** - Calendar/scheduling component
- **JPush (极光推送)** - Push notifications
- **Baidu Maps SDK** - Map integration

---

## 🔧 Services

### BZService (WCF)
Windows Communication Foundation service for business logic and data operations.

```
Service/BZService/
├── Service.svc               # WCF Service endpoint
├── SvcManager/               # Service business logic
├── DBManager/                # Database management
└── Library/                 # Utility libraries
```

### BZDailyService (Windows Service)
Background Windows service for daily tasks and scheduled operations.

```
Service/BZDailyService/
├── BzDailyService/           # Service implementation
└── ServiceSetup/             # Installation package
```

---

## 📱 Mobile Applications

### Android Application

**Technology:** Native Android (Java)

**Features:**
- Cemetery browsing and selection
- Burial reservation
- Memorial service booking
- Visit scheduling
- Product catalog and ordering
- Push notifications via JPush
- Baidu Maps integration for navigation
- Role-based interface (Staff, Distributor, Manager)

**Project Structure:**
```
Android/AndroidProject/
├── src/com/                  # Java source code
├── res/                      # Resources (layouts, drawables, values)
├── libs/                     # Native libraries
│   └── armeabi/              # ARM native libs (Baidu SDK, JPush, eTTS)
├── assets/                   # Assets
└── AndroidManifest.xml       # App manifest
```

**Key Libraries:**
- Baidu Location SDK - GPS and location services
- Baidu Navigation SDK - Turn-by-turn navigation
- JPush - Push notifications
- eTTS - Text-to-speech

### iOS Application

**Technology:** Native iOS (Objective-C/Swift)

**Features:** Similar to Android with iOS-specific UI/UX

---

## 🗄️ Database

- **BinZang.mdf** - Main database file
- **BinZang_log.ldf** - Transaction log

### Key Tables (Based on Controllers)
- 陵墓订单 (LingMu Orders)
- 落葬预约 (Burial Reservations)
- 祭拜预约 (Memorial Reservations)
- 区域信息 (Zone Information)
- 商品订单 (Product Orders)
- 人员信息 (Person Information)
- 业绩记录 (Performance Records)
- 休假记录 (Vacation Records)

---

## 🔐 Security & Authentication

- **Authentication:** ASP.NET Forms Authentication
- **Role-Based Access Control (RBAC)**
- Custom Role Provider implementation
- Session management with expiration filters

### User Roles
- Administrator
- Staff/Member
- Distributor (代销商)
- Manager (经理)
- Chairman (董事长)

---

## 🚀 Getting Started

### Prerequisites
- Visual Studio 2017+ (for .NET development)
- SQL Server 2012+
- Android Studio (for Android app)
- Xcode (for iOS app)

### Backend Setup

1. Open `Backend/BinZangBackend/BinZangBackend.sln` in Visual Studio
2. Update connection string in `Web.config`
3. Restore NuGet packages
4. Build and run

### Service Setup

1. Open `Service/BZService.sln` for WCF service
2. Open `Service/BZDailyService/BzDailyService.sln` for Windows service
3. Configure database connections in `App.config`/`Web.config`
4. Build and deploy

### Mobile Development

**Android:**
1. Open project in Android Studio
2. Configure Baidu SDK API key
3. Configure JPush App Key
4. Build debug APK

**iOS:**
1. Extract `iOS/BinZang.zip`
2. Open in Xcode
3. Configure provisioning profiles
4. Build for simulator/device

---

## 📞 API Integration

### Push Notifications
- **Provider:** JPush (极光推送)
- **Platforms:** Android & iOS
- **Implementation:** Custom JPush library included

### Maps & Navigation
- **Provider:** Baidu (百度)
- **SDK Keys:**
  - Android: Configured in AndroidManifest.xml
  - iOS: `iOS/Baidu/SDK_key.txt`

---

## 📊 Key Features Summary

| Category | Features |
|----------|----------|
| Cemetery Management | Plot selection, zone management, availability tracking |
| Burial Services | Reservation, scheduling, ceremony management |
| Memorial Services | JiBai (祭拜) booking, memorial hall management |
| Visit Scheduling | Tour reservations, visitor management |
| Product Sales | Catalog, orders, inventory |
| Personnel | Employee management, roles, vacation tracking |
| Performance | Daily/monthly业绩 tracking, reports |
| Notifications | Push notifications, system alerts |

---

## 📄 License

This project contains proprietary code. All rights reserved.

---

