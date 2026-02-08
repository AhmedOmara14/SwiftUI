
import SwiftUI

struct MovieCard: View {
    let movie: Movie
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: posterURL(movie)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: cardWidth, height: cardHeight)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(width: cardWidth, height: cardHeight)
                @unknown default:
                    EmptyView()
                }
            }

            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: cardHeight * 0.45)
        }
        
    }
}
