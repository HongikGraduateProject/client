//
//  TaskEditView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/11.
//

import UIKit
 
final class TaskEditViewController: UIViewController {
        
    private var taskVM: TaskViewModel
    private var indexPath: IndexPath
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    var editCompletion: (() -> Void)?
    
    private lazy var sliderIndicator = UIView().then {
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 2
    }
    
    private lazy var todoLabel = UILabel().then {
        $0.text = taskVM.contents
        $0.font = .systemFont(
            ofSize: 16.0,
            weight: .bold
        )
        $0.textColor = .label
    }
    
    private lazy var editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.backgroundColor = .systemGray4
        $0.layer.cornerRadius = 10.0
        $0.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
    }
    
    private lazy var deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.backgroundColor = .systemGray4
        $0.layer.cornerRadius = 10.0
        $0.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
    }
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setGesture()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    init(_ taskViewModel: TaskViewModel, indexPath: IndexPath) {
        self.taskVM = taskViewModel
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
        
        print("DEBUG edit view의 todo는 \(taskViewModel.contents)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension TaskEditViewController {
    func setupLayout() {
        view.backgroundColor = .systemBackground
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [
                editButton,
                deleteButton
            ]
        ).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }
        
        [
            sliderIndicator,
            todoLabel,
            buttonStackView
        ].forEach { view.addSubview($0) }
        
        sliderIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.width.equalTo(40.0)
            $0.height.equalTo(4.0)
        }
        
        todoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(64.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(todoLabel.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(todoLabel)
            $0.height.equalTo(32.0)
        }
    }
    
    func setGesture() {
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureRecognizerAction)
        )
        view.addGestureRecognizer(panGesture)
    }

// MARK: - Selector
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @objc func tapEditButton() {
        dismiss(animated: true)
        TodoNotificationManager.shared.postEdit(indexPath)
    }
    
    @objc func tapDeleteButton() {
        dismiss(animated: true)
        TodoNotificationManager.shared.postRemove(indexPath)
    }
}
