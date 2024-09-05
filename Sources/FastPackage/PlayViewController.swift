//
//  PlayViewController.swift
//
//
//  Created by test on 05.09.2024.
//

import UIKit

public final class PlayViewController: UIViewController {
    
    // MARK: - Variables
    let gameFieldView: GameFieldView = {
        let view = GameFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var redViews: [BlocView] = []
    
    var stopWatchView = StopWatchView()
    var isGameOver = false {
        didSet {
            self.redViews = []
        }
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    // MARK: - functions
    
    /// Добавляем наблюдение за изменением ориентации
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    /// Обрабатываем изменение ориентации устройства
    @objc
    private func handleDeviceRotation() {
        gameFieldView.handleScreenRotation()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemPink
        view.addSubview(gameFieldView)
        NSLayoutConstraint.activate([
            gameFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameFieldView.topAnchor.constraint(equalTo: view.topAnchor),
            gameFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        createDisplayLink()
        startGame()
    }
    
    private func startGame() {
        stopWatchView.startTimer()
        
        Timer.scheduledTimer(timeInterval: 1.5,
                             target: self,
                             selector: #selector(addBlockView),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc
    private func addBlockView() {
        if isGameOver { return }
        
        let redView = BlocView()
        view.addSubview(redView)
        
        let randomXPosition = CGFloat.random(in: 0...(view.frame.width - redView.frame.width))
        redView.frame.origin.x = randomXPosition
        redView.frame.origin.y = -redView.frame.height
        
        redViews.append(redView)
        redView.startFalling()
    }
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .default)
    }
    
    @objc
    private func step(displayLink: CADisplayLink) {
        if isGameOver { return }
        
        redViews.forEach({ value in
            if detectCollision(view: value) {
                handleCollision()
            }
        })
    }
    
    private func detectCollision(view: UIView) -> Bool {
        if !isGameOver,
           let squareFrame = view.layer.presentation()?.frame,
           let characterFrame = gameFieldView.characterImageView.layer.presentation()?.frame {
            return squareFrame.intersects(characterFrame)
        }
        return false
    }
    
    private func handleCollision() {
        isGameOver = true
        stopWatchView.stop()
        
        let alertController = UIAlertController(
            title: "Игра окончена,\n Время \(stopWatchView.getTimeString())",
            message: nil, preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "Продолжить с этого места",
                style: .default,
                handler: { [weak self] _ in
                    self?.isGameOver = false
                    self?.startGame()
                }
            )
        )
        present(alertController, animated: true, completion: nil)
    }
}
