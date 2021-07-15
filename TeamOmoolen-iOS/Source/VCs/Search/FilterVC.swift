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
    
    //기기대응
    @IBOutlet weak var filterViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonButtomConstraint: NSLayoutConstraint!
    
    // MARK: - Custom Views
    
    let colorFilterView = ColorFilterView()
    let brandFilterView = BrandFilterView()
    let diameterFilterView = DiameterFilterView()
    let cycleFilterView = CycleFilterView()
    
    
    // MARK: - Local Variables
    private var searchResultResponse: SearchResultResponse?
    
    private var lensBrand = [String]()
    private var lensColor = [String]()
    private var lensDiameter = Int()
    private var lensCycle = [Int]()
    
    private var getBrandData = false
    private var getColorData = false
    private var getDiameterData = false
    private var getCycleData = false
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhoneResolution()
        setCategoryView()
        //setCustomView()
        setButtonView()
        setCustomView()
        setNotification()
        
        getData()
    }
    
    // 필터 검색 버튼 눌렀을 때
    @IBAction func touchUpSearchButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("touchUpSearchButton"), object: nil)
    }
}

// MARK: - Custom Methods

extension FilterVC {
    
    func setPhoneResolution(){
        if UIDevice.current.isiPhoneSE2 {
            filterViewTopConstraint.constant = 0
            print("버튼")
            buttonButtomConstraint.constant = 140
        } else if UIDevice.current.isiPhone12Pro {
            filterViewTopConstraint.constant = 85
        }
    }
    // MARK: - Category View
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
        
        let diameterTapGesture =  UITapGestureRecognizer(target: self, action: #selector(touchUpDiameterFilter))
        diameterView.addGestureRecognizer(diameterTapGesture)
        
        // 주기 필터
        cycleView.backgroundColor = .omWhite
        cycleView.layer.borderWidth = 1
        cycleView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        cycleView.layer.cornerRadius = 15
        cycleView.layer.masksToBounds = true
        
        cycleLabel.text = "주기"
        cycleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        cycleLabel.textColor = .omFourthGray
        
        let cycleTapGesture =  UITapGestureRecognizer(target: self, action: #selector(touchUpCycleFilter))
        cycleView.addGestureRecognizer(cycleTapGesture)
    }
    
    // MARK: - Filter View
    
    func setCustomView() {
        view.addSubview(colorFilterView)
        view.addSubview(brandFilterView)
        view.addSubview(diameterFilterView)
        view.addSubview(cycleFilterView)
        
        brandFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        
        brandFilterView.isHidden = false
        self.view.sendSubviewToBack(brandFilterView)
        self.view.bringSubviewToFront(buttonView)
        
        
        colorFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        colorFilterView.isHidden = true
        self.view.sendSubviewToBack(colorFilterView)
        
        diameterFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        diameterFilterView.isHidden = true
        
        cycleFilterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(filterView.snp.bottom).offset(1)
            make.height.equalTo(472)
        }
        cycleFilterView.isHidden = true
    }
    
    // MARK: - Button View
    
    func setButtonView() {
        buttonView.backgroundColor = .omWhite
        
        resetBackView.backgroundColor = .omFifthGray
        resetBackView.layer.cornerRadius = 10
        resetBackView.layer.masksToBounds = true
        
        let resetTapGesture =  UITapGestureRecognizer(target: self, action: #selector(touchUpReset))
        resetBackView.addGestureRecognizer(resetTapGesture)
        
        resetImageView.image = UIImage(named: "icReset")
        
        searchButton.layer.backgroundColor = UIColor.omMainBlack.cgColor
        searchButton.layer.cornerRadius = 10
        searchButton.layer.masksToBounds = true
        
        searchButton.setTitle("필터 검색", for: .normal)
        searchButton.tintColor = .omWhite
        searchButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Medium", size: 18)
    }
}

// MARK: - Action Methods

extension FilterVC {
    @objc
    func touchUpBrandFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = false
        colorFilterView.isHidden = true
        diameterFilterView.isHidden = true
        cycleFilterView.isHidden = true
        
        brandView.backgroundColor = .omMainOrange
        brandLabel.textColor = .omWhite
        
        colorView.backgroundColor = .omWhite
        colorLabel.textColor = .omFourthGray
        
        diameterView.backgroundColor = .omWhite
        diameterLabel.textColor = .omFourthGray
        
        cycleView.backgroundColor = .omWhite
        cycleLabel.textColor = .omFourthGray
    }
    
    @objc
    func touchUpColorFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = true
        colorFilterView.isHidden = false
        diameterFilterView.isHidden = true
        cycleFilterView.isHidden = true
        
        brandView.backgroundColor = .omWhite
        brandLabel.textColor = .omFourthGray
        
        colorView.backgroundColor = .omMainOrange
        colorLabel.textColor = .omWhite
        
