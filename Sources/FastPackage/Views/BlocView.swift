//
//  BlocView.swift
//  
//
//  Created by test on 05.09.2024.
//

import UIKit

public final class BlocView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        self.frame.size = CGSize(width: Constants.blockViewWidth,
                                 height: Constants.blocViewHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    func startFalling() {
        guard let superView = superview else { return }
        
        let fallDuration: TimeInterval = Constants.timeIntervalBlockView
        
        UIView.animate(withDuration: fallDuration, animations: {
            self.frame.origin.y = superView.frame.maxY
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
// MARK: - Constants
fileprivate extension BlocView {
    
    enum Constants {
        static let timeIntervalBlockView = 4.0
        static let blockViewWidth: CGFloat = 50.0
        static let blocViewHeight: CGFloat = 50.0
        
        static let fatalError = "init(coder:) has not been implemented"
    }
}
