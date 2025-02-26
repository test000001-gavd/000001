import SwiftUI

struct HomeView: View {
    @StateObject var vm = MorseCodeViewModel()
    @EnvironmentObject var theme: ThemeManager
    @State private var showCopyAlert = false
    
    var body: some View {
        ZStack {
            CyberBackground()
            
            VStack(spacing: 30) {
                Text("MorseS Translator")
                    .font(.system(size: 42, weight: .black, design: .monospaced))
                    .foregroundStyle(theme.mainGradient)
                    .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                    .padding(.top, 40)
                
                // 模式切换按钮
                Picker("Mode", selection: $vm.isEncryptMode) {
                    Text("Encrypt").tag(true)
                    Text("Decrypt").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 30)
                
                CyberTextField(
                    text: $vm.inputText,
                    placeholder: vm.isEncryptMode ? "Enter text" : "Enter Morse code (e.g., .- -...)"
                )
                .padding(.horizontal, 30)
                
                CyberButton(
                    action: {
                        vm.translate() // 翻译并播放声音
                    },
                    label: vm.isEncryptMode ? "Encrypt" : "Decrypt",
                    icon: "bolt.fill"
                )
                .padding(.horizontal, 30)
                
                Text(vm.outputText)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundStyle(theme.mainGradient)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .shadow(color: .cyan, radius: 5, x: 0, y: 0)
                    .onTapGesture {
                        // 点击复制内容
                        UIPasteboard.general.string = vm.outputText
                        showCopyAlert = true
                    }
                
                Spacer()
            }
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(
                title: Text("Translation Result"),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $showCopyAlert) {
            Alert(
                title: Text("Copied!"),
                message: Text("The content has been copied to the clipboard."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
