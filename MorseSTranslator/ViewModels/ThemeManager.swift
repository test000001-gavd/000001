import SwiftUI

final class ThemeManager: ObservableObject {
    // MARK: - 主题枚举
    enum Theme: String, CaseIterable {
        case cyberpunk
        case matrix
        case synthwave
        
        var displayName: String {
            rawValue.capitalized
        }
    }
    
    // MARK: - 发布属性
    @Published var activeTheme: Theme = .cyberpunk
    @Published var isGlowingEnabled = true
    
    // MARK: - 主题相关属性
    var mainGradient: LinearGradient {
        switch activeTheme {
        case .cyberpunk:
            LinearGradient(
                colors: [.cyan, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .matrix:
            LinearGradient(
                colors: [.black, .green, .black],
                startPoint: .top,
                endPoint: .bottom
            )
        case .synthwave:
            LinearGradient(
                colors: [.blue, .purple, .orange],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    // MARK: - 霓虹光效
    func neonEffect(for color: Color) -> some ViewModifier {
        if isGlowingEnabled {
            return AnyViewModifier(GlowModifier(color: color))
        } else {
            return AnyViewModifier(EmptyModifier())
        }
    }
}

// MARK: - 自定义 ViewModifier
private struct GlowModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: 10)
            .shadow(color: color, radius: 5)
    }
}

private struct EmptyModifier: ViewModifier {
    func body(content: Content) -> some View { content }
}

// MARK: - 类型擦除包装器
struct AnyViewModifier: ViewModifier {
    private let _body: (Content) -> AnyView
    
    init<Modifier: ViewModifier>(_ modifier: Modifier) {
        _body = { content in
            AnyView(content.modifier(modifier))
        }
    }
    
    func body(content: Content) -> some View {
        _body(content)
    }
}
