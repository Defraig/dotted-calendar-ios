import Foundation

struct Day: Identifiable, Hashable {
    let id: UUID = UUID()
    let date: Date
    let dayNumber: Int
    let isMarked: Bool
    let isSunday: Bool
    let isHoliday: Bool
    
    var displayColor: CalendarColor {
        if isSunday || isHoliday {
            return .accentRed
        }
        return isMarked ? .markedGray : .unmarkedGray
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.date == rhs.date && lhs.isMarked == rhs.isMarked
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(isMarked)
    }
}
