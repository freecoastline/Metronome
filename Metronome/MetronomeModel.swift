//
//  MetronomeModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import SwiftUI
import AVFoundation

class MetronomeModel:ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    @Published var bpm:Int
    @Published var playing:Bool = false
    init(bpm: Int) {
        self.bpm = bpm
        setupAudioPlayer()
    }
    
    // 单独的方法设置音频播放器，便于调试和复用
     private func setupAudioPlayer() {
         // 检查文件是否存在
         guard let soundURL = Bundle.main.url(forResource: "taylor", withExtension: "mp3") else {
             print("错误：找不到音频文件 'taylor.mp3'")
             print("请确保文件已添加到项目中，并且Target Membership已勾选")
             return
         }
         
         print("找到音频文件：\(soundURL.path)")
         
         do {
             // 初始化音频播放器
             audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
             
             // 准备播放（预加载音频数据到内存）
             guard let player = audioPlayer else {
                 print("错误：音频播放器初始化失败")
                 return
             }
             
             if player.prepareToPlay() {
                 print("音频准备就绪")
                 audioPlayer?.play()
                 // 可选：设置循环播放
                 // player.numberOfLoops = -1 // -1表示无限循环
             } else {
                 print("警告：音频准备播放失败")
             }
             
         } catch {
             print("错误：初始化音频播放器失败 - \(error.localizedDescription)")
             print("错误详情：\(error)")
         }
     }
}
