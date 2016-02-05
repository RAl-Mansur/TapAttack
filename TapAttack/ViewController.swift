//
//  ViewController.swift
//  TapAttack
//
//  Created by Ridwan Al-Mansur on 04/02/2016.
//  Copyright © 2016 Ridwan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var player1HP: UILabel!
    @IBOutlet weak var player2HP: UILabel!
    @IBOutlet weak var printLabel: UILabel!
    @IBOutlet weak var player1AttackBtn: UIButton!
    @IBOutlet weak var player2AttackBtn: UIButton!
    
    var player1: Character!
    var player2: Character!
    var bgMusic: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPlayer1Attack(sender: AnyObject) {
        attack(player1, enemy: player2)
    }

    @IBAction func onPlayer2Attack(sender: AnyObject) {
        attack(player2, enemy: player1)
    }
    
    func attack(player: Character, enemy: Character) {
        enemy.attacked(player.attackPower)
        
        if enemy.isAlive(player.attackPower) {
            updateHP()
            disableControls()
            startTimer()
            printLabel.text = "\(player.name) attacked \(enemy.name) with \(player.attackPower) AP"
        } else {
            printLabel.text = "\(player.name) wins!"
            endGame()
        }
    }
    
    func startGame() {
        // Initialise players
        player1 = Character(name: "Orc", attackPwr: 25, hp: 100)
        player2 = Character(name: "Spartan", attackPwr: 25, hp: 100)
        updateHP()
        
        // Assign audio for button and play
        let path = NSBundle.mainBundle().pathForResource("ForTheSilentNightPSG", ofType: ".mp3")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try bgMusic = AVAudioPlayer(contentsOfURL: soundURL)
            bgMusic.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        playSound()
    }
    
    func endGame() {
        if (player1.hp <= 0) {
            player1HP.text = "0 HP"
        } else {
            player2HP.text = "0 HP"
        }
        disableControls()
    }
    
    func updateHP() {
        player1HP.text = "\(player1.hp) HP"
        player2HP.text = "\(player2.hp) HP"
    }
    
    func disableControls() {
        player1AttackBtn.enabled = false
        player2AttackBtn.enabled = false
        
    }
    
    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enableControls", userInfo: nil, repeats: false)
    }
    
    func enableControls() {
        player1AttackBtn.enabled = true
        player2AttackBtn.enabled = true
    }
    
    func playSound() {
        if bgMusic.playing {
            bgMusic.stop()
        }
        bgMusic.play()
    }
}

