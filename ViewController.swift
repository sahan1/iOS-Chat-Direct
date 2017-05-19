//
//  ViewController.swift
//  chatdirect
//
//  Created by SID SHARDANAND on 12/05/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//

import UIKit
import MultipeerConnectivity

var s2encrypt = [UInt8]()
var s2decrypt = [UInt8]()
var ColourScheme = ["3", "2"]


class ViewController: UIViewController {
    
    let connectservice = ConnectionManager()
    var input: String = ""
    var uname: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        connectservice.delegate = self
        self.MessageView.layoutManager.allowsNonContiguousLayout = false
        ConnectionDisplay.text = "Chatroom: " + roomname + ", Members: Just you"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var ConnectionDisplay: UILabel!
    
    @IBOutlet weak var InputField: UITextField!
    
    @IBOutlet var MessageView: UITextView!
    
    @IBAction func SendInput(_ sender: UIButton) {
        if (logininput == ""){
            uname = UIDevice.current.name
        } else {
            uname = logininput
        }
        if (InputField.text != ""){
            input = uname + ": " + InputField.text!
            MessageView.text = MessageView.text + "\(input) \n"
            InputField.text = ""
            connectservice.send(message: encrypt(input: input))
            let strlen:Int = self.MessageView.text.characters.count
            self.MessageView.scrollRangeToVisible(NSMakeRange(strlen-1, 0))
        }
    }
    
    @IBAction func RedBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.red
        self.MessageView.backgroundColor = UIColor.red
        ColourScheme[0] = "0"
    }
    
    @IBAction func YellowBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.yellow
        self.MessageView.backgroundColor = UIColor.yellow
        ColourScheme[0] = "1"
    }
    
    @IBAction func BlackBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.black
        self.MessageView.backgroundColor = UIColor.black
        ColourScheme[0] = "2"
    }
    
    @IBAction func WhiteBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.white
        self.MessageView.backgroundColor = UIColor.white
        ColourScheme[0] = "3"
    }
    
    @IBAction func BlueBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.blue
        self.MessageView.backgroundColor = UIColor.blue
        ColourScheme[0] = "4"
    }
    
    @IBAction func GreenBack(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.green
        self.MessageView.backgroundColor = UIColor.green
        ColourScheme[0] = "5"
    }
    
    @IBAction func RedText(_ sender: UIButton) {
        MessageView.textColor = UIColor.red
        ConnectionDisplay.textColor = UIColor.red
        ColourScheme[1] = "0"
    }
    
    @IBAction func YellowText(_ sender: UIButton) {
        MessageView.textColor = UIColor.yellow
        ConnectionDisplay.textColor = UIColor.yellow
        ColourScheme[1] = "1"
    }
    
    @IBAction func BlackText(_ sender: UIButton) {
        MessageView.textColor = UIColor.black
        ConnectionDisplay.textColor = UIColor.black
        ColourScheme[1] = "2"
    }
    
    @IBAction func WhiteText(_ sender: UIButton) {
        MessageView.textColor = UIColor.white
        ConnectionDisplay.textColor = UIColor.white
        ColourScheme[1] = "3"
    }
    
    @IBAction func BlueText(_ sender: UIButton) {
        MessageView.textColor = UIColor.blue
        ConnectionDisplay.textColor = UIColor.blue
        ColourScheme[1] = "4"
    }
    
    @IBAction func GreenText(_ sender: UIButton) {
        MessageView.textColor = UIColor.green
        ConnectionDisplay.textColor = UIColor.green
        ColourScheme[1] = "5"
    }
    
    
    @IBAction func ClearText(_ sender: UIButton) {
        MessageView.text = ""
    }
    
    
    @IBAction func SendColours(_ sender: UIButton) {
        var outputstring: String = ""
        outputstring += ColourScheme[0]
        outputstring += ColourScheme[1]
        connectservice.send(message: outputstring)
    }
    
    func encrypt( input: String) -> String{
        var output: String = ""
        var inputarray = [Character]()
        for element in input.characters{
            inputarray.append(element)
        }
        let s1encrypt = String(inputarray).utf8.map{ UInt8($0) }
        for element in s1encrypt{
            let meme = element + 1
            s2encrypt.append(meme)
        }
        let encryptdata = Data(bytes: s2encrypt)
        let string = String(data: encryptdata, encoding: .utf8)
        output = string!
        s2encrypt.removeAll()
        return output
    }
    
    func decrypt(input: String) -> String{
        var output = ""
        var inputarray = [Character]()
        for element in input.characters{
            inputarray.append(element)
        }
        let s1decrypt = String(inputarray).utf8.map{ UInt8($0) }
        for element in s1decrypt{
            let meme = element - 1
            s2decrypt.append(meme)
        }
        let decryptdata = Data(bytes: s2decrypt)
        let string = String(data: decryptdata, encoding: .utf8)
        output = string!
        s2decrypt.removeAll()
        return output
    }

}

extension ViewController : ConnectionManagerDelegate {
    
    func connectedDevicesChanged(manager: ConnectionManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            if (connectedDevices.count + 1 < 1){
                self.ConnectionDisplay.text = "Chat room: \(roomname), Members: \(connectedDevices.count + 1)"
            } else {
                self.ConnectionDisplay.text = "Chat room: \(roomname), Members: Just you"
            }
        }
    }
    
    func messagerecieved(manager: ConnectionManager, messagestring: String) {
        OperationQueue.main.addOperation {
            var inputarray = [Character]()
            for element in messagestring.characters{
                inputarray.append(element)
            }
            if (inputarray.count == 2){
                switch inputarray[0]{
                case "0":
                    self.view.backgroundColor = UIColor.red
                    self.MessageView.backgroundColor = UIColor.red
                case "1":
                    self.view.backgroundColor = UIColor.yellow
                    self.MessageView.backgroundColor = UIColor.yellow
                case "2":
                    self.view.backgroundColor = UIColor.black
                    self.MessageView.backgroundColor = UIColor.black
                case "3":
                    self.view.backgroundColor = UIColor.white
                    self.MessageView.backgroundColor = UIColor.white
                case "4":
                    self.view.backgroundColor = UIColor.blue
                    self.MessageView.backgroundColor = UIColor.blue
                case "5":
                    self.view.backgroundColor = UIColor.green
                    self.MessageView.backgroundColor = UIColor.green
                default: break
                }
                
                switch inputarray[1]{
                case "0":
                    self.MessageView.textColor = UIColor.red
                case "1":
                    self.MessageView.textColor = UIColor.yellow
                case "2":
                    self.MessageView.textColor = UIColor.black
                case "3":
                    self.MessageView.textColor = UIColor.white
                case "4":
                    self.MessageView.textColor = UIColor.blue
                case "5":
                    self.MessageView.textColor = UIColor.green
                default: break
                }
            } else{
                self.MessageView.text = self.MessageView.text + "\t" + self.decrypt(input: messagestring) + "\n"
                let strlen:Int = self.MessageView.text.characters.count
                self.MessageView.scrollRangeToVisible(NSMakeRange(strlen-1, 0))
            }
        }
    }
}

