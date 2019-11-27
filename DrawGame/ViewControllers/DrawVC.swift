//
//  DrawVC.swift
//  DrawGame
//
//  Created by Anthony Cianfrocco on 9/22/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class DrawVC: UIViewController
{

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var colorSlider: UISlider!
    
    var counter = 5;
    
    var m_gameMgr : GameManager?
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var image : UIImage?
    var m_timer : Timer?;

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if m_gameMgr != nil
        {
            setupTimerLabel();
            setupItemLabel();
            setupColorSlider();
            mainImageView.isUserInteractionEnabled = true;
            tempImageView.isUserInteractionEnabled = true;
            colorSlider.isUserInteractionEnabled = true;

            m_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateCounter()
    {
        if (counter >= 0)
        {
            timerLabel.text = String(counter);
            counter -= 1;
        }
        else if (counter == -1)
        {
            counter -= 1;
            print("Turning off ui. Saving image");
            self.image = mainImageView.image;
            mainImageView.isUserInteractionEnabled = false;
            tempImageView.isUserInteractionEnabled = false;
            colorSlider.isUserInteractionEnabled = false;
        }
        else
        {
            m_timer!.invalidate()
            performSegue(withIdentifier: "DrawToGuess", sender: self);
        }
    }
    
    func setupTimerLabel()
    {
        timerLabel.numberOfLines = 1;
        timerLabel.textAlignment = .center;
        timerLabel.adjustsFontSizeToFitWidth = true;
        timerLabel.font = timerLabel.font.withSize(40);
        timerLabel.text = String(counter);
    }
    
    func setupItemLabel()
    {
        itemLabel.numberOfLines = 1;
        itemLabel.textAlignment = .center;
        itemLabel.adjustsFontSizeToFitWidth = true;
        itemLabel.font = itemLabel.font.withSize(30);
        itemLabel.text = "Draw: " + (self.m_gameMgr!.getCurrentItem());
        itemLabel.highlightedTextColor = UIColor.yellow;
        itemLabel.isHighlighted = true;
    }
    
    func setupColorSlider()
    {
        colorSlider.minimumValue = 0;
        colorSlider.maximumValue = 1;
        colorSlider.value = 0;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (mainImageView.isUserInteractionEnabled)
        {
            guard let touch = touches.first else {
                return
            }
            swiped = false
            lastPoint = touch.location(in: mainImageView)
        }
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint)
    {
        // 1
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: mainImageView.bounds)
        
        // 2
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        // 3
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        // 4
        context.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (mainImageView.isUserInteractionEnabled)
        {
            guard let touch = touches.first else {
                return
            }
            
            // 6
            swiped = true
            let currentPoint = touch.location(in: mainImageView)
            drawLine(from: lastPoint, to: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (mainImageView.isUserInteractionEnabled)
        {
            if !swiped
            {
                // draw a single point
                drawLine(from: lastPoint, to: lastPoint)
            }
            
            // Merge tempImageView into mainImageView
            UIGraphicsBeginImageContext(mainImageView.frame.size)
            mainImageView.image?.draw(in: mainImageView.bounds, blendMode: .normal, alpha: 1.0)
            tempImageView?.image?.draw(in: mainImageView.bounds, blendMode: .normal, alpha: opacity)
            mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            tempImageView.image = nil
        }
    }

    @IBAction func colorSliderValueChanged(_ sender: Any)
    {
        let value = colorSlider.value;
        if (value < 0.33)
        {
            colorSlider.value = 0;
            color = UIColor.black;
        }
        else if (value < 0.66)
        {
            colorSlider.value = 0.5;
            color = UIColor.red;
        }
        else
        {
            colorSlider.value = 1.0;
            color = UIColor.blue;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GuessVC
        {
            let guessVC = segue.destination as! GuessVC;
            if (self.mainImageView != nil)
            {
                print("setting self.mainImageView to guessVC.mainImageView");
                guessVC.image = self.mainImageView.image;
                guessVC.m_gameMgr = self.m_gameMgr;
            }
            else
            {
                print("this.image is nil");
            }
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

