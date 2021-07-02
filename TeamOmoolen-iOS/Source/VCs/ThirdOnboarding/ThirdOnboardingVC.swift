//
//  ThirdOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/06/30.
//

import UIKit

class ThirdOnboardingVC: UIViewController {
    
    //Mark: - Properties
    private var functionList: [FunctionDataModel] = []
    private var timeList: [TimeDataModel] = []
    
    //Mark: - IBOutlet Properties
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var functionMainLabel: UILabel!
    @IBOutlet weak var functionSubLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var functionCollectionView: UICollectionView!
        
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    //Mark: - IBAction Properties
    @IBAction func nextButtonClicked(_ sender: Any) {
        //push
//        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.ThirdOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.FirstOnboarding) as? ThirdOnboardingVC else {
//            return
//        }
//
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //Mark: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
        setCollectionViewDelegate()
        registerCell()
        setFunctionList()
        setTimeList()
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateProgressViewWithAnimation), userInfo: nil, repeats: true)
    }
    //Mark: - Methods
    func setUI(){
        
        progressView.progress = 0.5
        progressView.progressTintColor = .orange
        
        
        progressLabel.text = "3/4"
        
        functionMainLabel.text = "어떤 기능의 렌즈가 필요하세요?"
        functionMainLabel.textColor = .black
        functionSubLabel.text = "기능을 선택하시면 필요에 맞게 렌즈를 추천해드릴게요!"
        functionSubLabel.textColor = .gray
        
        timeLabel.text = "어떤 주기의 렌즈를 찾으시나요?"
        timeLabel.textColor = .black
                
        
        nextButtonView.backgroundColor = .systemGray
        
        
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "맞춤 정보 설정"
        self.navigationController?.navigationBar.tintColor = .omSecondGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.omSecondGray, .font: UIFont(name: "NotoSansCJKKR-Medium", size: 16) as Any]
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icBack")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icBack")
        self.navigationItem.backButtonTitle = ""
    }
    
    func setCollectionViewDelegate() {
        
        functionCollectionView.delegate = self
        functionCollectionView.dataSource = self
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        
    }
    
    func registerCell() {
        let functionNib = UINib(nibName: "FunctionCVC", bundle: nil)
        functionCollectionView.register(functionNib, forCellWithReuseIdentifier: "FunctionCVC")
        
        let timeNib = UINib(nibName: "TimeCVC", bundle: nil)
        timeCollectionView.register(timeNib, forCellWithReuseIdentifier: "TimeCVC")
        
    }
    
    func setFunctionList() {
        functionList.append(contentsOf: [FunctionDataModel(functionName: "근시"),
                                         FunctionDataModel(functionName: "난시"),
                                         FunctionDataModel(functionName: "다초점"),
                                         FunctionDataModel(functionName: "없음")
        ])
        
    }
    
    func setTimeList() {
        timeList.append(contentsOf: [TimeDataModel(timeType: "원데이"), TimeDataModel(timeType: "1주"), TimeDataModel(timeType: "2주"),TimeDataModel(timeType:"1개월"), TimeDataModel(timeType:"2~3개월"), TimeDataModel(timeType: "3~6개월"), TimeDataModel(timeType:"6개월 이상"), TimeDataModel(timeType: "없음")
        ])
        
    }
    
    //Mark: - @objc Methods
    @objc func updateProgressViewWithAnimation(){
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.75 {
                self.progressView.setProgress(0.75, animated: true)
            }
        }
    }

  

}

//Mark: - Extensions
//Mark: - UICollectionViewDataSource

extension ThirdOnboardingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int {
        
        if collectionView == functionCollectionView {
            return functionList.count
        } else if collectionView == timeCollectionView {
            return timeList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == functionCollectionView {
            guard let functionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FunctionCVC", for: indexPath) as? FunctionCVC else {
                return UICollectionViewCell()
            }
            functionCell.setData(functionName: functionList[indexPath.row].functionName)
            
            functionCell.layer.cornerRadius = 7
            functionCell.contentView.layer.cornerRadius = 20
            functionCell.contentView.layer.masksToBounds = true


            
            return functionCell
            
        } else if collectionView == timeCollectionView {
            guard let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCVC", for: indexPath) as? TimeCVC else {
                return UICollectionViewCell()
            }
            
            timeCell.setData(timeType: timeList[indexPath.row].timeType)
            timeCell.layer.cornerRadius = 10
            timeCell.contentView.layer.cornerRadius = 20
            timeCell.contentView.layer.masksToBounds = true
            
            return timeCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    
}


//Mark: - UICollectionViewDelegate

extension ThirdOnboardingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == functionCollectionView {
            return CGSize(width: (collectionView.frame.width-19)/2, height: (collectionView.frame.height - 12)  / 2)
        } else {
            return CGSize(width: (collectionView.frame.width-20)/3, height: (collectionView.frame.height-20)/3)
        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //return UIEdgeInsets.zero
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 5
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 9
        } else {
            return 2.5
        }
    }
    
}
