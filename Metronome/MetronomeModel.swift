//
//  MetronomeModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import SwiftUI
import AVFoundation

struct MetronomeModel {
    var audioPlayer: AVAudioPlayer?
    var bpm:Int
    var playing:Bool = false
    init(bpm: Int) {
        self.bpm = bpm
        setupAudioPlayer()
    }
    
    // 单独的方法设置音频播放器，便于调试和复用
    private mutating func setupAudioPlayer() {
         // 检查文件是否存在
         guard let soundURL = Bundle.main.url(forResource: "woodenFish", withExtension: "m4a") else {
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
                 audioPlayer?.numberOfLoops = -1
                 audioPlayer?.enableRate = true
                 audioPlayer?.rate = Float(bpm) / 60.0
                 print("音频准备就绪")
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
