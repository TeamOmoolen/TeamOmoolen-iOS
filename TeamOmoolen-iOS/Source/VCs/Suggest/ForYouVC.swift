//
//  ForYouVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class ForYouVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var popUpTop: UIView!
    @IBOutlet weak var popUpMiddle: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpBottom: UIView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

    }
    
    func setUI(){
        
        popUpTop.backgroundColor = .omFifthGray
        popUpLabel.text = "나에게 딱 맞는 오무렌의 추천 렌즈를 소개합니다"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
        popUpMiddle.backgroundColor = UIColor(red: 255, green: 154 , blue: 36, alpha: 0
        )
        popUpBottom.backgroundColor = .omFifthGray
    }
    


}