        diameterView.backgroundColor = .omWhite
        diameterLabel.textColor = .omFourthGray
        
        cycleView.backgroundColor = .omWhite
        cycleLabel.textColor = .omFourthGray
    }
    
    @objc
    func touchUpDiameterFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = true
        colorFilterView.isHidden = true
        diameterFilterView.isHidden = false
        cycleFilterView.isHidden = true
        
        brandView.backgroundColor = .omWhite
        brandLabel.textColor = .omFourthGray
        
        colorView.backgroundColor = .omWhite
        colorLabel.textColor = .omFourthGray
        
        diameterView.backgroundColor = .omMainOrange
        diameterLabel.textColor = .omWhite
        
        cycleView.backgroundColor = .omWhite
        cycleLabel.textColor = .omFourthGray
    }
    
    @objc
    func touchUpCycleFilter(_ sender: UITapGestureRecognizer) {
        brandFilterView.isHidden = true
        colorFilterView.isHidden = true
        diameterFilterView.isHidden = true
        cycleFilterView.isHidden = false
        
        brandView.backgroundColor = .omWhite
        brandLabel.textColor = .omFourthGray
        
        colorView.backgroundColor = .omWhite
        colorLabel.textColor = .omFourthGray
        
        diameterView.backgroundColor = .omWhite
        diameterLabel.textColor = .omFourthGray
        
        cycleView.backgroundColor = .omMainOrange
        cycleLabel.textColor = .omWhite
    }
    
    @objc
    func touchUpReset(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name("touchUpBrandReset"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("touchUpColorReset"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("touchUpDiameterReset"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("touchUpCycleReset"), object: nil)
    }
}

// MARK: - Notification

extension FilterVC {
    private func setNotification() {
        // 브랜드
        NotificationCenter.default.addObserver(self, selector: #selector(searchBrandData), name: NSNotification.Name("postBrandList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetBrandData), name: NSNotification.Name("resetBrandList"), object: nil)
        
        // 컬러
        NotificationCenter.default.addObserver(self, selector: #selector(searchColorData), name: NSNotification.Name("postColorList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetColorData), name: NSNotification.Name("resetColorList"), object: nil)
        
        // 직경
        NotificationCenter.default.addObserver(self, selector: #selector(searchDiameterData), name: NSNotification.Name("postDiameterList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetDiameterData), name: NSNotification.Name("resetDiameterList"), object: nil)
        
        // 주기
        NotificationCenter.default.addObserver(self, selector: #selector(searchCycleData), name: NSNotification.Name("postCycleList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetCycleData), name: NSNotification.Name("resetCycleList"), object: nil)
    }
    
    // 브랜드 검색, 초기화
    @objc
    func searchBrandData(_ notification: Notification) {
        getBrandData = true
        lensBrand = notification.object as! [String]
        getData()
    }
    @objc
    func resetBrandData(_ notification: Notification) {
        lensBrand = notification.object as! [String]
    }
    
    // 컬러 검색, 초기화
    @objc
    func searchColorData(_ notification: Notification) {
        getColorData = true
        lensColor = notification.object as! [String]
        getData()
    }
    @objc
    func resetColorData(_ notification: Notification) {
        lensColor = notification.object as! [String]
    }
    
    // 직경 검색, 초기화
    @objc
    func searchDiameterData(_ notification: Notification) {
        getDiameterData = true
        lensDiameter = notification.object as! Int
        getData()
    }
    @objc
    func resetDiameterData(_ notification: Notification) {
        lensDiameter = notification.object as! Int
    }
    
    // 주기 검색, 초기화
    @objc
    func searchCycleData(_ notification: Notification) {
        getCycleData = true
        lensCycle = notification.object as! [Int]
        getData()
    }
    @objc
    func resetCycleData(_ notification: Notification) {
        lensCycle = notification.object as! [Int]
    }
}

// MARK: - Request API

extension FilterVC {
    func getData() {
        if getBrandData && getColorData && getDiameterData && getCycleData {
            requestAPI()
        }
    }
    
    func requestAPI() {
        let param = SearchFilterRequest(lensBrand, lensColor, lensDiameter, lensCycle)
        
        print(param)
        
        getSearchResultWithAPI(param: param)
    }
    
    func getSearchResultWithAPI(param: SearchFilterRequest) {
        SearchAPI.shared.getSearchFilterResult(param: param) { response in
            print(response)
            self.searchResultResponse = response
            
            guard let searchVC = UIStoryboard(name: Const.Storyboard.Name.SearchResult, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SearchResult) as? SearchResultVC else {
                return
            }
            searchVC.modalPresentationStyle = .fullScreen
            searchVC.modalTransitionStyle = .crossDissolve
            searchVC.resultList = self.searchResultResponse?.products
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}
