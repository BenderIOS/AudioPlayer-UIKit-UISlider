//
//  ViewController.swift
//  #6 UISlider dz
//
//  Created by Andrew on 31/01/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var firstTrackLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondTrackLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var thirdTrackLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var listenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //добавляю углы к кнопке слушать
        listenButton.layer.cornerRadius = listenButton.frame.height / 2
        listenButton.clipsToBounds = true
        listenButton.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "0" {
            print("GGGGG")
            let track = segue.destination as? secondViewController
            guard let img = firstImage.image else { return }
            track?.imageCVC1 = img
            track?.name = firstTrackLabel.text ?? "0"
            track?.name2 = firstNameLabel.text ?? "0"
            
            track?.count = 0
            do {
                if let audioPath = Bundle.main.path(forResource: "sheikh", ofType: "mp3") {
                    try track?.player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
                }
            } catch {
                print("ERRoR")
            }
            track?.player.play()
        }
        
        if segue.identifier == "1" {
            let track = segue.destination as? secondViewController
            guard let img = secondImage.image else { return }
            track?.imageCVC1 = img
            track?.name = secondTrackLabel.text ?? "0"
            track?.name2 = secondNameLabel.text ?? "0"
            track?.count = 1
            
            do {
                if let audioPath = Bundle.main.path(forResource: "Barbariki", ofType: "mp3") {
                    try track?.player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
                }
            } catch {
                print("ERRoR")
            }
            track?.player.play()
        }
            
        if segue.identifier == "2" {
            let track = segue.destination as? secondViewController
            guard let img = thirdImage.image else { return }
            track?.imageCVC1 = img
            track?.name = thirdTrackLabel.text ?? "0"
            track?.name2 = thirdNameLabel.text ?? "0"
            
            track?.count = 2
            do {
                if let audioPath = Bundle.main.path(forResource: "bigCityLife", ofType: "mp3") {
                    try track?.player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
                }
                } catch {
                    print("ERRoR")
                }
            track?.player.play()
            }
        }
}

