//
//  ViewController.swift
//  chatdirect
//
//  Created by SID SHARDANAND on 12/05/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {
    
    let connectservice = ConnectionManager()
    var input: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        connectservice.delegate = self
        InputField.becomeFirstResponder()
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
        input = UIDevice.current.name + ": " + InputField.text!
        MessageView.text = MessageView.text + "\n \(input)"
        InputField.text = ""
        connectservice.send(message: input)
    }

}

extension ViewController : ConnectionManagerDelegate {
    
    func connectedDevicesChanged(manager: ConnectionManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            if(connectedDevices != [""]){
                self.ConnectionDisplay.text = "Partners: \(connectedDevices)"
            } else {
            self.ConnectionDisplay.text = "Partners: None"
            }
        }
    }
    
    func messagerecieved(manager: ConnectionManager, messagestring: String) {
        OperationQueue.main.addOperation {
            self.MessageView.text = self.MessageView.text + "\n \(self.connectservice)"
        }
    }
}

