import WidgetKit
import SwiftUI

// MARK: - Widget Entry

struct DottedCalendarWidgetEntry: TimelineEntry {
    let date: Date
    let months: [Month]
    let currentMonth: Month?
}

// MARK: - Timeline Provider

struct DottedCalendarWidgetProvider: TimelineProvider {
    private let calendarService = CalendarService.shared
    
    func placeholder(in context: Context) -> DottedCalendarWidgetEntry {
        let months = calendarService.generateYear()
        let currentMonth = months.first {
            Calendar.current.isDateInThisMonth($0.date)
        }
        return DottedCalendarWidgetEntry(
            date: Date(),
            months: months,
            currentMonth: currentMonth
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DottedCalendarWidgetEntry) -> Void) {
        let months = calendarService.generateYear()
        let currentMonth = months.first {
            Calendar.current.isDateInThisMonth($0.date)
        }
        let entry = DottedCalendarWidgetEntry(
            date: Date(),
            months: months,
            currentMonth: currentMonth
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DottedCalendarWidgetEntry>) -> Void) {
        let months = calendarService.generateYear()
        let currentMonth = months.first {
            Calendar.current.isDateInThisMonth($0.date)
        }
        
        // Create entry for today
        var entries: [DottedCalendarWidgetEntry] = []
        entries.append(
            DottedCalendarWidgetEntry(
                date: Date(),
                months: months,
                currentMonth: currentMonth
            )
        )
        
        // Schedule next update at midnight
        var calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let nextMidnight = calendar.startOfDay(for: tomorrow)
        
        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

// MARK: - Widget View

struct DottedCalendarWidgetView: View {
    let entry: DottedCalendarWidgetEntry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack {
            CalendarDesignSystem.primaryBackground
                .ignoresSafeArea()
            
            if let currentMonth = entry.currentMonth {
                switch widgetFamily {
                case .systemSmall:
                    SmallWidgetView(month: currentMonth)
                case .systemMedium:
                    MediumWidgetView(month: currentMonth)
                default:
                    SmallWidgetView(month: currentMonth)
                }
            } else {
                Text("No Data")
                    .foregroundColor(CalendarDesignSystem.textSecondary)
            }
        }
    }
}

struct SmallWidgetView: View {
    let month: Month
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(month.headerText)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(CalendarDesignSystem.textPrimary)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7),
                spacing: 4
            ) {
                ForEach(month.days, id: \.id) { day in
                    Circle()
                        .fill(day.displayColor.swiftUIColor)
                        .frame(width: 5, height: 5)
                }
            }
        }
        .padding(12)
    }
}

struct MediumWidgetView: View {
    let month: Month
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(month.headerText)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(CalendarDesignSystem.textPrimary)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 7),
                spacing: 5
            ) {
                ForEach(month.days, id: \.id) { day in
                    Circle()
                        .fill(day.displayColor.swiftUIColor)
                        .frame(width: 7, height: 7)
                }
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Label("Open App", systemImage: "calendar")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(CalendarDesignSystem.accentRed)
            }
        }
        .padding(12)
    }
}

// MARK: - Widget

@main
struct DottedCalendarWidget: Widget {
    let kind: String = "DottedCalendarWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DottedCalendarWidgetProvider()
        ) { entry in
            DottedCalendarWidgetView(entry: entry)
                .containerBackground(
                    CalendarDesignSystem.primaryBackground,
                    for: .widget
                )
        }
        .configurationDisplayName("Calendar")
        .description("See your current month's daily progress")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview

#Preview(as: .systemSmall) {
    DottedCalendarWidget()
} timeline: {
    let months = CalendarService.shared.generateYear()
    let currentMonth = months.first
    let entry = DottedCalendarWidgetEntry(
        date: Date(),
        months: months,
        currentMonth: currentMonth
    )
    DottedCalendarWidgetEntry(date: Date(), months: months, currentMonth: currentMonth)
}
