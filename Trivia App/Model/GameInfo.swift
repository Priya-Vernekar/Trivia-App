//
//  GameInfo.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import Foundation

class GameInfo {
    
    static var sharedGameInfo : GameInfo = GameInfo()
    
    var name : String = ""
    var bestCricketer : String = ""
    var flagColors : String = ""
    var date : String = ""
    
    private init() {
        
    }
}
