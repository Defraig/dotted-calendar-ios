import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var months: [Month] = []
    @Published var currentMonth: Month?
    @Published var selectedDate: Date = Date()
    
    private let calendarService = CalendarService.shared
    private let storageService = LocalStorageService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadCalendar()
        setupObservers()
    }
    
    // MARK: - Public Methods
    
    func loadCalendar() {
        let calendar = Calendar.current
        let now = Date()
        
        months = calendarService.generateYear(for: now)
        currentMonth = months.first { m in
            calendar.component(.month, from: m.date) == calendar.component(.month, from: now) &&
            calendar.component(.year, from: m.date) == calendar.component(.year, from: now)
        }
        
        // Mark today if not already marked
        calendarService.markDayIfNeeded()
    }
    
    func refreshCalendar() {
        loadCalendar()
    }
    
    // MARK: - Private Methods
    
    private func setupObservers() {
        // Observe when app comes to foreground
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.refreshCalendar()
            }
            .store(in: &cancellables)
    }
}
