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

enum TimerStatus {
  case start
  //  case pause
  case end
}

class TimerViewController: UIViewController {
  
  // MARK: - Protery
  
  private let playImage = UIImage(systemName: "play.circle")
  private let pauseImage = UIImage(systemName: "pause.circle")
  private let stopImage = UIImage(systemName: "stop.circle")
  
  private lazy var animaionView = LottieAnimationView.init(name: "TimerAnimation").then {
    $0.contentMode = .scaleAspectFit
    $0.loopMode = .loop
  }
  
  private lazy var toggleButton = UIButton().then {
    $0.setImage(
      playImage,
      for: .normal
    )
    $0.addTarget(
      self,
      action: #selector(tapToggleButton),
      for: .touchUpInside
    )
    $0.tintColor = .black
  }
  
  private lazy var stopButton = UIButton().then {
    $0.setImage(
      stopImage,
      for: .normal
    )
    $0.tintColor = .black
  }
  
  private lazy var timerLabel = UILabel().then {
    $0.text = String(
      format: "%02d:%02d:%02d",
      0,
      0,
      0
    )
    
    $0.font = .systemFont(
      ofSize: 64.0,
      weight: .bold
    )
    $0.textColor = .black
    $0.textAlignment = .center
  }
  
  private lazy var datePicker = UIDatePicker().then {
    $0.datePickerMode = .countDownTimer
  }
  
  private lazy var progressView = UIProgressView().then {
    $0.tintColor = .black
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 6.0
  }
  
  var duration = 60
  var timerStatus = TimerStatus.end
  var timer: DispatchSourceTimer?
  var currnetSeconds = 0
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
}

// MARK: - Method

private extension TimerViewController {
  func configureUI() {
    
    progressView.isHidden = true
    
    [
      animaionView,
      datePicker,
      progressView,
      timerLabel,
      toggleButton
    ].forEach { view.addSubview($0) }
    
    animaionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
      $0.width.height.equalTo(100.0)
      $0.centerX.equalToSuperview()
    }
    
    datePicker.snp.makeConstraints {
      $0.top.equalTo(animaionView.snp.bottom).offset(16.0)
      $0.height.equalTo(240.0)
      $0.leading.trailing.equalToSuperview()
    }
    
    progressView.snp.makeConstraints {
      $0.height.equalTo(12.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.centerY.equalTo(datePicker.snp.centerY)
    }
    
    timerLabel.snp.makeConstraints {
      $0.top.equalTo(datePicker.snp.bottom).offset(16.0)
      $0.centerX.equalToSuperview()
    }
    
    toggleButton.snp.makeConstraints {
      $0.top.equalTo(timerLabel.snp.bottom).offset(16.0)
      $0.height.width.equalTo(100.0)
      $0.centerX.equalToSuperview()
    }
    
    toggleButton.imageView?.snp.makeConstraints {
      $0.width.height.equalTo(80.0)
    }
  }
  
  func startTimer() {
    toggleButton.setImage(stopImage, for: .normal)
    animaionView.play()
    
    
    UIView.animate(withDuration: 0.5, animations: {
        self.progressView.alpha = 1
        self.datePicker.alpha = 0
    })
    
    datePicker.isHidden = true
    progressView.isHidden = false
    
    if self.timer == nil {
      self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
      self.timer?.schedule(deadline: .now(), repeating: 1)
      self.timer?.setEventHandler(handler: {
        
        [weak self] in
        
        guard let self = self else { return }
        
        self.currnetSeconds -= 1
        let hour = self.currnetSeconds / 3600
        let miniute = (self.currnetSeconds % 3600) / 60
        let second = (self.currnetSeconds % 3600) % 60
        
        // 숫자를 2자리로 표현
        
        self.timerLabel.text = String(
          format: "%02d:%02d:%02d",
          hour,
          miniute,
          second
        )
        
        self.progressView.progress = Float(self.currnetSeconds) / Float(self.duration)
        
        if self.currnetSeconds <= 0 {
          self.stopTimer()
        }
        
      })
      self.timer?.resume()
    }
  }
  
  func stopTimer() {

    toggleButton.setImage(playImage, for: .normal)
    animaionView.stop()
    
    UIView.animate(withDuration: 0.5, animations: {
        self.progressView.alpha = 0
        self.datePicker.alpha = 1
    })
    
    datePicker.isHidden = false
    progressView.isHidden = true
    
    self.timerStatus = .end
    
    self.timer?.cancel()
    
    self.timerLabel.text = String(
      format: "%02d:%02d:%02d",
      0,
      0,
      0
    )
    
    self.timer = nil
  }
  
