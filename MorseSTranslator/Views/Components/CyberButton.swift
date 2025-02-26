import SwiftUI

struct CyberButton: View {
    let action: () -> Void
    let label: String
    let icon: String
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .font(.system(.title3, design: .monospaced))
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            )
        }
        .foregroundColor(.white)
    }
}
