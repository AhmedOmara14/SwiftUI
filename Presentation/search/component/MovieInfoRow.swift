private struct MovieInfoRow: View {
    let movie: Movie

    var body: some View {
        VStack(spacing: 8) {
            Text(movieYear)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.textSecondary)

            Text(movie.title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                Pill(text: "Fantasy")
                Pill(text: "2h 7min")
                Pill(text: String(format: "%.1f", 0),
                     icon: "star.fill",
                     isRating: true)
            }
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
