//
//  Pokemon.swift
//  Pokedex
//
//  Created by CFPAPP on 13/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

    enum PokemonType {
        case Grass, Water, Fire, Electric
    }

    struct PokemonAnimationFrame {
        var Ata : Int
        var duration : Double
        var repeatCount : Int
    }

    let hpPerLevel = 10
    
    class Pokemon : NSObject {
        
        var animationFrame = [String : PokemonAnimationFrame]()
        
        var name : String
        var image : UIImage!
        var type : PokemonType
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
            image = UIImage(named : "Idle_0001.png")
            maxhealth = level * hpPerLevel
            health = maxhealth
        }
        
        //MARK: - Methods
        
        func levelUp () {
            level++
            health = health + 20
            
        }
        
        func MyAnimationImage(myKey : String, completion : (animationImages : [UIImage], animationImageFrame : PokemonAnimationFrame! ) -> Void) {
            var sec : String
            var nAta = "Idle_00"
            var secFor = 41
            
            var animationImages = [UIImage]()
            var animationImageFrame : PokemonAnimationFrame!
            
            if let MyFrameOptions = animationFrame[myKey] {
                
                animationImageFrame = MyFrameOptions
                
                if MyFrameOptions.Ata == 1 {
                    nAta = "Attack1_00"
                    secFor = 51
                }
                if MyFrameOptions.Ata == 2 {
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
            }
            
            completion(animationImages: animationImages, animationImageFrame: animationImageFrame)
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
    }
    
    class OwnedPokemon: Pokemon {
        
        var owner : String
        
        init(name: String, type: PokemonType, owner : String) {
            self.owner = owner
            super.init(name: name, type: type)
        }
    }
