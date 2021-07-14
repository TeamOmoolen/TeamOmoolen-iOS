//
//  NewLensCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class NewLensCVC: UICollectionViewCell {
    static let identifier = "NewLensCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var brandImageView: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var lensLabel: UILabel!
    
    @IBOutlet weak var newLensTableView: UITableView!
    
    // MARK: - Local Variables
    
    var newLens: [NewLensDetailData]? = nil
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
        registerXib()
        setTableView()
    }
    
}

extension NewLensCVC {
    func setUI() {
        contentView.backgroundColor = .white
        modelImageView.image = UIImage(named: "abc")
        modelImageView.layer.cornerRadius = 10
        modelImageView.layer.masksToBounds = true
        
        brandImageView.image = UIImage(named: "abc")
        brandImageView.layer.cornerRadius = brandImageView.frame.width / 2
        brandImageView.layer.masksToBounds = true
        
        brandLabel.textColor = .omWhite
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        lensLabel.textColor = .omWhite
        lensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
    }
    
    func registerXib() {
        let detailNib = UINib(nibName: NewLensDetailTVC.identifier, bundle: nil)
        newLensTableView.register(detailNib, forCellReuseIdentifier: NewLensDetailTVC.identifier)
    }
    
    func setTableView() {
        newLensTableView.delegate = self
        newLensTableView.dataSource = self
        
        newLensTableView.separatorStyle = .none
        
        newLensTableView.isScrollEnabled = false
    }
    
    func initCell(lensData: [NewLensDetailData]) {
        newLens = lensData
    }
}

extension NewLensCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 3
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("PushtoDetailVC"), object: newLens?[indexPath.row].id)
    }
}

extension NewLensCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newLens?.count ?? 0 - 1
//        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewLensDetailTVC.identifier) as? NewLensDetailTVC else {
            return UITableViewCell()
        }
        let data = newLens?[indexPath.row + 1]
        cell.initCell(brand: data?.brand ?? "", name: data?.name ?? "", price: data?.price ?? 0, imageList: data?.imageList ?? [""])
//        cell.initCell()
        return cell
    }
    
}
