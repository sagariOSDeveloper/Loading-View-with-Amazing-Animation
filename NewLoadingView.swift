//
//  Loading View.swift
//  Custom Views
//
//  Created by Sagar Baloch on 04/08/2020.
//  Copyright © 2020 Sagar Baloch. All rights reserved.
//

import Foundation
import UIKit



// This is an Loading View
//You can show it by using showLoading() method.
//Hide it by using hideLoading() method.

class NewLoadingView: UIView {
    
    static var loadingView: NewLoadingView?
    let rotatingCirclesView = RotatingCirclesView()
    
    static func showLoading(controllerView: UIView? = nil){
        guard let mainView:UIView = UIApplication.shared.keyWindow ?? controllerView else {return}
        loadingView = NewLoadingView()
        guard let loadingView = loadingView else{ return }
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(loadingView)
        loadingView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
    }
    
    fileprivate lazy var loadingText: UILabel = {
        let l = UILabel()
        l.text = "Loading...!"
        l.font = Theme.font(size: 15, type: .Regular)
        l.textColor = Theme.gradientColor1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
//    lazy var leftTimeLabel: UILabel = {
//        let label = UILabel()
//        label.text = self.timeSelected[0]
//        label.font = UIFont(name: "Roboto-Medium", size: 16)
//        label.textColor = Theme.gradientColor1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    fileprivate lazy var loadingSpinner: UIActivityIndicatorView = {
//        var activityIndicator  = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.hidesWhenStopped = true
//        return activityIndicator
//    }()
    
    fileprivate lazy var background:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.alpha = 0.6
        return v
    }()
    
//    fileprivate lazy var progress:UIProgressView = {
//        var prog = UIProgressView()
//        prog.progress = 0.5
//        prog.progressTintColor = .white
//        prog.translatesAutoresizingMaskIntoConstraints = false
//        return prog
//    }()
    
    fileprivate func setupViews(){
        self.addSubview(background)
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(rotatingCirclesView)
        rotatingCirclesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        rotatingCirclesView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rotatingCirclesView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rotatingCirclesView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.addSubview(loadingText)
        loadingText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingText.topAnchor.constraint(equalTo: self.rotatingCirclesView.bottomAnchor).isActive = true
//        loadingText.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        loadingText.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    static func hideLoading(){
        loadingView?.removeFromSuperview()
    }
    //When you're inflating with code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        rotatingCirclesView.animate(rotatingCirclesView.circle1, counter: 1)
        rotatingCirclesView.animate(rotatingCirclesView.circle2, counter: 3)
    }
    
    //When you're inflating with storyboard/xib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        rotatingCirclesView.animate(rotatingCirclesView.circle1, counter: 1)
        rotatingCirclesView.animate(rotatingCirclesView.circle2, counter: 3)
    }
}

class RotatingCirclesView: UIView {
    
    let circle1 = UIView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
    let circle2 = UIView(frame: CGRect(x: 120, y: 20, width: 60, height: 60))
    let position : [CGRect] = [CGRect(x: 30, y: 20, width: 60, height: 60),CGRect(x: 60, y: 15, width: 70, height: 70),CGRect(x: 110, y: 20, width: 60, height: 60),CGRect(x: 60, y: 25, width: 50, height: 50)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        circle1.backgroundColor = Theme.gradientColor1.withAlphaComponent(0.9)
        circle1.layer.cornerRadius = circle1.frame.width/2
        circle1.layer.zPosition = 2
        
        circle2.backgroundColor = Theme.blackColor.withAlphaComponent(0.9)
        circle2.layer.cornerRadius = circle2.frame.width/2
        circle2.layer.zPosition = 1
        
        addSubview(circle1)
        addSubview(circle2)
    }
    
    func animate(_ circle: UIView, counter: Int){
        var counter = counter
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            circle.frame = self.position[counter]
            circle.layer.cornerRadius = circle.frame.width/2
            
            switch counter{
            case 1:
                if circle == self.circle1{ self.circle1.layer.zPosition = 2}
            case 3:
                if circle == self.circle1{ self.circle1.layer.zPosition = 0}
            default:
                print()
                
            }
        }) { (completed) in
            
            switch counter{
            case 0...2:
                counter += 1
            case 3:
                counter = 0
            default:
                print()
            }
            self.animate(circle, counter: counter)
        }
        
    }
}
