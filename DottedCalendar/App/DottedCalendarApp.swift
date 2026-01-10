import SwiftUI

struct DottedCalendarApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Ad Container
                AdContainerView(adCoordinator: appCoordinator.adCoordinator)
                    .zIndex(1)
                
                // Main Calendar View
                ContentView(viewModel: CalendarViewModel())
                    .zIndex(0)
            }
            .preferredColorScheme(nil)
        }
    }
}

class AppCoordinator: ObservableObject {
    let adCoordinator = AdCoordinator()
}
