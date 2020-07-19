//
//  TodayVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/9/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

private let todayReuseIdentifier = "todayCell"
private let dailyListReuseIdentifier = "dailyCell"

class TodayVC: UICollectionViewController {
    
//    let todayItemModal = todayItem()
    var todayItemsArray = [todayItem]()
    let networkManager = NetworkManager()
    var topGrossingAppGroup : AppGroup?
    var topPaidApps : AppGroup?
    let dispatchGroup = DispatchGroup()
    
    let activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activity.color = .darkGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        fetchData()
        
        let collection = collectionView
        collection?.collectionViewLayout = UICollectionViewFlowLayout()
        collection?.delegate = self
        collection?.backgroundColor = .systemGray6
//        collection?.contentInset = .init(top: 20 , left: 0, bottom: 20, right: 0)
        self.collectionView!.register(TodayCVC.self, forCellWithReuseIdentifier: todayReuseIdentifier)
        self.collectionView!.register(DailyListCVC.self, forCellWithReuseIdentifier: dailyListReuseIdentifier)


        
    }
    
    func fetchData(){
        dispatchGroup.enter()
        networkManager.getAppsTopGrossingFeed { (appGroup, error ) in
            self.topGrossingAppGroup = appGroup
            self.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        networkManager.getAppsTopPaidFeed { (appGroup, error) in
            self.topPaidApps = appGroup
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            
            self.todayItemsArray = [
                todayItem(itemTitle:"LIFE HACK", itemImage: #imageLiteral(resourceName: "garden"), itemSubtitle: "Utilizing your Time", itemDescription: "All the tools and apps you need to intelligently organize your life the right way.", itemColor: .white, itemCellType: .today )
                
                , todayItem(itemTitle: "DAILY LIST", itemSubtitle: self.topGrossingAppGroup?.title ?? "", itemDescription: "", itemColor: .white , itemCellType: .list, itemAppGroup: self.topGrossingAppGroup?.results ?? [] )
                
                , todayItem(itemTitle:"HOLIDAYS", itemImage: #imageLiteral(resourceName: "holiday"), itemSubtitle: "Travel on Budget", itemDescription: "find out all you need to know on how to travel without packing everything. ", itemColor: #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1) , itemCellType: .today)
                
                , todayItem(itemTitle: "SECOND LIST", itemSubtitle: self.topPaidApps?.title ?? "" , itemDescription: "", itemColor: .white, itemCellType: .list, itemAppGroup: self.topPaidApps?.results ?? [])
            ]
            
                      
            self.collectionView.reloadData()
        }
        
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return todayItemsArray.count 
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row == 2 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyListReuseIdentifier , for: indexPath) as! DailyListCVC
//            return cell
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayReuseIdentifier, for: indexPath) as! TodayCVC
//        cell.todayitem = todayItemsArray[indexPath.row]
//        return cell
        
        guard let cellType = todayItemsArray[indexPath.row].itemCellType else { return UICollectionViewCell() }
        
        switch cellType {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyListReuseIdentifier , for: indexPath) as! DailyListCVC
            cell.todayitem = todayItemsArray[indexPath.row]
            return cell
        case .today:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayReuseIdentifier, for: indexPath) as! TodayCVC
            cell.todayitem = todayItemsArray[indexPath.row]
            return cell
        }
    }

    
    private var isStatusBarHidden = false
    private var optionalSelectedCell : TodayCVC?
    private var hiddenCells: [TodayCVC] = []
    
    private var selectedCellStartingFrame: CGRect?
    private var fullScreenlistDetailVc : TodayAppListVC?
    private var fullScreentDetailVc : TodayDetailVC?
    private var cellType : todayItem.cellType?
    
    
    private var topConstraint : NSLayoutConstraint?
    private var leadingConstraint : NSLayoutConstraint?
    private var heightConstraint : NSLayoutConstraint?
    private var widthConstraint : NSLayoutConstraint?





}
// MARK: UICollectionViewDelegate
extension TodayVC : UICollectionViewDelegateFlowLayout {
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        guard let cellType = todayItemsArray[indexPath.row].itemCellType else {return}
        self.cellType = cellType
        switch cellType {
        case .today:
            
            let fullScreenTodayDetailVc = TodayDetailVC()
            
            let fullScreenView = fullScreenTodayDetailVc.view!
            view.addSubview(fullScreenView)
            addChild(fullScreenTodayDetailVc)
            self.fullScreentDetailVc = fullScreenTodayDetailVc
            
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
            let endFrame = view.frame
            
            
            
            fullScreenTodayDetailVc.completion = {
                self.handelRemoveRedView(gesture: UITapGestureRecognizer())
            }
            
            fullScreenTodayDetailVc.todayItem = todayItemsArray[indexPath.row]
            
            fullScreenView.translatesAutoresizingMaskIntoConstraints = false
            topConstraint = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: selectedCellStartingFrame.origin.y)
            leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: selectedCellStartingFrame.origin.x )
            heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: selectedCellStartingFrame.height)
            widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: selectedCellStartingFrame.width  )
            
            
            [topConstraint,leadingConstraint,heightConstraint,widthConstraint].forEach{ $0?.isActive = true }
            self.view.layoutIfNeeded()
            
            self.selectedCellStartingFrame = selectedCellStartingFrame
            //        redView.frame = startingFrame
            fullScreenView.layer.cornerRadius = 16
            
            
            collectionView.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.isStatusBarHidden = true
                self.setNeedsStatusBarAppearanceUpdate()
                //            fullScreenView.frame = endFrame
                //            fullScreenView.layer.cornerRadius = 0
                self.topConstraint?.constant = 0
                self.leadingConstraint?.constant = 0
                self.heightConstraint?.constant = endFrame.height
                self.widthConstraint?.constant = endFrame.width
                self.view.layoutIfNeeded()
            }, completion: nil)
        case .list:
            
