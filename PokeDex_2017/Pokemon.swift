//
//  Pokemon.swift
//  PokeDex_2017
//
//  Created by Kiel Delina on 2017-03-05.
//  Copyright © 2017 Dilemma. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _PokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evoNext: String!
    private var _pokemonUrl: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
        
    }
    
    var nextEvolutionID: String {
        
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
        
    }

    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
        
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
        
    }
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
        
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
        
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
        
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack ==  nil {
            _attack = ""
        }
        return _attack
        
    }
    
    var evoNext: String {
        
        if _evoNext == nil {
            _evoNext = ""
        }
        return _evoNext
        
    }
    
    
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _PokedexID
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._PokedexID = pokedexId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
            
            
            //print (response.result.value)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }

                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                            
                        }
                        
                    }
                    else {
                        
                        self._type = ""
                    }
                }
                
                if let evos = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evos.count > 0 {
                    
                    if let evo2 = evos[0]["to"] as? String {
                        
                        self._evoNext = evo2
                        
                    }
                    
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let uri = descArr[0]["resource_uri"] {
                        let fullUri = "\(URL_BASE)\(uri)"
                        
                        Alamofire.request(fullUri).responseJSON { (response) in
                            
                            if let descArr2 = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let pokdesc = descArr2["description"] as? String {
                                    
                                    self._description = pokdesc
                                    
                                }
                            }
                            
                            completed()
                        }
                        
                    } else {
                        self._description = ""
                        
                    }
                    
                    if let evo = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evo.count > 0 {
                        
                        if let evo2 = evo[0]["to"] as? String {
                            
                            if evo2.range(of: "mega") == nil {
                                
                                self._nextEvolutionName = evo2
                                
                                if let NextEvolutionPokeID = evo[0]["resource_uri"] as? String {
                                    
                                    let prefixString = NextEvolutionPokeID.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let fullString = prefixString.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvolutionID = fullString
                                    
                                    if let lvlExist = evo[0]["level"] {
                                        
                                        if let lvl = lvlExist as? Int {
                                            
                                            self._nextEvolutionLevel = "\(lvl)"
                                            
                                        }
                                        
                                    } else {
                                        
                                        self._nextEvolutionLevel = ""
                                        
                                    }
                                    
                                    
                                }
                                
                            }

                        }
                        

                        
                    }
                    
            }
            completed()
            
        }
        }

    
    }
    
}
