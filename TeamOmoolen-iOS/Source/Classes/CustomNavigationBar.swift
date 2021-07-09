//
//  CustomNavigationBar.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/04.
//

import Foundation
import UIKit

class CustomNavigationBar: UIView {
    // MARK: - Properties
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icBack"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "맞춤 정보 설정"
        label.textColor = UIColor.omSecondGray
        label.font = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
        return label
    }()
    
//    //closebtn
//    let closeButton: UIButton = {
//       let button = UIButton()
//        button
//        return button
//    }()
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .omFourthGray
        return view
    }()
    
    // MARK: - Methods
    init(vc: UIViewController) {
        super.init(frame: .zero)
        setUI()
        setupLayout()
        setupAction(vc: vc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = UIColor.omWhite
    }
    
    
    private func setupLayout() {
        addSubview(backButton)
        addSubview(titleLabel)
        //addSubview(closeButton)
        addSubview(separatorView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //trail로 바꾸기
//            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7)
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupAction(vc: UIViewController) {
        let backAction = UIAction { _ in
//            vc.dismiss(animated: true, completion: nil)
            vc.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(backAction, for: .touchUpInside)
    }
}
