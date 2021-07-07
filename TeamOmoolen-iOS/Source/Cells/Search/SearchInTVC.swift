//
//  SearchInTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//
import Foundation
import UIKit
import RealmSwift

class SearchInTVC: UITableViewCell {

    static let identifier = "SearchInTVC"
    
    //Mark: - IB Outlets
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    //Mark: - Variables
    var enteredText: String?
    var realm: Realm?
    var firstRecentSearch: String!
    var secondRecentSearch: String!
    var thirdRecentSearch: String!

    
    //Mark: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        realm = try? Realm()
        registerXib()
        checkNotification()
        checkSearchHistory()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Mark: - Methods
    func registerXib() {
        let SearchInNib = UINib(nibName: SearchInTVC.identifier, bundle: nil)
        
        let SearchWordNib = UINib(nibName: SearchWordTVC.identifier, bundle: nil)
        let NoRecentNib = UINib(nibName: NoRecentTVC.identifier, bundle: nil)
        let AllClearNib = UINib(nibName: AllClearTVC.identifier, bundle: nil)
        
        searchHistoryTableView.register(SearchWordNib, forCellReuseIdentifier: SearchWordTVC.identifier)
        searchHistoryTableView.register(NoRecentNib, forCellReuseIdentifier: NoRecentTVC.identifier)
        searchHistoryTableView.register(AllClearNib, forCellReuseIdentifier: AllClearTVC.identifier)

        
    }
    
    func checkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchEntered), name: NSNotification.Name("search"), object: nil)
    }
    
    @objc func searchEntered(notification: NSNotification) {
        let enteredText = notification.object as! String
        
        
        if enteredText.isEmpty {
            //Alert 보내주기?
            print("검색어를 입력해 주세요")
        }
        //검색어 목록 배열로 전환
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let resultArray: [RecentSearch] = Results.toArray()
        let count = resultArray.count
        
        do {
            try realm!.write {
                let searchWord = RecentSearch()
                searchWord.word = enteredText
                if (count == 0) {
                    //처음 입력 받았을때
                    realm?.add(searchWord)
                    print("검색어를 입력해 주세요")
                }
                else if (count >= 3 && (resultArray[count-1].word == enteredText || resultArray[count-2].word == enteredText || resultArray[count-3].word == enteredText)) {
                    //같은게 이미 db에 존재한다면
                    print("db 추가할 필요 없음")
                } else {
                    realm?.add(searchWord)
                    print(realm?.objects(RecentSearch.self))
                }
            }
        } catch {
            print("문제")
        }
    }
    
    func inputData(database: RecentSearch) -> RecentSearch {
        if let text = enteredText {
            database.word = text
        }
        return database
    }
    
    func checkSearchHistory(){
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let resultArray: [RecentSearch] = Results.toArray()
        let count = resultArray.count
        if (savedWords?.isEmpty == true) {
            //저장된 검색어가 아예 없는 경우
        } else if (savedWords?.count == 1) {
            //검색어 하나만 존재
            firstRecentSearch = resultArray[0].word
            
        } else if (savedWords?.count == 2) {
            //검색어 두개 존재 stack view 3개 적용
            firstRecentSearch = resultArray[0].word
            secondRecentSearch = resultArray[1].word
            
        } else {
            //세개보다 많거나 적을 경우 - stack view 3개 적용
            //realm에서 끝에 세 개 가져오기 -
            firstRecentSearch = resultArray[count-1].word
            secondRecentSearch = resultArray[count-2].word
            thirdRecentSearch = resultArray[count-3].word
        }
    }
}

extension Results {
    func toArray() -> Array<Element> {
        return self.map{$0}
    }
}

extension SearchInTVC: UITableViewDelegate {
    /* func tableView func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return 334
        case 1:
            return 537
     case 2: break
            
        default:
            return UITableView.automaticDimension
        }
    }*/
}


