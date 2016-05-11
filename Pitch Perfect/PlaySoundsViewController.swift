//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gamal Shaban on 5/11/16.
//  Copyright © 2016 Gamal Shaban. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var RabbitButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var ReverbButton: UIButton!
    @IBOutlet weak var darthvaderButton: UIButton!
    @IBOutlet weak var SnailButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile :AVAudioFile!
    var audioEngine :AVAudioEngine!
    var audioPlayerNode :AVAudioPlayerNode!
    var stopTimer :NSTimer!

    enum ButtonType :Int {
        case Slow = 0, Fast, Chipmunk,Vader, Echo, Reverb }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupAudio()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSoundForButton (sender : UIButton){
        print("play")
        
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch : 1000)
        case .Vader:
            playSound(pitch : -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
       
        }
        
        configureUI(.Playing)
    }
    
    
    @IBAction func stopButtonPressed (sender : AnyObject){
        stopAudio()
        print("stop")
    }
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }

    

}
