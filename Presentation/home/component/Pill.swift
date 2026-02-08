
import SwiftUI

struct Pill: View {
    let text: String
    var icon: String? = nil
    var isRating: Bool = false

    var body: some View {
        HStack(spacing: 8) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isRating ? .yellow : .white.opacity(0.85))
            }

            Text(text)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.white.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)
        )
    }
}
