//
//  ViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 12/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myPokemon : OwnedPokemon!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var attack1: UIButton!
    @IBOutlet weak var attack2: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myPokemon = OwnedPokemon(name: "charmander", type: PokemonType.Grass, owner: "eduardo")
        myPokemon.caption = "Charmander es un Pokémon de tipo fuego introducido en la primera generación. Es uno de los Pokémon iniciales que pueden elegir los entrenadores que empiezan su aventura en la región Kanto, excepto en Pokémon Amarillo."
        myPokemon.isMine = true
        myPokemon.animationsFrames["idle"] = PokemonAnimationFrame(maxFrames : 41, duration : 1.0, repeatCount : 0)
        myPokemon.animationsFrames["attack1"] = PokemonAnimationFrame(maxFrames : 51, duration : 1.2, repeatCount : 1)
        myPokemon.animationsFrames["attack2"] = PokemonAnimationFrame(maxFrames : 66, duration : 1.4, repeatCount : 1)
        
        pokemonImageView.image = myPokemon.image
        
        let tackle = Attack(name: "Tackle", power: 5)
        let growl = Attack(name: "Growl")
        
        myPokemon.attack1 = tackle
        myPokemon.attack2 = growl
        
        //View configs
        
        captionTextView.text = myPokemon.caption
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
}
