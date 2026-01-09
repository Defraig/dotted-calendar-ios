import Foundation

class AdCoordinator: ObservableObject {
    @Published var shouldShowAd: Bool = false
    @Published var isAdDismissible: Bool = false
    
    private let adService = AdService.shared
    private var adShowTime: Date?
    
    init() {
        checkAndShowAd()
    }
    
    // MARK: - Public Methods
    
    func checkAndShowAd() {
        if adService.shouldShowAd() {
            shouldShowAd = true
            adShowTime = Date()
            adService.recordAdShown()
            
            // Allow dismissal after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.isAdDismissible = true
            }
        }
    }
    
    func dismissAd() {
        if isAdDismissible {
            shouldShowAd = false
            isAdDismissible = false
        }
    }
    
    func forceClose() {
        shouldShowAd = false
        isAdDismissible = false
    }
}
