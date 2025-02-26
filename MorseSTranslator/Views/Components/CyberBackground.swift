import SwiftUI

struct CyberBackground: View {
    @State private var gridOffset: CGFloat = 0
    @State private var lightPoints: [LightPoint] = []
    @EnvironmentObject private var theme: ThemeManager
    
    var body: some View {
        ZStack {
            // 基础渐变背景
            theme.mainGradient
                .ignoresSafeArea()
            
            // 动态网格
            Canvas { context, size in
                let gridSize: CGFloat = 60
                for x in stride(from: -gridSize, to: size.width + gridSize, by: gridSize) {
                    for y in stride(from: -gridSize, to: size.height + gridSize, by: gridSize) {
                        let path = Path(ellipseIn: CGRect(
                            x: x + gridOffset,
                            y: y + gridOffset,
                            width: 2,
                            height: 2
                        ))
                        context.fill(path, with: .color(Color.white.opacity(0.05)))
                    }
                }
            }
            .blur(radius: 2)
            .animation(
                .linear(duration: 30).repeatForever(autoreverses: false),
                value: gridOffset
            )
            
            // 随机光点
            ForEach(Array(lightPoints.enumerated()), id: \.element.id) { index, point in
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [point.color.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 50
                        )
                    )
                    .frame(width: point.size, height: point.size)
                    .position(point.position)
                    .opacity(point.opacity)
                    .onAppear {
                        // 光点闪烁动画
                        withAnimation(
                            .easeInOut(duration: Double.random(in: 1...3))
                            .repeatForever()
                        ) {
                            lightPoints[index].opacity = lightPoints[index].opacity == 0.3 ? 0.8 : 0.3
                        }
                        
                        // 光点移动动画
                        withAnimation(
                            .easeInOut(duration: Double.random(in: 5...10))
                            .repeatForever()
                        ) {
                            lightPoints[index].position = CGPoint(
                                x: CGFloat.random(in: 0..<UIScreen.main.bounds.width),
                                y: CGFloat.random(in: 0..<UIScreen.main.bounds.height)
                            )
                        }
                    }
            }
        }
        .onAppear {
            // 初始化网格动画
            gridOffset = -1000
            
            // 生成随机光点
            lightPoints = (0..<15).map { _ in
                LightPoint(
                    position: CGPoint(
                        x: CGFloat.random(in: 0..<UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0..<UIScreen.main.bounds.height)
                    ),
                    size: CGFloat.random(in: 50...100),
                    color: [.cyan, .purple, .pink].randomElement()!,
                    opacity: CGFloat.random(in: 0.3...0.8)
                )
            }
        }
    }
}

// MARK: - 光点模型
struct LightPoint: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: CGFloat
}
