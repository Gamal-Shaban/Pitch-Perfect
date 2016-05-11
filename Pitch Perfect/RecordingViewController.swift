//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Gamal Shaban on 5/10/16.
//  Copyright © 2016 Gamal Shaban. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController,AVAudioRecorderDelegate{

    @IBOutlet weak var stopRecordingbutton: UIButton!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
  
    var audioRecorder :AVAudioRecorder!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopRecordingbutton.enabled = false
        print("will appare")
    }

    @IBAction func recordAudio(sender: AnyObject) {
        recordingLabel.text = "Recording to progress"
        stopRecordingbutton.enabled = true
        recordingButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]as String
        let recodingName = "RecordedVoise.wav"
        let pathArry = [dirPath, recodingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArry)
        print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
        try!audioRecorder = AVAudioRecorder(URL: filePath!, settings: [ : ])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
      
    }

    @IBAction func stopRecord(sender: AnyObject) {
        stopRecordingbutton.enabled = false
        recordingButton.enabled = true
        print("stop")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
        self.performSegueWithIdentifier("stopRecord", sender: audioRecorder.url)
        } else{
            
            print("saving f recording faild")
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "stopRecord"){
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioUrl = sender as! NSURL
             playSoundsVC.recordedAudioURL = recordedAudioUrl
        }
        
    }
        
    
}

