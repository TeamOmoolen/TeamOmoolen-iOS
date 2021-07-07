//
//  FilterVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class FilterVC: UIViewController {
    
    // MARK: - UI Components
    
    // 카테고리 뷰
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var diameterView: UIView!
    @IBOutlet weak var diameterLabel: UILabel!
    
    @IBOutlet weak var cycleView: UIView!
    @IBOutlet weak var cycleLabel: UILabel!
    
    // 버튼 뷰
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var resetBackView: UIView!
    @IBOutlet weak var resetImageView: UIImageView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Custom Views
    
    let colorFilterView = ColorFilterView()
    let brandFilterView = BrandFilterView()
    
    
    // MARK: - Local Variables
    
    private var lensBrand = [String]()
    private var lensColor = [String]()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCategoryView()
        setCustomView()
        setButtonView()
        
        setNotification()
    }
    
    // 필터 검색 버튼 눌렀을 때
    @IBAction func touchUpSearchButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("touchUpSearchButton"), object: nil)
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
        diameterView.backgroundColor = .omWhite
        diameterView.layer.borderWidth = 1
        diameterView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        diameterView.layer.cornerRadius = 15
        diameterView.layer.masksToBounds = true
        
        diameterLabel.text = "직경"
        diameterLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        diameterLabel.textColor = .omFourthGray
        
        // 주기 필터
        cycleView.backgroundColor = .omWhite
        cycleView.layer.borderWidth = 1
        cycleView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        cycleView.layer.cornerRadius = 15
        cycleView.layer.masksToBounds = true
        
        cycleLabel.text = "주기"
        cycleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        cycleLabel.textColor = .omFourthGray
    }
    
    func setCustomView() {
        view.backgroundColor = .omAlmostwhite
        
        view.addSubview(colorFilterView)
        view.addSubview(brandFilterView)
        
        brandFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        brandFilterView.isHidden = false
        
        
        colorFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        colorFilterView.isHidden = true
    }
    
    func setButtonView() {
        buttonView.backgroundColor = .omWhite
        
        resetBackView.backgroundColor = .omFifthGray
        resetBackView.layer.cornerRadius = 10
        resetBackView.layer.masksToBounds = true
        
        searchButton.layer.backgroundColor = UIColor.omMainBlack.cgColor
        searchButton.layer.cornerRadius = 10
        searchButton.layer.masksToBounds = true
        
        searchButton.setTitle("필터 검색", for: .normal)
        searchButton.tintColor = .omWhite
        searchButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Medium", size: 18)
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

// MARK: - Notification

extension FilterVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchBrandData), name: NSNotification.Name("postBrandList"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchColorData), name: NSNotification.Name("postColorList"), object: nil)
    }
    
    @objc
    func searchBrandData(_ notification: Notification) {
        print("🍏 브랜드 정보 받았다")
        lensBrand = notification.object as! [String]
        print(lensBrand)
    }
    
    @objc
    func searchColorData(_ notification: Notification) {
        print("🍎 컬러 정보 받았다")
        lensColor = notification.object as! [String]
        print(lensColor)
    }
}
