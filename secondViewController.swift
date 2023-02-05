//
//  secondViewController.swift
//  #6 UISlider dz
//
//  Created by Andrew on 31/01/23.
//

import UIKit
import AVFoundation

class secondViewController: UIViewController {
    var player = AVAudioPlayer()
    
    let allNamesInTrack = ["sheikh", "Barbariki", "bigCityLife"]
    var count: Int?
    
    @IBOutlet weak var startTimeLabel1: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var nameTrackCVC: UILabel!
    
    @IBOutlet weak var nextTrackButton: UIButton!
    @IBOutlet weak var backTrackButton: UIButton!
    @IBOutlet weak var nameCVC: UILabel!
    
    @IBOutlet weak var sliderTrack: UISlider!
    
    var sliderVolum = UISlider()
    
    @IBOutlet weak var imageCVC: UIImageView!
    
    @IBOutlet weak var playStart: UIButton!
    
    var imageCVC1 = UIImage()
    
    var name = ""
    var name2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //добавление слайдера громкости
        sliderVolum.frame = CGRect(x: 0, y: 700, width: 200, height: 10)
        sliderVolum.center.x = view.center.x
        sliderVolum.maximumValue = Float(player.duration)
        sliderVolum.addTarget(self, action: #selector(sliderVolumFunc(sender: )), for: .valueChanged)
        view.addSubview(sliderVolum)
        
        
        //Переприсваивание имени с первого VC
        nameTrackCVC.text = name
        nameCVC.text = name2
        imageCVC.image = imageCVC1
        imageCVC.layer.cornerRadius = 10
        
       //Для окраса кнопки в серый, когда выбраны крайние треки
        switch count {
        case 0: backTrackButton.tintColor = .gray
        case 2: nextTrackButton.tintColor = .gray
        default: break
        }
        
        sliderTrack.tintColor = .gray
        sliderTrack.thumbTintColor = .darkGray
        
        sliderTrack.addTarget(self, action: #selector(sliderTrackFunc(sender: )), for: .valueChanged)
        sliderTrack.minimumValue = 0.0
        sliderTrack.maximumValue = Float(player.duration)
        sliderTrack.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        sliderVolum.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        
        //Изменение кнопки, когда заходим с предыдущего VC
        playStart.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime () {
        sliderTrack.value = Float(player.currentTime)
        let timePlay = player.currentTime
        let minute = Int( timePlay / 60)
        let seconds = Int(timePlay.truncatingRemainder(dividingBy: 60))
        startTimeLabel1.text = NSString(format: "%02d:%02d", minute, seconds) as String
        
        let time = player.currentTime - player.duration
        let minuteEnd = Int(time / -60)
        let secondsEnd = Int(-time.truncatingRemainder(dividingBy: 60))
        endTimeLabel.text = NSString(format: "%02d:%02d", minuteEnd, secondsEnd) as String
    }
    
    //Привязка слайдека к треку
    @objc func sliderTrackFunc (sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
    @objc func sliderVolumFunc (sender: UISlider) {
        player.volume = sliderVolum.value
    }
    
    //Закрытие текущего VC
    @IBAction func downButton(_ sender: Any) {
        player.stop()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    //Кнопка предудущий трек
    @IBAction func backButton(_ sender: Any) {
        if (player.isPlaying == true) && (Int(player.currentTime.truncatingRemainder(dividingBy: 60)) > 3 ) {
            player.stop()
            player.currentTime = 0
            player.play()
            
        } else {
            switch count {
            case 1: count! -= 1
                backTrackButton.tintColor = .gray
                nameTrackCVC.text = "SHEIKH"
                nameCVC.text = "MORGENSHTERN"
                imageCVC.image = UIImage(named: "morgenImage")
            case 2: count! -= 1
                nextTrackButton.tintColor = .systemBlue
                nameTrackCVC.text = "BassBOOST"
                nameCVC.text = "Barbariki"
                imageCVC.image = UIImage(named: "barbarikiImage")
            default: break
            }

            let audioPath = Bundle.main.path(forResource: allNamesInTrack[count!], ofType: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: URL(filePath: audioPath!))
            player.play()
        }
    }
    
    @IBAction func playStopButton(_ sender: Any) {
        if player.isPlaying {
            player.pause()
            playStart.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            playStart.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func nextTrackButton(_ sender: Any) {
        switch count {
        case 0: count! += 1
            backTrackButton.tintColor = .systemBlue
            nameTrackCVC.text = "BassBOOST"
            nameCVC.text = "Barbariki"
            imageCVC.image = UIImage(named: "barbarikiImage")
        case 1: count! += 1
            nextTrackButton.tintColor = .gray
            nameTrackCVC.text = "Big city life"
            nameCVC.text = "Mattafix"
            imageCVC.image = UIImage(named: "bigImage")
        default: break
        }

        let audioPath = Bundle.main.path(forResource: allNamesInTrack[count!], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(filePath: audioPath!))
        player.play()
    }
    
    @IBAction func repeatButton(_ sender: Any) {
        player.stop()
        sleep(UInt32(player.currentTime))
        player.play()
    }
    
    @IBAction func shakeButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let activity = URL.init(filePath: Bundle.main.path(forResource: "\(allNamesInTrack[count!])", ofType: "mp3")!)
        let shareController = UIActivityViewController(activityItems: [activity as Any], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        present(shareController, animated: true)
    }
}
