import SwiftUI

struct AboutView: View {
    @EnvironmentObject private var theme: ThemeManager
    
    var body: some View {
        ZStack {
            CyberBackground()
            ScrollView {
                VStack(spacing: 20) {
                    Text("MorseS Translator")
                        .font(.system(size: 42, weight: .black, design: .monospaced))
                        .foregroundStyle(theme.mainGradient)
                        .modifier(theme.neonEffect(for: .blue))
                    
                    Text("Version 1.0.1")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    Text("""
                     Discover the MorseS Translator app, a revolutionary tool that bridges the gap between modern communication and the classic Morse code language. Whether you're a Morse code enthusiast, a student learning about historical communication methods, or someone who just loves exploring unique apps, this one is tailor - made for you.
                     Seamless Translation
                     Our app offers lightning - fast and accurate translation between regular text and Morse code. Simply input the text you want to convert, and with a single tap, watch as it transforms into its corresponding Morse code sequence. Vice versa, if you encounter a Morse code string, enter it into the app, and it will be instantly translated into plain, easy - to - understand English.
                     Sound Playback Feature
                     Immerse yourself in the world of Morse code with our built - in sound playback function. After translating text into Morse code, you can click the play button, and the app will audibly transmit the Morse code signals using standard tones. This not only helps in learning the rhythm and patterns of Morse code but also provides an authentic experience, just like the old - fashioned telegraph operators.
                     Historical Record Keeping
                     Never lose track of your translations again. The app automatically stores all your translation history. Whether it was a quick test translation or an important message you translated last week, you can easily access it from the history section. This feature is great for review, learning, or simply keeping a record of your Morse code - related activities.
                     Dynamic Gradient Backgrounds
                     Add a touch of style to your Morse code translation experience. The app comes with a variety of color - changing dynamic gradient backgrounds. As you use the app, the background smoothly transitions between different colors, creating a visually appealing and engaging environment. You can choose from a preset selection of gradient themes or let the app randomly cycle through them for a new look every time you open it.
                     """)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("About")
    }
}
