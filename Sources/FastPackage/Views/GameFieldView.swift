//
//  GameFieldView.swift
//  
//
//  Created by test on 05.09.2024.
//

import UIKit

public final class GameFieldView: UIView {
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: Constants.frameImageX,
                                 y: Constants.frameImageY,
                                 width: Constants.frameImageWidth,
                                 height: Constants.frameImageHeight)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(characterImageView)
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(gesture)
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self)
        
        if tapLocation.x > characterImageView.center.x {
            moveCharacterRight()
        } else if tapLocation.x < characterImageView.center.x {
            moveCharacterLeft()
        }
        
        if tapLocation.y > characterImageView.center.y {
            moveCharacterDown()
        } else if tapLocation.y < characterImageView.center.y {
            moveCharacterUp()
        }
        
        constrainCharacterToBounds()
    }
    ///контролируем перса при повороте экрана
    func constrainCharacterToBounds() {
        let characterFrame = characterImageView.frame
        let parentBounds = self.bounds
        
        if characterFrame.minX < parentBounds.minX {
            characterImageView.frame.origin.x = parentBounds.minX
        } else if characterFrame.maxX > parentBounds.maxX {
            characterImageView.frame.origin.x = parentBounds.maxX - characterFrame.width
        }
        
        if characterFrame.minY < parentBounds.minY {
            characterImageView.frame.origin.y = parentBounds.minY
        } else if characterFrame.maxY > parentBounds.maxY {
            characterImageView.frame.origin.y = parentBounds.maxY - characterFrame.height
        }
    }
    
    func handleScreenRotation() {
        constrainCharacterToBounds()
    }
    ///движение персонажа
    func moveCharacterRight() {
        let maxX = frame.maxX
        if characterImageView.frame.maxX + Constants.stepFrame <= maxX {
            characterImageView.center.x += Constants.stepFrame
        }
    }
    
    func moveCharacterLeft() {
        let minX = frame.minX
        if characterImageView.frame.minX - Constants.stepFrame >= minX {
            characterImageView.center.x -= Constants.stepFrame
        }
    }
    
    func moveCharacterUp() {
        let minY = frame.minY
        if characterImageView.frame.minY - Constants.stepFrame >= minY {
            characterImageView.center.y -= Constants.stepFrame
        }
    }
    
    func moveCharacterDown() {
        let maxY = frame.maxY
        if characterImageView.frame.maxY + Constants.stepFrame <= maxY {
            characterImageView.center.y += Constants.movementStep
        }
    }
}

// MARK: - Constants

fileprivate extension GameFieldView {
    
    enum Constants {
        static let frameImageX: CGFloat = 150
        static let frameImageY: CGFloat = 150
        static let frameImageWidth: CGFloat = 50
        static let frameImageHeight: CGFloat = 50
        static let stepFrame: CGFloat = 15
        static let characterXandYView: CGFloat = 300
        static let movementStep: CGFloat = 50.0
    }
}
