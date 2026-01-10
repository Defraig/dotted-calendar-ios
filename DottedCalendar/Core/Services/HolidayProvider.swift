import Foundation

class HolidayProvider {
    static let shared = HolidayProvider()
    
    private let calendar = Calendar.current
    
    // MARK: - US Holidays (expandable for other locales)
    
    private let fixedHolidays: [String: (Int, Int)] = [
        "New Year's Day": (1, 1),
        "Independence Day": (7, 4),
        "Christmas": (12, 25),
    ]
    
    // Holidays with variable dates (e.g., Thanksgiving - 4th Thursday of November)
    private let variableHolidays: [String: (Int, Int, Int)] = [
        "Thanksgiving": (11, 4, 5), // (month, week, weekday) - 4th Thursday of November
        "Memorial Day": (5, -1, 2), // Last Monday of May
        "Labor Day": (9, 1, 2), // First Monday of September
    ]
    
    // MARK: - Public Methods
    
    func isHoliday(_ date: Date) -> Bool {
        if isFixedHoliday(date) {
            return true
        }
        
        if isVariableHoliday(date) {
            return true
        }
        
        return false
    }
    
    // MARK: - Private Methods
    
    private func isFixedHoliday(_ date: Date) -> Bool {
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        for (_, (holidayMonth, holidayDay)) in fixedHolidays {
            if month == holidayMonth && day == holidayDay {
                return true
            }
        }
        
        return false
    }
    
    private func isVariableHoliday(_ date: Date) -> Bool {
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        for (_, (holidayMonth, week, holidayWeekday)) in variableHolidays {
            if month == holidayMonth {
                if let calculatedDay = calculateVariableHolidayDay(
                    month: month,
                    year: calendar.component(.year, from: date),
                    week: week,
                    weekday: holidayWeekday
                ) {
                    if day == calculatedDay && weekday == holidayWeekday {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    private func calculateVariableHolidayDay(
        month: Int,
        year: Int,
        week: Int,
        weekday: Int
    ) -> Int? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        // Handle negative week (counting from end of month)
        if week < 0 {
            // Get last day of month
            dateComponents.month = month == 12 ? 1 : month + 1
            dateComponents.day = 0
            guard let lastDayOfMonth = calendar.date(from: dateComponents) else {
                return nil
            }
            
            let lastDay = calendar.component(.day, from: lastDayOfMonth)
            
            // Find the nth weekday from the end
            for day in stride(from: lastDay, through: 1, by: -1) {
                dateComponents.month = month
                dateComponents.day = day
                guard let date = calendar.date(from: dateComponents) else { continue }
                
                if calendar.component(.weekday, from: date) == weekday {
                    return day
                }
            }
        } else {
            // Find nth occurrence from start of month
            dateComponents.day = 1
            guard let firstDay = calendar.date(from: dateComponents) else {
                return nil
            }
            
            let daysInMonth = calendar.range(of: .day, in: .month, for: firstDay)?.count ?? 0
            var occurrenceCount = 0
            
            for day in 1...daysInMonth {
                dateComponents.day = day
                guard let date = calendar.date(from: dateComponents) else { continue }
                
                if calendar.component(.weekday, from: date) == weekday {
                    occurrenceCount += 1
                    if occurrenceCount == week {
                        return day
                    }
                }
            }
        }
        
        return nil
    }
}
