//
//  ViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 12/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditPokemonDelegate {
    
    var TempPokemonName : String = "charmander"
    var myPokemon : OwnedPokemon!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var attack1: UIButton!
    @IBOutlet weak var attack2: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //View configs
        pokemonImageView.image = myPokemon.image
        captionTextView.text = myPokemon.caption
        self.title = myPokemon.customName
        returnToIdle ()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButtons(enable enable : Bool) {
        
        if enable {
            attack1.setTitle(myPokemon.attack1.name, forState: UIControlState.Normal)
            attack2.setTitle(myPokemon.attack2.name, forState: UIControlState.Normal)
        }
        
        attack1.enabled = enable
        attack2.enabled = enable
    }
    
    func setAnimation (animationImages : [UIImage], animationKeyFrame : PokemonAnimationFrame?) {
        
        if let animationKeyFrame = animationKeyFrame {
            
            pokemonImageView.stopAnimating()
            
            pokemonImageView.animationImages = animationImages
            pokemonImageView.animationDuration = animationKeyFrame.duration
            pokemonImageView.animationRepeatCount = animationKeyFrame.repeatCount
            pokemonImageView.startAnimating()
            
        }
        
    }
    
    func returnToIdle () {
        myPokemon.setAnimation("idle") { (animationImages, animationKeyFrame) -> Void in
            self.setAnimation(animationImages, animationKeyFrame: animationKeyFrame)
        }
        setButtons(enable: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEditSegue" {
            if let vc = segue.destinationViewController as? EditPokemonViewController {
                vc.delegate = self
                vc.defaultText = myPokemon.customName
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func attackAction(sender: UIButton) {
        setButtons(enable: false)
        sender.setTitle("Attacking", forState: UIControlState.Normal)
    }
    
    @IBAction func attack1Action(sender: UIButton) {
        let duration = 1.6
        
        myPokemon.setAnimation("attack1") { (animationImages, animationKeyFrame) -> Void in
            self.setAnimation(animationImages, animationKeyFrame: animationKeyFrame)
        }
        
        NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("returnToIdle"), userInfo: nil, repeats: false)
    }
    
    @IBAction func attack2Action(sender: UIButton) {
        let duration = 1.2
        
        myPokemon.setAnimation("attack2") { (animationImages, animationKeyFrame) -> Void in
            self.setAnimation(animationImages, animationKeyFrame: animationKeyFrame)
        }
        
        NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("returnToIdle"), userInfo: nil, repeats: false)
    }
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    //MARK - Action Protocolo
    func didChangeName(newName : String) {
        myPokemon.customName = newName
        self.title = myPokemon.customName
    }
}
