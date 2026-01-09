import SwiftUI

enum CalendarColor {
    case primaryBackground
    case secondaryBackground
    case unmarkedGray
    case markedGray
    case accentRed
    case textPrimary
    case textSecondary
    case borderLight
    
    var swiftUIColor: Color {
        switch self {
        case .primaryBackground:
            return Color(red: 0.96, green: 0.96, blue: 0.96) // #F5F5F5
        case .secondaryBackground:
            return Color.white // #FFFFFF
        case .unmarkedGray:
            return Color(red: 0.69, green: 0.69, blue: 0.69) // #B0B0B0
        case .markedGray:
            return Color(red: 0.83, green: 0.83, blue: 0.83) // #D3D3D3
        case .accentRed:
            return Color(red: 0.85, green: 0.47, blue: 0.47) // #D97777
        case .textPrimary:
            return Color(red: 0.17, green: 0.17, blue: 0.17) // #2C2C2C
        case .textSecondary:
            return Color(red: 0.40, green: 0.40, blue: 0.40) // #666666
        case .borderLight:
            return Color(red: 0.91, green: 0.91, blue: 0.91) // #E8E8E8
        }
    }
}

struct CalendarDesignSystem {
    // Colors
    static let primaryBackground = CalendarColor.primaryBackground.swiftUIColor
    static let secondaryBackground = CalendarColor.secondaryBackground.swiftUIColor
    static let unmarkedGray = CalendarColor.unmarkedGray.swiftUIColor
    static let markedGray = CalendarColor.markedGray.swiftUIColor
    static let accentRed = CalendarColor.accentRed.swiftUIColor
    static let textPrimary = CalendarColor.textPrimary.swiftUIColor
    static let textSecondary = CalendarColor.textSecondary.swiftUIColor
    static let borderLight = CalendarColor.borderLight.swiftUIColor
    
    // Spacing (8pt grid system)
    static let spacing8: CGFloat = 8
    static let spacing12: CGFloat = 12
    static let spacing16: CGFloat = 16
    static let spacing24: CGFloat = 24
    static let spacing32: CGFloat = 32
    
    // Typography
    static let monthHeaderFont = Font.system(size: 15, weight: .bold, design: .default)
    static let dayLabelFont = Font.system(size: 11, weight: .regular, design: .default)
    static let metadataFont = Font.system(size: 11, weight: .medium, design: .default)
    
    // Dot sizes
    static let dotDiameter: CGFloat = 10
    static let dotTouchTarget: CGFloat = 44
    
    // Corner radius
    static let cornerRadius: CGFloat = 4
}
