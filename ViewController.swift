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



class ViewController: UIViewController {
    
    let connectservice = ConnectionManager()
    var input: String = ""
    var uname: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        connectservice.delegate = self
        InputField.becomeFirstResponder()
        self.MessageView.layoutManager.allowsNonContiguousLayout = false
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
        let data = Data(bytes: s2encrypt)
        let string = String(data: data, encoding: .utf8)
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
        let data = Data(bytes: s2decrypt)
        let string = String(data: data, encoding: .utf8)
        output = string!
        s2decrypt.removeAll()
        return output
    }

}

extension ViewController : ConnectionManagerDelegate {
    
    func connectedDevicesChanged(manager: ConnectionManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            if(connectedDevices != [""]){
                self.ConnectionDisplay.text = "Members: You, \(connectedDevices)"
            } else {
            self.ConnectionDisplay.text = "Membera: Just you"
            }
        }
    }
    
    func messagerecieved(manager: ConnectionManager, messagestring: String) {
        OperationQueue.main.addOperation {
            self.MessageView.text = self.MessageView.text + self.decrypt(input: messagestring)
        }
    }
}

