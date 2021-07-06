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
        
        print("🧃 \(view.frame.width)")
        print("\(view.frame.height) 🧃")
        
        view.addSubview(brandFilterView)
        
        brandFilterView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(200)
            make.width.equalTo((UIScreen.main.bounds.width) * (335/375))
            make.height.equalTo(472)
        }
    }
    
}
