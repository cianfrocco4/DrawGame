//
//  GameVC.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 9/22/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var currentTurn: UILabel!
    
    var m_gameMgr : GameManager?
    var m_guess : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.m_gameMgr != nil
        {
            if m_guess != nil
            {
                processGuess();
                m_guess = nil;
                
                if m_gameMgr!.checkGameOver()
                {
                    // segue to the game over view
                }
            }
            
            playerLabel.text = "\(m_gameMgr!.getPlayerOneName()) vs \(m_gameMgr!.getPlayerTwoName())"
            playerOneScore.text = "Player 1: \(self.m_gameMgr!.getPlayerOneScore())"
            playerTwoScore.text = "Player 2: \(self.m_gameMgr!.getPlayerTwoScore())"
            var currTurn = ""
            if self.m_gameMgr?.getCurrentTurn() == Game.Turn.PlayerOne {
                currTurn = m_gameMgr!.getPlayerOneName()
            }
            else {
                currTurn = m_gameMgr!.getPlayerTwoName()
            }
            currentTurn.text = "It's \(currTurn)'s turn to draw!"
        }
    }
    
    @IBAction func didBeginDrawing(_ sender: Any) {
        performSegue(withIdentifier: "GameToDraw", sender: self)
    }
    @IBAction func didQuit(_ sender: Any) {
        performSegue(withIdentifier: "GameToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DrawVC
        {
            let lcDrawVC = segue.destination as! DrawVC;
            lcDrawVC.m_gameMgr = self.m_gameMgr;
        }
    }
    
    private func processGuess()
    {
        m_gameMgr!.guessMade(acGuess: m_guess!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
