import SwiftUI

struct AdContainerView: View {
    @ObservedObject var adCoordinator: AdCoordinator
    
    var body: some View {
        ZStack {
            if adCoordinator.shouldShowAd {
                AdView(adCoordinator: adCoordinator)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: adCoordinator.shouldShowAd)
    }
}

struct AdView: View {
    @ObservedObject var adCoordinator: AdCoordinator
    @State private var secondsRemaining: Int = 3
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Close Button (top-right)
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if adCoordinator.isAdDismissible {
                            adCoordinator.dismissAd()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(
                                adCoordinator.isAdDismissible ?
                                CalendarDesignSystem.textPrimary :
                                CalendarDesignSystem.textSecondary.opacity(0.5)
                            )
                    }
                    .disabled(!adCoordinator.isAdDismissible)
                    .padding(CalendarDesignSystem.spacing16)
                }
                
                Spacer()
                
                // Ad Content Area
                VStack(spacing: CalendarDesignSystem.spacing16) {
                    // Placeholder for actual ad
                    RoundedRectangle(cornerRadius: CalendarDesignSystem.cornerRadius)
                        .fill(CalendarDesignSystem.secondaryBackground)
                        .frame(height: 300)
                        .overlay(
                            VStack(spacing: CalendarDesignSystem.spacing8) {
                                Image(systemName: "rectangle.fill")
                                    .font(.system(size: 48))
                                    .foregroundColor(CalendarDesignSystem.borderLight)
                                
                                Text("Advertisement")
                                    .font(CalendarDesignSystem.metadataFont)
                                    .foregroundColor(CalendarDesignSystem.textSecondary)
                            }
                        )
                    
                    // Timer
                    if !adCoordinator.isAdDismissible {
                        Text("Close in \(secondsRemaining)s")
                            .font(CalendarDesignSystem.metadataFont)
                            .foregroundColor(CalendarDesignSystem.textSecondary)
                            .onReceive(timer) { _ in
                                if secondsRemaining > 0 {
                                    secondsRemaining -= 1
                                }
                            }
                    }
                }
                .padding(CalendarDesignSystem.spacing24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AdView(adCoordinator: AdCoordinator())
}