  @objc func tapToggleButton() {
    self.duration = Int(self.datePicker.countDownDuration)
    
    switch self.timerStatus {
    case .end:
      self.currnetSeconds = self.duration
      self.timerStatus = .start
      self.startTimer()
    case .start:
      self.stopTimer()
      
    }
  }
  
}


extension TimerViewController {
  
}

//final class TimerViewController: UIViewController {
//
//  // MARK: - Properties
//
//  private let playImage = UIImage(systemName: "play.circle")
//  private let pauseImage = UIImage(systemName: "pause.circle")
//  private let stopImage = UIImage(systemName: "stop.circle")
//
//  private var timer: Timer?
//  private var isRunning = false
//  private var timeCount: Int = 0 {
//    didSet {
//      updateTimeLabel(timeCount)
//    }
//  }
//
//  private lazy var animaionView = LottieAnimationView.init(name: "TimerAnimation").then {
//    $0.contentMode = .scaleAspectFit
//    $0.loopMode = .loop
//  }
//
//  private lazy var timeLabel = UILabel().then {
//    $0.text = "00 : 00 : 00"
//    $0.font = .systemFont(
//      ofSize: 64.0,
//      weight: .bold
//    )
//    $0.textColor = .black
//    $0.textAlignment = .center
//  }
//
//  private lazy var timerButton = UIButton().then {
//    $0.setImage(
//      playImage,
//      for: .normal
//    )
//    $0.addTarget(
//      self,
//      action: #selector(tapTimerButton),
//      for: .touchUpInside
//    )
//    $0.tintColor = .black
//  }
//
//    private lazy var stopButton = UIButton().then {
//      $0.setImage(
//        stopImage,
//        for: .normal
//      )
//      $0.tintColor = .black
//  }
//
//  // MARK: - Lifecycle
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    configureUI()
//    //        animaionView.play()
//  }
//}
//
//// MARK: - Private
//
//private extension TimerViewController {
//
//  func configureUI() {
//
//    view.backgroundColor = .timerGreen
//
//    let timerStack = UIStackView(arrangedSubviews: [
//      timerButton, stopButton
//    ]).then {
//      $0.axis = .horizontal
//      $0.spacing = 32.0
//
//      timerButton.imageView?.snp.makeConstraints {
//        $0.width.height.equalTo(100.0)
//      }
//
//      stopButton.imageView?.snp.makeConstraints {
//        $0.width.height.equalTo(100.0)
//      }
//
//    }
//
//    [
//      animaionView,
//      timeLabel,
//      timerStack
//    ].forEach { view.addSubview($0) }
//
//    animaionView.snp.makeConstraints {
//      $0.top.equalTo(view.safeAreaLayoutGuide).offset(64.0)
//      $0.height.width.equalTo(200.0)
//      $0.centerX.equalToSuperview()
//    }
//
//    timeLabel.snp.makeConstraints {
//      $0.top.equalTo(animaionView.snp.bottom).offset(16.0)
//      $0.centerX.equalToSuperview()
//    }
//
//    timerButton.snp.makeConstraints {
//      $0.top.equalTo(timeLabel.snp.bottom).offset(32.0)
//      $0.centerX.equalToSuperview()
//      $0.width.height.equalTo(100.0)
//    }
//
//    stopButton.snp.makeConstraints {
//      $0.top.equalTo(timeLabel.snp.bottom).offset(32.0)
//      $0.centerX.equalToSuperview()
//    }
//  }
//
//  func createTimer() {
//    timer = Timer.scheduledTimer(
//      withTimeInterval: 1,
//      repeats: true,
//      block: { [weak self] _ in
//        self?.timeCount += 1
//      }
//    )
//  }
//
//  func updateTimeLabel(_ count: Int) {
//    let hour = count / 3600
//    let min = (count % 3600) / 60
//    let sec = (count % 3600) % 60
//
//    let hourStr: String = "\(hour)".count == 1 ? "0\(hour)" : "\(hour)"
//    let minStr: String = "\(min)".count == 1 ? "0\(min)" : "\(min)"
//    let secStr: String = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
//
//    let timeStr = String(
//      format: "%@ : %@ : %@",
//      hourStr,
//      minStr,
//      secStr
//    )
//    timeLabel.text = timeStr
//    view.layoutIfNeeded()
//  }
//
//  func removeTimer() {
//    timer?.invalidate()
//    timer = nil
//    timeCount = 0
//  }
//
//  // MARK: - Selector
//
//  @objc func tapTimerButton() {
//    isRunning == false
//    ?
//    {
//      isRunning.toggle()
//      timerButton.setImage(pauseImage, for: .normal)
//      animaionView.play()
//      createTimer()
//
//    }()
//    :
//    {
//      isRunning.toggle()
//      timerButton.setImage(playImage, for: .normal)
//      animaionView.stop()
//      removeTimer()
//    }()
//  }
//
//}