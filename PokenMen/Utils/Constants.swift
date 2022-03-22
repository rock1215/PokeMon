//
//  Constants.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import Foundation
import UIKit

// URL Informations

let API_HOME = "https://pokeapi.co/api/v2/"
let API_LIST = API_HOME + "pokemon?"
let API_IMAGE = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

// USERDEFAULTS

let UserDefault = UserDefaults.standard

// KEY_FOR_USER_DEFAULTS

let KEY_COUNT_CALL = "api-calls"
let KEY_API_DATE = "api-date"
let KEY_TOTAL_COUNT = "api-count"

// SEGUES

let ID_DETAIL = "ShowDetail"

// COLORS

let COLOR_BLUE = UIColor(red: 0, green: 117 / 255, blue: 227 / 255, alpha: 1)
let COLOR_ORANGE = UIColor(red: 1, green: 204 / 255, blue: 0, alpha: 1)
