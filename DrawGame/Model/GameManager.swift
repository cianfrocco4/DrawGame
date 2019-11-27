//
//  GameManager.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 9/22/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import Foundation

class GameManager {
    private var m_game : Game
    
    init(acPlayerOne : Player, acPlayerTwo : Player)
    {
        self.m_game = Game(acPlayerOne: acPlayerOne, acPlayerTwo: acPlayerTwo);
    }
    
    func getCurrentTurn() -> Game.Turn {
        return self.m_game.getCurrentTurn();
    }
    
    func getPlayerOneScore() -> Int {
        return self.m_game.getPlayerOneScore();
    }
    
    func getPlayerTwoScore() -> Int {
        return self.m_game.getPlayerTwoScore();
    }
    
    func getPlayerOneName() -> String
    {
        return self.m_game.getPlayerOneName();
    }
    
    func getPlayerTwoName() -> String
    {
        return self.m_game.getPlayerTwoName();
    }
    
    func getCurrentItem() -> String
    {
        return m_game.getCurrentItem();
    }
    
    func getCurrentItemList() -> [String]
    {
        return m_game.getCurrentItemList();
    }
    func guessMade(acGuess : String)
    {
       if acGuess == self.getCurrentItem()
       {
            // player made the correct guess!
            if getCurrentTurn() == Game.Turn.PlayerOne
            {
                m_game.playerTwoScored();
            }
            else
            {
                m_game.playerOneScored();
            }
        }
        m_game.changeTurn();
    }
    
    func checkGameOver() -> Bool
    {
        return m_game.checkGameOver();
    }
}
