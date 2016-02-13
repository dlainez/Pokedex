//
//  ViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 12/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var Attack1: UIButton!
    @IBOutlet weak var Attack2: UIButton!
    
    func SetButton(setEnable : Bool) {
        Attack1.enabled = setEnable
        Attack2.enabled = setEnable
    }
    var At : Bool!
    func MyAnimationImage(Ata : Int) {
        
        
        var sec : String
        var nAta = "Idle_00"
        var secFor = 41
        var animationImages = [UIImage]()
    
        if Ata == 1 {
            nAta = "Attack1_00"
            secFor = 51
        }
        if Ata == 2 {
            nAta = "Attack_200"
            secFor = 66
        }
        for i in 1 ... secFor {
            sec = String(i)
            if i < 10 {
                sec = "0\(i)"
            }
            let currentImage = UIImage(named : nAta + String(sec) + ".png")
            if let currentImage = currentImage {
                animationImages.append(currentImage)
            }
        }
        
        //Attack1.titleLabel.text = "Repose"
        PokemonImageView.animationImages = animationImages
        PokemonImageView.animationDuration = 1.5
        PokemonImageView.startAnimating()
    }
    func MyReset() {
        At = true
        PokemonImageView.stopAnimating()
        MyAnimationImage(0)
        SetButton(true)
        Attack1.setTitle("Animation A",forState: UIControlState.Normal)
        Attack2.setTitle("Animation B",forState: UIControlState.Normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        PokemonImageView.image = UIImage(named : "Idle_0001.png")
        
        At = true
        MyAnimationImage(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK
    @IBAction func Attack2Actiom(sender: UIButton) {
        PokemonImageView.stopAnimating()
        if (At == true) {
            At = false
            SetButton(false)
            sender.setTitle("Attacking", forState: UIControlState.Normal)
            MyAnimationImage(1)
        }
        /*else {
            At = true
            MyAnimationImage(0)
            SetButton(true)
        }*/
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("MyReset"), userInfo: nil, repeats: false)
        
    }
    @IBAction func Attack1Action(sender: UIButton) {
        PokemonImageView.stopAnimating()
        if (At == true) {
            At = false
            SetButton(false)
            sender.setTitle("Attacking", forState: UIControlState.Normal)
            MyAnimationImage(2)
        }
        /*else
        {
            At = true
            MyAnimationImage(0)
            SetButton(true)
        }*/
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("MyReset"), userInfo: nil, repeats: false)
    }


}

