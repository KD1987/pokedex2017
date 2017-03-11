//
//  DetailVC.swift
//  PokeDex_2017
//
//  Created by Kiel Delina on 2017-03-08.
//  Copyright © 2017 Dilemma. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgLbl: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var DefenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeDexLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoLbl: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    @IBOutlet weak var NextEvoDescrLbl: UILabel!
    
    
  
    var pokemon: Pokemon!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        imgLbl.image = img
        pokeDexLbl.text = "\(pokemon.pokedexId)"

        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
        
        
    }
    
    func updateUI(){
        
        attackLbl.text = pokemon.attack
        DefenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        TypeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionID == nil {
            
            NextEvoDescrLbl.text == ""
            nextEvoLbl.isHidden = true
        } else {
            nextEvoLbl.isHidden = false
            NextEvoDescrLbl.text = "Next Evolution is \(pokemon.nextEvolutionName) at level \(pokemon.nextEvolutionLevel)"
            nextEvoLbl.image = UIImage(named: pokemon.nextEvolutionID)
            
        }

    }


    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true
            , completion: nil)
        
    }



}
