//
//  Character.swift
//  TapAttack
//
//  Created by Ridwan Al-Mansur on 04/02/2016.
//  Copyright © 2016 Ridwan. All rights reserved.
//

import Foundation

class Character {
    private var _name: String
    private var _attackPower: Int
    private var _hp: Int
    
    var name: String {
        get {
            return _name
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    init(name: String, attackPwr: Int, hp: Int) {
        self._name = name
        self._attackPower = attackPwr
        self._hp = hp
    }
    
    func isAlive(attackPower: Int) -> Bool {
        if (self._hp <= 0) {
           return false
        }
        return true
    }
    
    func attacked(attackPower: Int) {
        self._hp -= attackPower
    }
    
}