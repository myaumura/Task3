//
//  ViewController.swift
//  Task3
//
//  Created by Gusev Kirill on 08.11.2024.
//

import UIKit

class ViewController: UIViewController {

    let animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut)
    
    private var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private var squareView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(squareView)
        view.addSubview(slider)
        
        NSLayoutConstraint.activate([
            squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            squareView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        
        animator.pausesOnCompletion = true
        
        animator.addAnimations { [unowned self, unowned squareView] in
            let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            squareView.transform = CGAffineTransform(rotationAngle: .pi / 2).concatenating(transform)
            let bounds = squareView.frame.applying(transform)
            squareView.center.x = self.view.bounds.width - bounds.midX
        }
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func sliderReleased(_ sender: UISlider) {
        slider.setValue(1.0, animated: true)
        animator.startAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        slider.frame = CGRect(x: view.layoutMargins.left,
                              y: 300,
                              width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right,
                              height: 40)
    }
}

