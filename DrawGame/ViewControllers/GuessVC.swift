//
//  GuessVC.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 11/22/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class GuessVC: UIViewController {
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!;
    var image : UIImage?
    var selectedButton : String?
    var m_gameMgr : GameManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.m_gameMgr != nil
        {
            if image != nil
            {
                mainImageView.image = self.image;
            }
            
            setupButtons();
        }
        // Do any additional setup after loading the view.
    }
    
    func setupButtons()
    {
        let lnRandIdx = Int.random(in: 1 ..< 5 );
        
        switch lnRandIdx {
        case 1:
            buttonOne.setTitle(self.m_gameMgr!.getCurrentItem(), for: .normal);
            buttonTwo.setTitle(self.m_gameMgr!.getCurrentItemList()[0], for: .normal);
            buttonThree.setTitle(self.m_gameMgr!.getCurrentItemList()[1], for: .normal);
            buttonFour.setTitle(self.m_gameMgr!.getCurrentItemList()[2], for: .normal);
        case 2:
            buttonOne.setTitle(self.m_gameMgr!.getCurrentItemList()[0], for: .normal);
            buttonTwo.setTitle(self.m_gameMgr!.getCurrentItem(), for: .normal);
            buttonThree.setTitle(self.m_gameMgr!.getCurrentItemList()[1], for: .normal);
            buttonFour.setTitle(self.m_gameMgr!.getCurrentItemList()[2], for: .normal);
        case 3:
            buttonOne.setTitle(self.m_gameMgr!.getCurrentItemList()[0], for: .normal);
            buttonTwo.setTitle(self.m_gameMgr!.getCurrentItemList()[1], for: .normal);
            buttonThree.setTitle(self.m_gameMgr!.getCurrentItem(), for: .normal);
            buttonFour.setTitle(self.m_gameMgr!.getCurrentItemList()[2], for: .normal);
        case 4:
            buttonOne.setTitle(self.m_gameMgr!.getCurrentItemList()[0], for: .normal);
            buttonTwo.setTitle(self.m_gameMgr!.getCurrentItemList()[1], for: .normal);
            buttonThree.setTitle(self.m_gameMgr!.getCurrentItemList()[2], for: .normal);
            buttonFour.setTitle(self.m_gameMgr!.getCurrentItem(), for: .normal);
        default:
            print("Error");
        }
        
        buttonOne.titleLabel?.adjustsFontSizeToFitWidth = true;
        buttonTwo.titleLabel?.adjustsFontSizeToFitWidth = true;
        buttonThree.titleLabel?.adjustsFontSizeToFitWidth = true;
        buttonFour.titleLabel?.adjustsFontSizeToFitWidth = true;

    }
    
    @IBAction func buttonOneSelected(_ sender: Any) {
        selectedButton = buttonOne.titleLabel?.text;
        performSegue(withIdentifier: "GuessToGame", sender: self)
    }
    @IBAction func buttonTwoSelected(_ sender: Any) {
        selectedButton = buttonTwo.titleLabel?.text;
        performSegue(withIdentifier: "GuessToGame", sender: self)
    }
    @IBAction func buttonThreeSelected(_ sender: Any) {
        selectedButton = buttonThree.titleLabel?.text;
        performSegue(withIdentifier: "GuessToGame", sender: self)
    }
    @IBAction func buttonFourSelected(_ sender: Any) {
        selectedButton = buttonFour.titleLabel?.text;
        performSegue(withIdentifier: "GuessToGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameVC
        {
            let gameVC = segue.destination as! GameVC;
            gameVC.m_guess = self.selectedButton;
            gameVC.m_gameMgr = self.m_gameMgr;
        }
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
