import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        ZStack {
            // Background
            CalendarDesignSystem.primaryBackground
                .ignoresSafeArea()
            
            // Calendar Grid
            ScrollView {
                VStack(spacing: CalendarDesignSystem.spacing24) {
                    // Title
                    VStack(alignment: .center, spacing: CalendarDesignSystem.spacing12) {
                        Text("Calendar")
                            .font(CalendarDesignSystem.monthHeaderFont)
                            .foregroundColor(CalendarDesignSystem.textPrimary)
                        
                        Text("Tracking your daily progress")
                            .font(CalendarDesignSystem.metadataFont)
                            .foregroundColor(CalendarDesignSystem.textSecondary)
                    }
                    .padding(.vertical, CalendarDesignSystem.spacing16)
                    
                    // Month Grid (2x6)
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: CalendarDesignSystem.spacing16),
                            GridItem(.flexible(), spacing: CalendarDesignSystem.spacing16)
                        ],
                        spacing: CalendarDesignSystem.spacing24
                    ) {
                        ForEach(viewModel.months, id: \.id) { month in
                            MonthCardView(month: month)
                        }
                    }
                    .padding(.horizontal, CalendarDesignSystem.spacing16)
                }
                .padding(.vertical, CalendarDesignSystem.spacing24)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: CalendarViewModel())
}
