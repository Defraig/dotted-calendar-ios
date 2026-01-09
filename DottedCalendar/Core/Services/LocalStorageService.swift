import Foundation

class LocalStorageService {
    static let shared = LocalStorageService()
    
    private let defaults = UserDefaults.standard
    private let markedDaysKey = "markedDays"
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    // MARK: - Public Methods
    
    func markDay(_ date: Date) {
        var markedDays = getMarkedDays()
        let dateString = dateFormatter.string(from: Calendar.current.startOfDay(for: date))
        
        if !markedDays.contains(dateString) {
            markedDays.insert(dateString)
            defaults.set(Array(markedDays), forKey: markedDaysKey)
        }
    }
    
    func isDayMarked(_ date: Date) -> Bool {
        let dateString = dateFormatter.string(from: Calendar.current.startOfDay(for: date))
        return getMarkedDays().contains(dateString)
    }
    
    func getMarkedDays() -> Set<String> {
        let array = defaults.array(forKey: markedDaysKey) as? [String] ?? []
        return Set(array)
    }
    
    func clearAllData() {
        defaults.removeObject(forKey: markedDaysKey)
    }
}
