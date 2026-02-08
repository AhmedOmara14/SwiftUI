
import SwiftUI

struct AnimatedMovieSlider: View {
    let movies: [Movie]
    @Binding var currentIndex: Int
    let onTap: (Movie) -> Void

    private let cardCorner: CGFloat = 28
    private let spacing: CGFloat = 18

    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.70
            let cardHeight = min(460, geo.size.height) * 0.92
            let sidePadding = (geo.size.width - cardWidth) / 2

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(Array(movies.enumerated()), id: \.offset) { index, movie in
                            GeometryReader { itemGeo in
                                let midX = itemGeo.frame(in: .global).midX
                                let screenMid = UIScreen.main.bounds.midX
                                let distance = abs(midX - screenMid)

                                let progress = min(distance / screenMid, 1)

                                let scale = 1 - (progress * 0.12)
                                let opacity = 1 - (progress * 0.35)
                                let blur = progress * 1.5

                                Button {
                                    onTap(movie)
                                } label: {
                                    MovieCard(movie: movie,cardWidth: cardWidth,cardHeight: cardHeight)
                                    .frame(width: cardWidth, height: cardHeight)
                                    .clipShape(RoundedRectangle(cornerRadius: cardCorner, style: .continuous))
                                    .shadow(color: .black.opacity(0.35), radius: 18, x: 0, y: 18)
                                    .scaleEffect(scale)
                                    .opacity(opacity)
                                    .blur(radius: blur)
                                    .animation(.spring(response: 0.35, dampingFraction: 0.85), value: scale)
                                }
                                .buttonStyle(.plain)
                                .onChange(of: progress) { _, newProgress in
                                    if newProgress < 0.08, currentIndex != index {
                                        currentIndex = index
                                    }
                                }
                            }
                            .frame(width: cardWidth, height: cardHeight)
                            .id(index)
                        }
                    }
                    .padding(.horizontal, sidePadding)
                    .padding(.vertical, 10)
                }
                .onAppear {
                    proxy.scrollTo(currentIndex, anchor: .center)
                }
                .onChange(of: currentIndex) { _, newIndex in
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
        }
        .frame(height: 430)
    }

    
}


private extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

func posterURL(_ movie: Movie) -> URL? {
    guard let path = movie.posterPath, !path.isEmpty else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
}
