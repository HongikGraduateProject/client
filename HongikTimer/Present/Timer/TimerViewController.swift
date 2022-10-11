//
//  TimerViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import Lottie
import SnapKit
import Then
import UIKit

final class TimerViewController: UIViewController {
    
    private let playImage = UIImage(systemName: "play.circle")
    private let pauseImage = UIImage(systemName: "pause.circle")
    
    private var timer: Timer?
    private var isRunning = false
    private var timeCount: Int = 0 {
        didSet {
            updateTimeLabel(timeCount)
        }
    }
    
    private lazy var animaionView = LottieAnimationView.init(name: "TimerAnimation").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
    }
    
    private lazy var timeLabel = UILabel().then {
        $0.text = "00 : 00 : 00"
        $0.font = .systemFont(
            ofSize: 64.0,
            weight: .bold
        )
        $0.textColor = .black
    }
    
    private lazy var timerButton = UIButton().then {
        $0.setImage(
            playImage,
            for: .normal
        )
        $0.addTarget(
            self,
            action: #selector(tapTimerButton),
            for: .touchUpInside
        )
        $0.tintColor = .black
    }
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
//        animaionView.play()
    }
}

// MARK: - Private

private extension TimerViewController {
    
    func setupLayout() {
        view.backgroundColor = UIColor.init(rgb: 0x8bc86b)
        
        [
            animaionView,
            timeLabel,
            timerButton
        ].forEach { view.addSubview($0) }
        
        animaionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64.0)
            $0.height.width.equalTo(200.0)
            $0.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(animaionView.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        timerButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(32.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100.0)
        }
        
        timerButton.imageView?.snp.makeConstraints {
            $0.width.height.equalTo(100.0)
        }
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { [weak self] _ in
                self?.timeCount += 1
            }
        )
    }
    
    func updateTimeLabel(_ count: Int) {
        let hour = count / 3600
        let min = (count % 3600) / 60
        let sec = (count % 3600) % 60
        
        let hourStr: String = "\(hour)".count == 1 ? "0\(hour)" : "\(hour)"
        let minStr: String = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        let secStr: String = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"

        let timeStr = String(
            format: "%@ : %@ : %@",
            hourStr,
            minStr,
            secStr
        )
        timeLabel.text = timeStr
        view.layoutIfNeeded()
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
        timeCount = 0
    }
    
// MARK: - Selector
    
    @objc func tapTimerButton() {
        isRunning == false
        ?
        {
            isRunning.toggle()
            timerButton.setImage(pauseImage, for: .normal)
            animaionView.play()
            createTimer()
            
        }()
        :
        {
            isRunning.toggle()
            timerButton.setImage(playImage, for: .normal)
            animaionView.stop()
            removeTimer()
        }()
    }
}
