//
//  Player.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 11/23/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import Foundation

class Player
{
    private var m_Name : String;
    private var m_Score : Int;
    
    init(anName : String) {
        self.m_Name = anName;
        self.m_Score = 0;
    }
    
    func getName() -> String
    {
        return self.m_Name;
    }
    
    func getScore() -> Int
    {
        return self.m_Score;
    }
    
    func incrementScore()
    {
        self.m_Score += 1;
    }
}
