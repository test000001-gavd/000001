import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var vm: MorseCodeViewModel
    @EnvironmentObject var theme: ThemeManager
    @State private var showCopyAlert = false
    
    var body: some View {
        ZStack {
            CyberBackground()
            
            VStack {
                if vm.history.isEmpty {
                    Text("No history yet")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                } else {
                    List {
                        ForEach(vm.history) { item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Input: \(item.input)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Output: \(item.output)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Mode: \(item.mode.rawValue.capitalized)")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(10)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                // 点击复制内容
                                UIPasteboard.general.string = item.output
                                showCopyAlert = true
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
                
                Spacer()
                
                CyberButton(
                    action: vm.clearHistory,
                    label: "Clear History",
                    icon: "trash.fill"
                )
                .padding()
            }
            .padding()
        }
        .navigationTitle("History")
        .onAppear {
            // 每次进入页面时加载最新历史记录
            vm.loadHistory()
        }
        .alert(isPresented: $showCopyAlert) {
            Alert(
                title: Text("Copied!"),
                message: Text("The content has been copied to the clipboard."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        vm.history.remove(atOffsets: offsets)
        vm.saveHistory()
    }
}
