import Foundation

class CalendarService {
    static let shared = CalendarService()
    
    private let calendar = Calendar.current
    private let storage = LocalStorageService.shared
    private let holidayProvider = HolidayProvider.shared
    
    // MARK: - Public Methods
    
    func generateYear(for date: Date = Date()) -> [Month] {
        let currentYear = calendar.component(.year, from: date)
        var months: [Month] = []
        
        for monthNumber in 1...12 {
            var dateComponents = DateComponents()
            dateComponents.year = currentYear
            dateComponents.month = monthNumber
            dateComponents.day = 1
            
            guard let monthStartDate = calendar.date(from: dateComponents) else { continue }
            
            let days = generateDays(for: monthStartDate)
            let month = Month(date: monthStartDate, days: days)
            months.append(month)
        }
        
        return months
    }
    
    func generateDays(for monthDate: Date) -> [Day] {
        let range = calendar.range(of: .day, in: .month, for: monthDate)
        guard let numDays = range?.count else { return [] }
        
        var days: [Day] = []
        
        for dayNumber in 1...numDays {
            var dateComponents = calendar.dateComponents([.year, .month], from: monthDate)
            dateComponents.day = dayNumber
            
            guard let date = calendar.date(from: dateComponents) else { continue }
            
            let isSunday = calendar.component(.weekday, from: date) == 1
            let isHoliday = holidayProvider.isHoliday(date)
            let isMarked = storage.isDayMarked(date)
            
            let day = Day(
                date: date,
                dayNumber: dayNumber,
                isMarked: isMarked,
                isSunday: isSunday,
                isHoliday: isHoliday
            )
            
            days.append(day)
        }
        
        return days
    }
    
    func markDayIfNeeded(_ date: Date = Date()) {
        let today = calendar.startOfDay(for: date)
        if !storage.isDayMarked(today) {
            storage.markDay(today)
        }
    }
    
    func isDayMarked(_ date: Date) -> Bool {
        storage.isDayMarked(date)
    }
}
