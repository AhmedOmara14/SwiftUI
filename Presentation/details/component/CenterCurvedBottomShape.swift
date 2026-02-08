import SwiftUI

struct CenterCurvedBottomShape: Shape {
    var cornerRadius: CGFloat = 35
    var notchRadius: CGFloat = 35
    var notchPadding: CGFloat = 4

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        let cr = min(cornerRadius, 35)
        let nr = min(notchRadius, w * 0.25)

        let notchCenter = CGPoint(x: w / 2, y: h)

        let notchStartX = notchCenter.x - nr - notchPadding
        let notchEndX   = notchCenter.x + nr + notchPadding

        var p = Path()

        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: w, y: 0))
        p.addLine(to: CGPoint(x: w, y: h - cr))

        p.addQuadCurve(
            to: CGPoint(x: w - cr, y: h),
            control: CGPoint(x: w, y: h)
        )

        p.addLine(to: CGPoint(x: notchEndX, y: h))

        p.addArc(
            center: CGPoint(x: notchCenter.x, y: h),
            radius: nr + notchPadding,
            startAngle: .degrees(0),
            endAngle: .degrees(180),
            clockwise: true
        )

        p.addLine(to: CGPoint(x: cr, y: h))

        p.addQuadCurve(
            to: CGPoint(x: 0, y: h - cr),
            control: CGPoint(x: 0, y: h)
        )

        p.addLine(to: CGPoint(x: 0, y: 0))

        p.closeSubpath()
        return p
    }
}
