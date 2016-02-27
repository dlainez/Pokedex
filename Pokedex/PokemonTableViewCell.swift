//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by CFPAPP on 27/2/16.
//  Copyright © 2016 DLAINEZM. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
