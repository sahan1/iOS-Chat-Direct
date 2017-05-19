//
//  Settings.swift
//  chatdirect
//
//  Created by SAHAN BALASURIYA on 19/05/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//


import UIKit
import AVFoundation


class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Songs.dataSource = self
        Songs.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "bensound-dubstep", ofType: "mp3") //URL
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            // set up the player by loading the sound file
            try soundPlayer = AVAudioPlayer(contentsOf: url)
        }
            //catch the error if playback fails
        catch { print("file not available")}
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var Songs: UIPickerView!
    
    var items = ["bensound-dubstep" , "bensound-epic" , "bensound-moose"]
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let path =
            Bundle.main.path(forResource: items[row], ofType: "mp3") //URL of the file
        let url = URL(fileURLWithPath: path!)
        
        do {
            //set up the player by loading the sound file
            try soundPlayer = AVAudioPlayer(contentsOf: url)
        }
            //catch the error if playback fails
        catch { print("file not available")}
    }
    
    
    var soundPlayer: AVAudioPlayer?
    var elapsedTime : TimeInterval = 0
    var isplaying = false
    
    
    
    @IBAction func PlayPause(_ sender: UIButton) {
        //play & pause
        if(isplaying == false){
            if soundPlayer != nil {
                soundPlayer!.currentTime = elapsedTime
                soundPlayer!.play()
            }
            isplaying = true


        } else {
            if soundPlayer != nil {
                elapsedTime = soundPlayer!.currentTime
                soundPlayer!.pause()}
            isplaying = false
            }

    }


    @IBAction func stop(_ sender: UIButton) {
        
        if soundPlayer != nil {
            soundPlayer!.stop()
            elapsedTime = 0
        }
        isplaying = false
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
