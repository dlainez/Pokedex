//
//  Pokemon.swift
//  Pokedex
//
//  Created by CFPAPP on 13/2/16.
//  Copyright © 2016 Nintendo. All rights reserved.
//

import UIKit

enum PokemonType {
    case Grass, Water, Fire, Electric
}

struct PokemonAnimationFrame {
    var maxFrames : Int
    var duration : Double
    var repeatCount : Int
}

let hpPerLevel = 10

class Pokemon : NSObject {
    
    var name : String
    var type : PokemonType
    var image : UIImage!
    var caption = ""
    var animationsFrames = [String : PokemonAnimationFrame]()
    var level = 5 {
        didSet {
            maxhealth = level * hpPerLevel
        }
    }
    var health = 0 {
        didSet {
            if health > maxhealth {
                health = maxhealth
            }
        }
    }
    var maxhealth = 0
    var attack1 : Attack!
    var attack2 : Attack!
    
    //MARK: - Inits
    init (name : String, type : PokemonType) {
        self.name = name
        self.type = type
        
        image = UIImage(named: "\(name)_idle_0001")
        maxhealth = level * hpPerLevel
        health = maxhealth
    }
    
    //MARK: - Methods
    
    func levelUp () {
        level++
        health = health + 20
        
    }
    
    func attack (numAtaque : Int) -> Double {
        if numAtaque == 1 {
            print(name + " ataca con " +  attack1.name)
            return attack1.power
        }
        
        if numAtaque == 2 {
            print(name + " ataca con " +  attack2.name)
            return attack2.power
        }
        
        return 0
    }
    
    func setAnimation (key : String, completion : (animationImages : [UIImage], animationKeyFrame : PokemonAnimationFrame? ) -> Void ) {
        
        var animationImages = [UIImage]()
        var animationKeyFrame : PokemonAnimationFrame?
        
        if let keyFrame = animationsFrames[key] {
            
            animationKeyFrame = keyFrame
            
            for i in 1 ... keyFrame.maxFrames {
                let extraZero = i < 10 ? "0" : ""
                if let currentImage = UIImage(named: "\(name)_\(key)_00\(extraZero)\(i)") {
                    animationImages.append(currentImage)
                }
            }
        }
        completion(animationImages: animationImages, animationKeyFrame: animationKeyFrame)
    }
}

class OwnedPokemon: Pokemon {
    
    var owner : String
    var customName : String?
    var isMine = false {
        didSet {
            image = UIImage(CGImage: image.CGImage!, scale: CGFloat(1.0), orientation: UIImageOrientation.UpMirrored)
        }
    }
    init(name: String, type: PokemonType, owner : String) {
        self.owner = owner
        self.customName = name.capitalizedString
        super.init(name: name, type: type)
    }
}
