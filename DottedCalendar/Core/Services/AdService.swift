import Foundation

class AdService {
    static let shared = AdService()
    
    private let minAdIntervalSeconds: TimeInterval = 30 // Minimum 30 seconds between ads
    private var lastAdShowTime: Date?
    
    // MARK: - Public Methods
    
    func shouldShowAd() -> Bool {
        if let lastTime = lastAdShowTime {
            return Date().timeIntervalSince(lastTime) >= minAdIntervalSeconds
        }
        return true
    }
    
    func recordAdShown() {
        lastAdShowTime = Date()
    }
    
    func getAdNetworkConfig() -> [String: String] {
        // Replace with actual AdMob IDs for production
        return [
            "appId": "ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy",
            "interstitialId": "ca-app-pub-3940256099942544/4411468910",
            "bannerId": "ca-app-pub-3940256099942544/2934735716"
        ]
    }
}
