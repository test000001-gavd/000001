import Foundation

struct MorseCodeModel {
    static let dictionary: [String: String] = [
        "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".", "F": "..-.",
        "G": "--.", "H": "....", "I": "..", "J": ".---", "K": "-.-", "L": ".-..",
        "M": "--", "N": "-.", "O": "---", "P": ".--.", "Q": "--.-", "R": ".-.",
        "S": "...", "T": "-", "U": "..-", "V": "...-", "W": ".--", "X": "-..-",
        "Y": "-.--", "Z": "--..", "1": ".----", "2": "..---", "3": "...--",
        "4": "....-", "5": ".....", "6": "-....", "7": "--...", "8": "---..",
        "9": "----.", "0": "-----", " ": "/"
    ]
    
    static func encrypt(_ text: String) -> String? {
        guard !text.isEmpty else { return nil }
        return text.uppercased()
            .compactMap { dictionary[String($0)] }
            .joined(separator: " ")
    }
    
    static func decrypt(_ code: String) -> String? {
        guard !code.isEmpty else { return nil }
        let reverseDict = Dictionary(uniqueKeysWithValues: dictionary.map { ($1, $0) })
        let decodedText = code.components(separatedBy: " ")
            .compactMap { reverseDict[$0] }
            .joined()
        return decodedText.isEmpty ? nil : decodedText
    }
}
