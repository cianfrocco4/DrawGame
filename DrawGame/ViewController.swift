//
//  ViewController.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 9/21/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var beginGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Adjust text to fit in button
        self.beginGameButton.titleLabel?.minimumScaleFactor = 0.5
        self.beginGameButton.titleLabel?.numberOfLines = 1
        self.beginGameButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    @IBAction func didGameBegin(_ sender: Any) {
        // check that both player names have been entered
        if !(playerOneName.text?.isEmpty ?? true) {
            if !(playerTwoName.text?.isEmpty ?? true) {
                errorMessage.text = ""
                print("Transtioning from Home to Game")
                performSegue(withIdentifier: "HomeToGame", sender: self)
            }
            else {
                setErrorMessage(msg: "Please enter Player 2's name")
            }
        }
        else {
            setErrorMessage(msg: "Please enter Player 1's name")
        }
    }
    
    private func setErrorMessage(msg : String) {
        self.errorMessage.text = msg
        self.errorMessage.minimumScaleFactor = 0.5
        self.errorMessage.numberOfLines = 2
        self.errorMessage.adjustsFontSizeToFitWidth = true
    }
    

}

