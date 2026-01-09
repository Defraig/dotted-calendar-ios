import SwiftUI

struct DayDotView: View {
    let day: Day
    
    var body: some View {
        ZStack {
            // Touch target area (invisible, for accessibility)
            Circle()
                .foregroundColor(.clear)
                .frame(height: CalendarDesignSystem.dotTouchTarget)
            
            // Actual dot
            Circle()
                .fill(day.displayColor.swiftUIColor)
                .frame(width: CalendarDesignSystem.dotDiameter, height: CalendarDesignSystem.dotDiameter)
                .transition(.scale)
        }
        .frame(height: CalendarDesignSystem.dotTouchTarget)
        .accessibilityLabel("Day \(day.dayNumber)")
        .accessibilityValue(
            "\(day.isMarked ? "Completed" : "Not completed")\(day.isSunday ? ", Sunday" : "")\(day.isHoliday ? ", Holiday" : "")"
        )
    }
}

#Preview {
    DayDotView(
        day: Day(
            date: Date(),
            dayNumber: 15,
            isMarked: true,
            isSunday: false,
            isHoliday: false
        )
    )
}
