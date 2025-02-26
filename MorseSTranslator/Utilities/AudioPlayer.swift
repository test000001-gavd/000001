import AVFoundation

final class AudioPlayer {
    static let shared = AudioPlayer()
    private var engine = AVAudioEngine()
    private var playerNode = AVAudioPlayerNode()
    private let dotDuration: TimeInterval = 0.1 // 短音时长
    private let dashDuration: TimeInterval = 0.3 // 长音时长
    private let sampleRate: Double = 44100 // 采样率
    
    init() {
        setupAudioEngine()
    }
    
    private func setupAudioEngine() {
        engine.attach(playerNode)
        
        // 设置输出格式为单声道
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!
        engine.connect(playerNode, to: engine.mainMixerNode, format: format)
        
        do {
            try engine.start()
        } catch {
            print("AudioEngine Error: \(error)")
        }
    }
    
    func playMorseCode(_ code: String) {
        // 停止当前播放
        playerNode.stop()
        
        // 生成音频缓冲区
        let buffer = generateMorseCodeBuffer(code)
        
        // 播放音频
        playerNode.scheduleBuffer(buffer, completionHandler: nil)
        playerNode.play()
    }
    
    private func generateMorseCodeBuffer(_ code: String) -> AVAudioPCMBuffer {
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!
        
        // 计算总帧数
        var totalFrames: Int = 0
        for character in code {
            switch character {
            case ".":
                totalFrames += Int(dotDuration * sampleRate)
            case "-":
                totalFrames += Int(dashDuration * sampleRate)
            case " ":
                totalFrames += Int(dotDuration * sampleRate) // 间隔
            default:
                break
            }
        }
        
        // 创建缓冲区
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(totalFrames))!
        buffer.frameLength = buffer.frameCapacity
        
        // 填充音频数据
        var currentFrame: Int = 0
        let samples = buffer.floatChannelData![0]
        
        for character in code {
            let duration: TimeInterval
            let frequency: Double
            
            switch character {
            case ".":
                duration = dotDuration
                frequency = 880 // 高频率
            case "-":
                duration = dashDuration
                frequency = 440 // 低频率
            case " ":
                duration = dotDuration // 间隔
                frequency = 0 // 静音
            default:
                continue
            }
            
            let frameCount = Int(duration * sampleRate)
            
            // 确保不会超出缓冲区范围
            guard currentFrame + frameCount <= totalFrames else { break }
            
            if frequency > 0 {
                // 生成音频信号
                for i in 0..<frameCount {
                    samples[currentFrame + i] = sin(Float(currentFrame + i) * 2 * .pi * Float(frequency) / Float(sampleRate))
                }
            } else {
                // 静音间隔
                for i in 0..<frameCount {
                    samples[currentFrame + i] = 0 // 静音
                }
            }
            
            currentFrame += frameCount
        }
        
        return buffer
    }
}
