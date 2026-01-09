import Foundation

struct Month: Identifiable, Hashable {
    let id: UUID = UUID()
    let date: Date
    let days: [Day]
    
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
    
    var year: Int {
        Calendar.current.component(.year, from: date)
    }
    
    var monthNumber: Int {
        Calendar.current.component(.month, from: date)
    }
    
    var headerText: String {
        "\(monthName) \(year)"
    }
    
    var dayGridArray: [[Day]] {
        var grid: [[Day]] = []
        var currentWeek: [Day] = []
        
        // Add empty cells for days before the 1st
        let firstWeekday = Calendar.current.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<(firstWeekday - 1) {
            // No filler needed for our display, but logically they exist
        }
        
        for day in days {
            let weekday = Calendar.current.component(.weekday, from: day.date)
            currentWeek.append(day)
            
            if weekday == 7 || day == days.last {
                grid.append(currentWeek)
                currentWeek = []
            }
        }
        
        if !currentWeek.isEmpty {
            grid.append(currentWeek)
        }
        
        return grid
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
