//
//  ViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 12/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var MyPokemon : OwnedPokemon!
    
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var Attack1: UIButton!
    @IBOutlet weak var Attack2: UIButton!
    
    func SetButton(setEnable : Bool) {
        Attack1.enabled = setEnable
        Attack2.enabled = setEnable
    }
    
    var At : Bool!
    func MyAnimationImage(animationImages : [UIImage], animationKeyFrame : PokemonAnimationFrame?) {
        
        if let animationKeyFrame = animationKeyFrame {
            
            PokemonImageView.stopAnimating()
        
            PokemonImageView.animationImages = animationImages
            PokemonImageView.animationDuration = animationKeyFrame.duration
            PokemonImageView.animationRepeatCount = animationKeyFrame.repeatCount
        
            PokemonImageView.startAnimating()
            
        }
    }
    func MyReset() {
        At = true
        
        MyPokemon.MyAnimationImage("Idle") { (animationImages, animationKeyFrame) -> Void in
            self.MyAnimationImage(animationImages, animationKeyFrame: animationKeyFrame)
        }
        
        SetButton(true)
        Attack1.setTitle("Animation A",forState: UIControlState.Normal)
        Attack2.setTitle("Animation B",forState: UIControlState.Normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MyPokemon = OwnedPokemon(name: "bulbasour", type: PokemonType.Grass, owner: "DLainez")
        
        MyPokemon.isMine = true
        
        MyPokemon.animationFrame["Idle"] = PokemonAnimationFrame(Ata: 0, duration: 0.9, repeatCount: 0)
        MyPokemon.animationFrame["AttackOne"] = PokemonAnimationFrame(Ata: 1, duration: 1.35, repeatCount: 1)
        MyPokemon.animationFrame["AttackTwo"] = PokemonAnimationFrame(Ata: 2, duration: 2.15, repeatCount: 1)
        
        PokemonImageView.image = MyPokemon.image
        
        MyReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK
    @IBAction func Attack2Actiom(sender: UIButton) {
        if (At == true) {
            At = false
            SetButton(false)
            sender.setTitle("Attacking", forState: UIControlState.Normal)
            
            MyPokemon.MyAnimationImage("AttackOne") { (animationImages, animationKeyFrame) -> Void in
                self.MyAnimationImage(animationImages, animationKeyFrame: animationKeyFrame)
            }
            
        }
        NSTimer.scheduledTimerWithTimeInterval(2.70, target: self, selector: Selector("MyReset"), userInfo: nil, repeats: false)
    }
    @IBAction func Attack1Action(sender: UIButton) {
        if (At == true) {
            At = false
            SetButton(false)
            sender.setTitle("Attacking", forState: UIControlState.Normal)
            
            MyPokemon.MyAnimationImage("AttackTwo") { (animationImages, animationKeyFrame) -> Void in
                self.MyAnimationImage(animationImages, animationKeyFrame: animationKeyFrame)
            }
            
        }
        NSTimer.scheduledTimerWithTimeInterval(2.70, target: self, selector: Selector("MyReset"), userInfo: nil, repeats: false)
    }
}

