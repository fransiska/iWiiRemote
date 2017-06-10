//
//  ViewController.swift
//  tcpip
//
//  Created by fransiska on 2017/06/09.
//  Copyright © 2017年 fransiska. All rights reserved.
//

import UIKit
import CoreMotion
import os.log


class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    let motionManager = CMMotionManager()
    
    var sock:Int32 = -1
    
    //MARK: segue
    @IBAction func unwindToMainView(sender: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let mouse = segue.destination as? MouseViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        mouse.sock = sock
    }

    
    //MARK: Default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ipTextField.delegate = self
        portTextField.delegate = self
        
        // Touch to hide keyboard
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Hide keyboard by return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        ipTextField.resignFirstResponder()
        portTextField.resignFirstResponder()
        return true;
    }
    
    // Hide keyboard by tap
    func didTapView() {
        self.view.endEditing(true)
    }
    
    // Disable button once connected
    func updateConnectButton(connected: Bool) {
        connectButton.isEnabled = !connected
    }
    
    func degrees(radians:Double) -> Double {
        return 180 / .pi * radians
    }

    // Handle accelerometer updates
    func sendMessage(deviceMotion:CMDeviceMotion) {
        let attitude = deviceMotion.attitude
        let roll = degrees(radians: attitude.roll)
        let pitch = degrees(radians: attitude.pitch)
        tcpipSocket_send(sock, "r:\(roll) p:\(pitch);")
    }
    
    //MARK: Actions
    @IBAction func connectSocket(_ sender: UIButton) {
        sock = tcpipSocket_connect(ipTextField.text,Int32(portTextField.text!)!)
        if(sock > 0) {
            updateConnectButton(connected: true)
            
            // Accelerometer data
            // get data of accelerometer async
            if motionManager.isDeviceMotionAvailable {
                motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
                    (deviceMotion, error) -> Void in
                    if(error == nil) {
                        self.sendMessage(deviceMotion: deviceMotion!)
                    } else {
                        os_log("Error in device motion updates", type: .debug)
                    }
                })
            }
        }
    }
        
    @IBAction func closeSocket(_ sender: UIButton) {
        motionManager.stopDeviceMotionUpdates()
        tcpipSocket_close(sock)
        sock = -1
        updateConnectButton(connected: false)
    }
}

