//
//  FilterVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class FilterVC: UIViewController {
    
    // MARK: - Custom Views
    
    let colorFilterView = ColorFilterView()
    let brandFilterView = BrandFilterView()
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .omAlmostwhite
        
        view.addSubview(colorFilterView)
        view.addSubview(brandFilterView)
        
        colorFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(472)
        }
        colorFilterView.isHidden = true
        
        brandFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(472)
        }
        brandFilterView.isHidden = false
        
    }
   
}
