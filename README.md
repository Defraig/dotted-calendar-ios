# iOS App Architecture & Setup Guide

## Project Structure

```
DottedCalendar_iOS/
├── DottedCalendar/
│   ├── App/
│   │   └── DottedCalendarApp.swift         # Entry point
│   ├── Core/
│   │   ├── Design/
│   │   │   └── CalendarColor.swift         # Design system & colors
│   │   ├── Models/
│   │   │   ├── Day.swift                   # Day model with display logic
│   │   │   └── Month.swift                 # Month model with grid utilities
│   │   └── Services/
│   │       ├── CalendarService.swift       # Calendar logic & day generation
│   │       ├── LocalStorageService.swift   # UserDefaults wrapper
│   │       ├── HolidayProvider.swift       # Holiday detection
│   │       └── AdService.swift             # Ad management
│   └── Presentation/
│       ├── ViewModels/
│       │   ├── CalendarViewModel.swift     # Calendar state & logic
│       │   └── AdCoordinator.swift         # Ad lifecycle management
│       └── Views/
│           ├── ContentView.swift           # Main calendar view
│           ├── MonthCardView.swift         # Month card component
│           ├── DayDotView.swift            # Individual day dot
│           └── AdContainerView.swift       # Ad overlay
```

## Architecture Pattern: MVVM

- **Models:** `Day`, `Month` - Data structures with computed properties
- **ViewModels:** `CalendarViewModel`, `AdCoordinator` - State management using `@Published`
- **Views:** SwiftUI components with `@ObservedObject` observers
- **Services:** Business logic (calendar math, storage, holidays)

## Key Design Decisions

1. **SwiftUI Framework:** Modern, declarative UI system
2. **Clean Service Layer:** Separation of concerns - storage, calendar logic, ads
3. **Design System:** Centralized `CalendarColor` and `CalendarDesignSystem` for consistency
4. **No Third-Party Dependencies:** Uses only Apple frameworks (production-ready, minimal bloat)
5. **MVVM Pattern:** Clear separation between presentation and business logic

## Build Instructions

1. Open the project in Xcode 15+
2. Select target: DottedCalendar
3. Set signing team (Apple Developer account required)
4. Build: Cmd+B
5. Run: Cmd+R

## Key Features

- ✅ 2x6 month grid layout
- ✅ Automatic day marking at midnight
- ✅ Color-coded dots (gray/red for holidays)
- ✅ Ad interstitial on launch
- ✅ Local storage (no cloud)
- ✅ Responsive design with accessibility support
- ✅ SF Symbols integration ready

## Deployment Notes

- Minimum iOS 14.0
- AdMob integration: Replace placeholder IDs in `AdService.swift`
- Localization: Add additional holiday dates in `HolidayProvider.swift`
