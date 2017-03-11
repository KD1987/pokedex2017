//
//  PokeCell.swift
//  PokeDex_2017
//
//  Created by Kiel Delina on 2017-03-05.
//  Copyright © 2017 Dilemma. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 5.0
    }
    
    func configCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        pokemonImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        nameLbl.text = self.pokemon.name.capitalized
        
        
        
    }
    
    
}
