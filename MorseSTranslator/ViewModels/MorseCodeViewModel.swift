import Foundation

class MorseCodeViewModel: ObservableObject {
    @Published var inputText = ""
    @Published var outputText = ""
    @Published var isEncryptMode = true
    @Published var history: [HistoryItem] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let historyKey = "MorseCodeHistory"
    
    init() {
        loadHistory()
    }
    
    func translate() {
        let result: String?
        if isEncryptMode {
            result = MorseCodeModel.encrypt(inputText)
        } else {
            result = MorseCodeModel.decrypt(inputText)
        }
        
        if let result = result {
            outputText = result
            saveToHistory(result: result)
            alertMessage = "Translation successful!"
            
            // 播放莫斯密码声音
            if isEncryptMode {
                AudioPlayer.shared.playMorseCode(result)
            }
        } else {
            alertMessage = "Translation failed. Please check your input."
        }
        
        showAlert = true
    }
    
    private func saveToHistory(result: String) {
        let item = HistoryItem(
            input: inputText,
            output: result,
            mode: isEncryptMode ? .encrypt : .decrypt
        )
        history.insert(item, at: 0)
        saveHistory()
    }
    
    func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }
    
    func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: historyKey),
              let savedHistory = try? JSONDecoder().decode([HistoryItem].self, from: data)
        else { return }
        history = savedHistory
    }
    
    func clearHistory() {
        history.removeAll()
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
