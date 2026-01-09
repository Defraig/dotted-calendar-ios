import SwiftUI

struct MonthCardView: View {
    let month: Month
    
    var body: some View {
        VStack(alignment: .leading, spacing: CalendarDesignSystem.spacing12) {
            // Month Header
            Text(month.headerText)
                .font(CalendarDesignSystem.monthHeaderFont)
                .foregroundColor(CalendarDesignSystem.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Day Grid (7 columns for Sunday-Saturday)
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: CalendarDesignSystem.spacing8), count: 7),
                spacing: CalendarDesignSystem.spacing8
            ) {
                ForEach(month.days, id: \.id) { day in
                    DayDotView(day: day)
                }
            }
        }
        .padding(CalendarDesignSystem.spacing12)
        .background(CalendarDesignSystem.secondaryBackground)
        .cornerRadius(CalendarDesignSystem.cornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    MonthCardView(month: Month(date: Date(), days: []))
}
