import SwiftUI

struct CyberTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                colors: [.cyan, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                        .shadow(color: .cyan, radius: 5, x: 0, y: 0)
                )
            
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(.white.opacity(0.5))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            TextEditor(text: $text)
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .background(Color.clear)
                .scrollContentBackground(.hidden) // 隐藏默认背景
                .padding()
                .autocapitalization(.allCharacters)
                .disableAutocorrection(true)
        }
        .frame(height: 150) // 增加输入框高度
    }
}
