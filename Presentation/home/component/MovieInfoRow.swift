
import SwiftUI

struct MovieInfoRow: View {
    let movie: Movie

    var body: some View {
        VStack {
            Text(movieYear)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.textSecondary)

            Spacer().frame(minHeight: 16)
            
            Text(movie.title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .multilineTextAlignment(.center)

            Spacer().frame(minHeight: 16)

            HStack(spacing: 12) {
                Pill(text: "Fantasy")
                Pill(text: "2h 7min")
                Pill(text: String(format: "%.1f", 2),
                     icon: "star.fill",
                     isRating: true)
            }
            
            Spacer().frame(minHeight: 16)

        }
        .frame(maxWidth: .infinity)
    }

    private var movieYear: String {
        if let date = movie.releaseDate, date.count >= 4 {
            return String(date.prefix(4))
        }
        return "—"
    }
}
