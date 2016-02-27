//
//  PokemonsListViewController.swift
//  Pokedex
//
//  Created by CFPAPP on 19/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

class PokemonsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InsertPokemonDelegate {
    
    var myPokemons = [OwnedPokemon]()
    var selectedPokemonIndex = 0
    var refreshControl : UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshTable:"), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
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
    
    func refreshTable(sender : AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
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
        if segue.identifier == "InsertPokemonShowSegue" {
            if let vc = segue.destinationViewController as? InsertPokemonViewController {
                vc.insertDelegate = self
            }
        }
    }
    
    
    @IBAction func editAction(sender: AnyObject) {
        tableView.editing = !tableView.editing
        editBarButton.title = tableView.editing ? "Done" : "Edit"
        editBarButton.style = tableView.editing ? UIBarButtonItemStyle.Done : UIBarButtonItemStyle.Plain
    }
    
    // MARK: - Actions
    
    @IBAction func showPokemonDetailAction(sender: AnyObject) {
        if let button = sender as? UIButton {
            selectedPokemonIndex = button.tag - 1
            self.performSegueWithIdentifier("ShowPokemonDetailSegue", sender: self)
        }
    }
    
    //MARK - tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPokemons.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            myPokemons.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.row != destinationIndexPath.row {
            swap(&myPokemons[sourceIndexPath.row], &myPokemons[destinationIndexPath.row])
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPokemonIndex = indexPath.row
        self.performSegueWithIdentifier("ShowPokemonDetailSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell")!
        
        let pokemonCell = myPokemons[indexPath.row]
        
        if let cell = cell as? PokemonTableViewCell {
            cell.pokemonImageView.image = pokemonCell.image
            cell.pokemonLabel.text = pokemonCell.customName
        }
        
        return cell
    }
    
    //MARK: - Actions
    @IBAction func insertAction(sender: AnyObject) {
        addPokemon("squirtle", type: PokemonType.Water,
            caption: "Squirtle es un Pokémon de tipo agua introducido en la primera generación. Es uno de los Pokémon iniciales que pueden elegir los entrenadores que empiezan su aventura en la región Kanto, excepto en Pokémon Amarillo.",
            idleAnimation :  PokemonAnimationFrame(maxFrames : 29, duration : 1.0, repeatCount : 0),
            attack1Animation:  PokemonAnimationFrame(maxFrames : 53, duration : 1.2, repeatCount : 1),
            attack2Animation: PokemonAnimationFrame(maxFrames : 66, duration : 1.4, repeatCount : 1),
            attack1:  Attack(name: "Tackle", power: 5),
            attack2:  Attack(name: "Growl") )
        
        tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: myPokemons.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    //MARK - Action Protocolo
    func AddPokemonTableView(NamePokemon : String) {
        
        let numPokemons = myPokemons.count
        
            //if NamePokemon == "squirtle" {
                addPokemon(NamePokemon, type: PokemonType.Water,
                    caption: "Squirtle es un Pokémon de tipo agua introducido en la primera generación. Es uno de los Pokémon iniciales que pueden elegir los entrenadores que empiezan su aventura en la región Kanto, excepto en Pokémon Amarillo.",
                    idleAnimation :  PokemonAnimationFrame(maxFrames : 29, duration : 1.0, repeatCount : 0),
                    attack1Animation:  PokemonAnimationFrame(maxFrames : 53, duration : 1.2, repeatCount : 1),
                    attack2Animation: PokemonAnimationFrame(maxFrames : 66, duration : 1.4, repeatCount : 1),
                    attack1:  Attack(name: "Tackle", power: 5),
                    attack2:  Attack(name: "Growl") )
            //}
            
        if numPokemons != myPokemons.count {
            tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: myPokemons.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
        }
        
    }
    
    
}
