//
//  PokemonsListViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 19/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

class PokemonsListViewController: UIViewController {
    
    var myPokemons = [OwnedPokemon]()
    var selectedPokemonIndex = 0
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addPokemon("bulbasaur", type: PokemonType.Grass,
            caption: "Bulbasaur es un Pokémon tipo planta/veneno introducido en la primera generación. Es uno de los Pokémon iniciales que pueden elegir los entrenadores que empiezan su aventura en la región Kanto, excepto en Pokémon Amarillo. Destaca por ser el primer Pokémon de la Pokédex Nacional.",
            idleAnimation :  PokemonAnimationFrame(maxFrames : 41, duration : 1.0, repeatCount : 0),
            attack1Animation:  PokemonAnimationFrame(maxFrames : 51, duration : 1.2, repeatCount : 1),
            attack2Animation: PokemonAnimationFrame(maxFrames : 66, duration : 1.4, repeatCount : 1),
            attack1:  Attack(name: "Scratch", power: 5),
            attack2:  Attack(name: "Growl") )
        
        
        addPokemon("charmander", type: PokemonType.Fire,
            caption: "Charmander es un Pokémon de tipo fuego introducido en la primera generación. Es uno de los Pokémon iniciales que pueden elegir los entrenadores que empiezan su aventura en la región Kanto, excepto en Pokémon Amarillo.",
            idleAnimation :  PokemonAnimationFrame(maxFrames : 69, duration : 1.0, repeatCount : 0),
            attack1Animation:  PokemonAnimationFrame(maxFrames : 66, duration : 1.2, repeatCount : 1),
            attack2Animation: PokemonAnimationFrame(maxFrames : 67, duration : 1.4, repeatCount : 1),
            attack1:  Attack(name: "Tackle", power: 5),
            attack2:  Attack(name: "Growl") )
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Will Appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Did Appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("Will Disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("Did Disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPokemon(name: String, type: PokemonType, caption : String = "", idleAnimation : PokemonAnimationFrame, attack1Animation : PokemonAnimationFrame, attack2Animation : PokemonAnimationFrame, attack1 : Attack, attack2 : Attack  ) {
        
        let pokemon = OwnedPokemon(name: name, type: type, owner: "dlainezm")
        
        pokemon.caption = caption
        pokemon.isMine = true
        
        pokemon.animationsFrames["idle"] = idleAnimation
        pokemon.animationsFrames["attack1"] = attack1Animation
        pokemon.animationsFrames["attack2"] = attack2Animation
        
        
        let tackle = attack1
        let growl = attack2
        
        pokemon.attack1 = tackle
        pokemon.attack2 = growl
        
        
        myPokemons.append(pokemon)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPokemonDetailSegue" {
            if let vc = segue.destinationViewController as? ViewController {
                vc.myPokemon = myPokemons[selectedPokemonIndex]
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func showPokemonDetailAction(sender: AnyObject) {
        if let button = sender as? UIButton {
            selectedPokemonIndex = button.tag - 1
            self.performSegueWithIdentifier("ShowPokemonDetailSegue", sender: self)
        }
    }
    
}
