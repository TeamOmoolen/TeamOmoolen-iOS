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
    var gender = ""
    var age = ""
    var lensKind = ""
    var lensColor = ""
    var lensFunction = ""
    var lensPeriod = ""
    
    //Mark: - IBOutlet Properties
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var functionMainLabel: UILabel!
    @IBOutlet weak var functionSubLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var functionCollectionView: UICollectionView!
        
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    //Mark: - IBAction Properties
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.FourthOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.FourthOnboarding) as? FourthOnboardingVC else {
            return
        }
        nextVC.age = age
        nextVC.gender = gender
        nextVC.lensKind = lensKind
        nextVC.lensColor = lensColor
        nextVC.lensFunction = lensFunction
        nextVC.lensPeriod = lensPeriod
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }
        
    }
    //Mark: - Methods
    func setUI(){
        baseView.backgroundColor = .omAlmostwhite
        
        progressView.progress = 0.5
        progressView.progressTintColor = .omMainOrange
        
        
        progressLabel.text = "3/4"
        progressLabel.textColor = .omThirdGray
        progressLabel.font = UIFont(name: "Roboto-Regular", size: 12)

        
        functionMainLabel.text = "어떤 기능의 렌즈가 필요하세요?"
        functionMainLabel.textColor = .omMainBlack
        functionMainLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        functionCollectionView.backgroundColor = .omAlmostwhite
        functionSubLabel.text = "기능을 선택하시면 필요에 맞게 렌즈를 추천해드릴게요!"
        functionSubLabel.textColor = .omFourthGray
        functionSubLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)

        
        timeCollectionView.backgroundColor = .omAlmostwhite
        timeLabel.text = "어떤 주기의 렌즈를 찾으시나요?"
        timeLabel.textColor = .omMainBlack
        timeLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)

                
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        nextButton.tintColor = .omWhite
        nextButton.backgroundColor = .omFourthGray
        nextButton.layer.cornerRadius = 10
        nextButton.isUserInteractionEnabled = false
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        setupNavigationBar(customNavigationBarView: customNavigationBarView)
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
    
    func updateProgressViewWithAnimation(){
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
            functionCell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            
            functionCell.backgroundColor = .white
            functionCell.setData(functionName: functionList[indexPath.row].functionName)
            
            functionCell.layer.cornerRadius = 7
            functionCell.contentView.layer.cornerRadius = 20
            functionCell.contentView.layer.masksToBounds = true
            
            return functionCell
            
        } else if collectionView == timeCollectionView {
            guard let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCVC", for: indexPath) as? TimeCVC else {
                return UICollectionViewCell()
            }
            timeCell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            timeCell.backgroundColor = .white
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


extension ThirdOnboardingVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if functionCollectionView.indexPathsForSelectedItems?.isEmpty == false && timeCollectionView.indexPathsForSelectedItems?.isEmpty == false {
                        
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
            
            
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if functionCollectionView.indexPathsForSelectedItems?.isEmpty == false && timeCollectionView.indexPathsForSelectedItems?.isEmpty == false {
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
    
}


//Mark: - UICollectionViewDelegate

extension ThirdOnboardingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == functionCollectionView {
            return CGSize(width: (collectionView.frame.width-20)/2, height: (collectionView.frame.height - 22)  / 2)
        } else {
            return CGSize(width: (collectionView.frame.width-30)/3, height: (collectionView.frame.height-34)/3)
        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == functionCollectionView {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 12
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 9
        } else {
            return 10
        }
    }
    
}
