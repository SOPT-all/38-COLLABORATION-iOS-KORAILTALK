import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: alpha
        )
    }

    static let primary100 = UIColor(hex: 0xD8E3F2)
    static let primary400 = UIColor(hex: 0x649EF3)
    static let primary500 = UIColor(hex: 0x3880EF)
    static let primary600 = UIColor(hex: 0x0B6DFF)

    static let secondary700 = UIColor(hex: 0x1B48A1)

    static let neutral100 = UIColor(hex: 0xF5F8FA)
    static let neutral200 = UIColor(hex: 0xE2E9F0)
    static let neutral300 = UIColor(hex: 0xC2CFDB)
    static let neutral500 = UIColor(hex: 0x8C939C)
    static let neutral700 = UIColor(hex: 0x636C77)
    static let neutral900 = UIColor(hex: 0x3F4550)

    static let surfaceDisabled = UIColor(hex: 0x121212)
    static let surfaceCard = UIColor(hex: 0xFCFCFC)
    static let surfaceDefault = UIColor(hex: 0xFCFCFC)
    static let surfaceElevated = UIColor(hex: 0xF8F8F8)

    static let semanticError = UIColor(hex: 0xFE4C4A)
    static let semanticWarning = UIColor(hex: 0xFF4D00)
    static let semanticInfo = UIColor(hex: 0x70DFF8)
    static let semanticCaution = UIColor(hex: 0xFEDF64)
}

extension CAGradientLayer {
    static func infoBackground(in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = [
            UIColor(hex: 0xFFFFFF).cgColor,
            UIColor(hex: 0xCEE3FF).cgColor,
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.frame = frame
        return layer
    }
}
