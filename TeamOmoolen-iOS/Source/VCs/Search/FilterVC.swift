//
//  FilterVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class FilterVC: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    
    // MARK: - Custom Views
    
    let colorFilterView = ColorFilterView()
    let brandFilterView = BrandFilterView()
    
    
    // MARK: - Local Variables
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryView()
        setCustomView()
    }
   
}

extension FilterVC {
    func setCategoryView() {
        // 브랜드 필터
        brandView.backgroundColor = .omMainOrange
        brandView.layer.borderWidth = 1
        brandView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        brandView.layer.cornerRadius = 15
        brandView.layer.masksToBounds = true
        
        brandLabel.text = "브랜드"
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        brandLabel.textColor = .omWhite
        
        let brandTapGesture =  UITapGestureRecognizer(target: self, action: #selector(touchUpBrandFilter))
        brandView.addGestureRecognizer(brandTapGesture)
        
        // 컬러 필터
        colorView.backgroundColor = .omWhite
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        colorView.layer.cornerRadius = 15
        colorView.layer.masksToBounds = true
        
        colorLabel.text = "컬러"
        colorLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        colorLabel.textColor = .omFourthGray
        
        let colorTapGesture =  UITapGestureRecognizer(target: self, action: #selector(touchUpColorFilter))
        colorView.addGestureRecognizer(colorTapGesture)
        
        // 직경 필터
        
        // 주기 필터
    }
    
    func setCustomView() {
        view.backgroundColor = .omAlmostwhite
        
        view.addSubview(colorFilterView)
        view.addSubview(brandFilterView)
        
        brandFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(472)
        }
        brandFilterView.isHidden = false
        
        
        colorFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(472)
        }
        colorFilterView.isHidden = true
        
    }
}

extension FilterVC {
    @objc
    func touchUpBrandFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = false
        colorFilterView.isHidden = true
        
        brandView.backgroundColor = .omMainOrange
        brandLabel.textColor = .omWhite
        
        colorView.backgroundColor = .omWhite
        colorLabel.textColor = .omFourthGray
    }
    
    @objc
    func touchUpColorFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = true
        colorFilterView.isHidden = false
        
        brandView.backgroundColor = .omWhite
        brandLabel.textColor = .omFourthGray
        
        colorView.backgroundColor = .omMainOrange
        colorLabel.textColor = .omWhite
    }
    
    @objc
    func touchUpDiameterFilter(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc
    func touchUpCycleFilter(_ sender: UITapGestureRecognizer) {
        
    }
}
