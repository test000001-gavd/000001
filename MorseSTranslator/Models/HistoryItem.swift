import Foundation

struct HistoryItem: Identifiable, Codable {
    let id = UUID()
    let timestamp = Date()
    let input: String
    let output: String
    let mode: TranslationMode
    
    enum TranslationMode: String, Codable {
        case encrypt, decrypt
    }
}
