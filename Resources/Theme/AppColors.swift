import SwiftUI

extension Color {

    // Backgrounds
    static let bg = Color(hex: "#080511")
    static let surface = Color(hex: "#3D2A49")

    // Accents
    static let accent = Color(hex: "#6442e9")

    // Text
    static let textPrimary = Color(hex: "#ffffff")
    static let textSecondary = Color(hex: "#c3c3c3")
}

extension Color {
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")

        var value: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&value)

        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((value >> 16) & 0xFF) / 255
            g = Double((value >> 8) & 0xFF) / 255
            b = Double(value & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}

