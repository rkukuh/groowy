//
//  File.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/14/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation
import AVFoundation

enum GroowieSoundEnum: String {
    case blink = "blink"
    case hey = "sound-hey"
    case smile = "sound-smile"
    case snooring = "snooring"
}

class GroowieSound {
    static var backSound = AVAudioPlayer()
    static var soundEffect = AVAudioPlayer()
    
    
    static func startBackSound(){
        GroowieSound.backSound.play()
    }
    
    static func stopBackSound(){
        if GroowieSound.backSound.isPlaying{
            GroowieSound.backSound.stop()
        }
    }
    
    static func changeBackSound(sound: GroowieSoundEnum){
        do{
            GroowieSound.stopBackSound()
            let soundBack = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")
            GroowieSound.backSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundBack!))
            GroowieSound.backSound.prepareToPlay()
            GroowieSound.startBackSound()
        }catch{
            
        }
        
    }
    
    static func stopSoundEffect(){
        if GroowieSound.soundEffect.isPlaying{
            GroowieSound.soundEffect.stop()
        }
    }
    
    static func startSoundEffect(){
        GroowieSound.soundEffect.play()
    }
    
    static func changeSoundEffect(sound: GroowieSoundEnum){
        do{
            GroowieSound.stopSoundEffect()
            let soundBack = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")
            GroowieSound.soundEffect = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundBack!))
            GroowieSound.soundEffect.prepareToPlay()
            GroowieSound.startSoundEffect()
        }catch{
            
        }
    }
    
    static func changeSoundEffectRepeat(sound: GroowieSoundEnum){
        do{
            print(sound.rawValue)
            GroowieSound.stopSoundEffect()
            let soundBack = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")
            GroowieSound.soundEffect = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundBack!))
            GroowieSound.soundEffect.numberOfLoops = -1
            GroowieSound.soundEffect.prepareToPlay()
            GroowieSound.startSoundEffect()
        }catch{
            
        }
    }
    
    static func setAwal()  {
        do{
            let soundBack = Bundle.main.path(forResource: GroowieSoundEnum.smile.rawValue, ofType: "mp3")
            let soundEffect = Bundle.main.path(forResource: GroowieSoundEnum.blink.rawValue, ofType: "mp3")
            GroowieSound.backSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundBack!))
            GroowieSound.backSound.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            //GroowieSound.backSound.play()
            GroowieSound.soundEffect = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundEffect!))
            GroowieSound.soundEffect.prepareToPlay()
        }catch{
            
        }
    }
    
    init() {
        
    }
    
}
