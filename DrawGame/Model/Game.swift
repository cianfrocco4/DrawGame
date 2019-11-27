//
//  Game.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 11/23/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import Foundation

class Game {
    
    enum Turn {
        case PlayerOne
        case PlayerTwo
    }
    
    private var m_PlayerOne : Player;
    private var m_PlayerTwo : Player;
    private var m_CurrTurn : Turn;
    private var m_Item : Item;

    init(acPlayerOne : Player, acPlayerTwo : Player)
    {
        self.m_PlayerOne = acPlayerOne;
        self.m_PlayerTwo = acPlayerTwo;
        self.m_CurrTurn = Turn.PlayerOne;
        self.m_Item = Item();
    }
    
    func getPlayerOneScore() -> Int
    {
        return m_PlayerOne.getScore();
    }
    
    func getPlayerTwoScore() -> Int
    {
        return m_PlayerTwo.getScore();
    }
    
    func playerOneScored()
    {
        m_PlayerOne.incrementScore();
    }
    
    func playerTwoScored()
    {
        m_PlayerTwo.incrementScore();
    }
    
    func getPlayerOneName() -> String
    {
        return m_PlayerOne.getName();
    }
    
    func getPlayerTwoName() -> String
    {
        return m_PlayerTwo.getName();
    }
    
    func getCurrentItem() -> String
    {
        return m_Item.getName();
    }
    
    func getCurrentItemList() -> [String]
    {
        return m_Item.getNameList();
    }
    
    func getCurrentTurn() -> Turn
    {
        return m_CurrTurn;
    }
    
    func changeTurn()
    {
        if m_CurrTurn == Turn.PlayerOne
        {
            m_CurrTurn = Turn.PlayerTwo
        }
        else
        {
           m_CurrTurn = Turn.PlayerOne
        }
        m_Item = Item();
    }
    
    func checkGameOver() -> Bool
    {
        return (m_PlayerOne.getScore() >= 3) || (m_PlayerTwo.getScore() >= 3);
    }
    
    func getWinner() -> Player
    {
        if m_PlayerOne.getScore() >= 3 {
            return m_PlayerOne;
        }
        else
        {
            return m_PlayerTwo;
        }
    }
}