//            let fullScreenlistDetailVc = TodayAppListVC(collectionViewLayout: UICollectionViewFlowLayout())
//
            let fullScreenlistDetailVc =  TodayAppListVC(collectionViewLayout: UICollectionViewFlowLayout())
            
            let fullScreenView = fullScreenlistDetailVc.view!
            view.addSubview(fullScreenView)
            addChild(fullScreenlistDetailVc)
            self.fullScreenlistDetailVc = fullScreenlistDetailVc
            
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
            let endFrame = view.frame
            
            
            
            fullScreenlistDetailVc.completion = {
                self.handelRemoveRedView(gesture: UITapGestureRecognizer())
            }
            
            fullScreenlistDetailVc.todayItem = todayItemsArray[indexPath.row]
            
            fullScreenView.translatesAutoresizingMaskIntoConstraints = false
            topConstraint = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: selectedCellStartingFrame.origin.y)
            leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: selectedCellStartingFrame.origin.x )
            heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: selectedCellStartingFrame.height)
            widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: selectedCellStartingFrame.width  )
            
            
            [topConstraint,leadingConstraint,heightConstraint,widthConstraint].forEach{ $0?.isActive = true }
            self.view.layoutIfNeeded()
            
            self.selectedCellStartingFrame = selectedCellStartingFrame
            //        redView.frame = startingFrame
            fullScreenView.layer.cornerRadius = 16
            
            
            collectionView.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.isStatusBarHidden = true
                self.setNeedsStatusBarAppearanceUpdate()
                //            fullScreenView.frame = endFrame
                //            fullScreenView.layer.cornerRadius = 0
                self.topConstraint?.constant = 0
                self.leadingConstraint?.constant = 0
                self.heightConstraint?.constant = endFrame.height
                self.widthConstraint?.constant = endFrame.width
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

      


//        let dailyList = TodayAppListVC(collectionViewLayout: UICollectionViewFlowLayout())
//        self.navigationController?.pushViewController(dailyList, animated: true)
    }
    
    @objc func handelRemoveRedView(gesture: UITapGestureRecognizer){
        
        if let cellTpe = self.cellType {
            if cellTpe == .today {
                guard let fullScreenTodayDetailVc = self.fullScreentDetailVc else {fatalError("fullScreenVc was't captured")}
                fullScreenTodayDetailVc.tableView.contentOffset = .zero
                self.view.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            guard let selectedCellStartingFrame = self.selectedCellStartingFrame else {return}
            self.isStatusBarHidden = false

            self.topConstraint?.constant = selectedCellStartingFrame.origin.y
            self.leadingConstraint?.constant = selectedCellStartingFrame.origin.x
            self.heightConstraint?.constant = selectedCellStartingFrame.height
            self.widthConstraint?.constant = selectedCellStartingFrame.width
            
            self.view.layoutIfNeeded()
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: { _ in
            switch self.cellType {
            case .today:
                self.fullScreentDetailVc?.view.removeFromSuperview()
                self.fullScreentDetailVc?.removeFromParent()
            case .list:
                self.fullScreenlistDetailVc?.view.removeFromSuperview()
                self.fullScreenlistDetailVc?.removeFromParent()
            case .none:
                return
            }
            self.collectionView.isUserInteractionEnabled = true

        })
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50 , height: 480 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}



//        fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelRemoveRedView)))


//        var tebBarFram = self.tabBarController?.tabBar.frame
//        let tabHeight = tebBarFram?.size.height
//        tebBarFram?.origin.y = self.view.frame.size.height + (tabHeight)!

//print("\( self.tabBarController!.tabBar.frame.origin.y ) before the y of orgin of tabBar ")
//            self.tabBarController!.tabBar.frame = tebBarFram
////            print("\(self.collectionView.frame.maxY + 200)  +   the other value ")
//            print("\( self.tabBarController!.tabBar.frame.origin.y ) after the y of orgin of tabBar ")



//            gesture.view?.frame = self.startingFrame ?? .zero
//            gesture.view?.layer.cornerRadius = 16



//        if collectionView.contentOffset.y < 0 || collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
//            print("return triggerd ")
//            return
//        }
//
//        let dampingRatio :CGFloat = 0.7
//        let intialVelocity  = CGVector.zero
//        let springParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: intialVelocity)
//        let animator = UIViewPropertyAnimator(duration: 0.5 , timingParameters: springParameters)
//
////        self.view.isUserInteractionEnabled = false
//        if let selectedCell = optionalSelectedCell {
//            isStatusBarHidden = false
//
//            animator.addAnimations {
//                selectedCell.collapse()
//                for cell in self.hiddenCells {
//                    cell.show()
//                }
//                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height+100
//            }
//            animator.addCompletion { (_) in
//                self.optionalSelectedCell = nil
//                collectionView.isScrollEnabled = true
//                self.hiddenCells.removeAll()
//            }
//
//
//        }else{
//            collectionView.isScrollEnabled = false
//            let SelectedCell = collectionView.cellForItem(at: indexPath) as! TodayCVC
//            let frameOfSelectedCell = SelectedCell.frame
//
//            hiddenCells = collectionView.visibleCells.map{$0 as! TodayCVC }.filter{ $0 != SelectedCell}
//            isStatusBarHidden = true
//
//            animator.addAnimations {
//                SelectedCell.expand(in: collectionView)
//                for cell in self.hiddenCells {
//                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
//                }
//            }
//
//            optionalSelectedCell = SelectedCell
//        }
//        animator.addAnimations {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
//        animator.startAnimation()
        
