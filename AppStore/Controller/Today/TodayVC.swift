//
//  TodayVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/9/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit


class TodayVC: UICollectionViewController {
    
    //MARK:- VC Properties and objects.

    private let todayReuseIdentifier                        = "todayCell"
    private let dailyListReuseIdentifier                    = "dailyCell"
    
    private var todayItemsArray                             = [todayItem]()
    private let networkManager                              = NetworkManager()
    private let dispatchGroup                               = DispatchGroup()
    private var topGrossingAppGroup                         : AppGroup?
    private var topPaidApps                                 : AppGroup?
    
    //MARK:- CollectionViewDelegate Properties and objects.
    
    private var hiddenCells                    : [TodayCVC] = []
    private var isStatusBarHidden                           = false
    
    private var optionalSelectedCell                        : TodayCVC?
    
    private var selectedCellStartingFrame                   : CGRect?
    private var fullScreenlistDetailVc                      : UINavigationController?
    private var fullScreentDetailVc                         : TodayDetailVC?
    private var cellType                                    : todayItem.cellType?
    
    
    private var topConstraint                               : NSLayoutConstraint?
    private var leadingConstraint                           : NSLayoutConstraint?
    private var heightConstraint                            : NSLayoutConstraint?
    private var widthConstraint                             : NSLayoutConstraint?
    
    private let collectionViewCellHeight                    : CGFloat = 480
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    
    //MARK:- UI Elements.

    let activityIndicator : UIActivityIndicatorView = {
        let activity                                        = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activity.color                                      = .darkGray
        activity.hidesWhenStopped                           = true
        activity.translatesAutoresizingMaskIntoConstraints  = false
        activity.startAnimating()
        return activity
    }()
    
    fileprivate func configerCollectionView() {
           let collection                                   = collectionView
           collection?.collectionViewLayout                 = UICollectionViewFlowLayout()
           collection?.delegate                             = self
           collection?.backgroundColor                      = .systemGray6
           self.collectionView!.register(TodayCVC.self, forCellWithReuseIdentifier: todayReuseIdentifier)
           self.collectionView!.register(DailyListCVC.self, forCellWithReuseIdentifier: dailyListReuseIdentifier)
       }
    //MARK:- Setting up the UI elemnts Position.
    
    fileprivate func setupConstrains() {
         activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
         activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
     }
    
    //MARK:- Data Configeration
       
       fileprivate func setTodayItemsArray() {
           self.todayItemsArray = [
               todayItem(itemTitle:"LIFE HACK", itemImage: #imageLiteral(resourceName: "garden"), itemSubtitle: "Utilizing your Time", itemDescription: "All the tools and apps you need to intelligently organize your life the right way.", itemColor: .white, itemCellType: .today )
               
               , todayItem(itemTitle: "DAILY LIST", itemSubtitle: self.topGrossingAppGroup?.title ?? "", itemDescription: "", itemColor: .white , itemCellType: .list, itemAppGroup: self.topGrossingAppGroup?.results ?? [] )
               
               , todayItem(itemTitle:"HOLIDAYS", itemImage: #imageLiteral(resourceName: "holiday"), itemSubtitle: "Travel on Budget", itemDescription: "find out all you need to know on how to travel without packing everything. ", itemColor: #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1) , itemCellType: .today)
               
               , todayItem(itemTitle: "SECOND LIST", itemSubtitle: self.topPaidApps?.title ?? "" , itemDescription: "", itemColor: .white, itemCellType: .list, itemAppGroup: self.topPaidApps?.results ?? [])
           ]
       }
       
       fileprivate func fetchData(){
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
               self.setTodayItemsArray()
               self.collectionView.reloadData()
           }
       }
       
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addingUIElemntsTotheView()
        setupConstrains()

        fetchData()
        
        configerCollectionView()
    }
    
    fileprivate func addingUIElemntsTotheView() {
          view.addSubview(activityIndicator)
      }
    
    
    //MARK:- collectionView DataSource and Delegate Methods.

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return todayItemsArray.count 
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    

}

 //MARK:- collectionView Delegate Methods.

extension TodayVC : UICollectionViewDelegateFlowLayout {
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cellType = todayItemsArray[indexPath.row].itemCellType else {return}
        self.cellType = cellType
        
        switch cellType {
        case .today:
            
            let fullScreenTodayDetailVc = TodayDetailVC()
            
            let fullScreenView = fullScreenTodayDetailVc.view!
            fullScreenView.translatesAutoresizingMaskIntoConstraints = false
            fullScreenView.layer.cornerRadius = 16
            self.fullScreentDetailVc = fullScreenTodayDetailVc
            
            fullScreenTodayDetailVc.completion = {
                self.handelRemoveRedView(gesture: UITapGestureRecognizer())
            }
            fullScreenTodayDetailVc.todayItem = todayItemsArray[indexPath.row]
            
            view.addSubview(fullScreenView)
            addChild(fullScreenTodayDetailVc)
            
            
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
            let endFrame = view.frame
            
            topConstraint = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: selectedCellStartingFrame.origin.y)
            leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: selectedCellStartingFrame.origin.x )
            heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: selectedCellStartingFrame.height)
            widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: selectedCellStartingFrame.width  )
            
            [topConstraint,leadingConstraint,heightConstraint,widthConstraint].forEach{ $0?.isActive = true }
            self.view.layoutIfNeeded()
            
            self.selectedCellStartingFrame = selectedCellStartingFrame
            
            collectionView.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.isStatusBarHidden = true
                self.setNeedsStatusBarAppearanceUpdate()
                self.topConstraint?.constant = 0
                self.leadingConstraint?.constant = 0
                self.heightConstraint?.constant = endFrame.height
                self.widthConstraint?.constant = endFrame.width
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
        case .list:
            
            let fullScreenlistDetailNavController =  UINavigationController(rootViewController: TodayAppListVC(collectionViewLayout: UICollectionViewFlowLayout()))
            let fullScreenlistDetailVC = fullScreenlistDetailNavController.topViewController as! TodayAppListVC
            
            let fullScreenView = fullScreenlistDetailNavController.view!
            view.addSubview(fullScreenView)
            addChild(fullScreenlistDetailNavController)
            self.fullScreenlistDetailVc = fullScreenlistDetailNavController
            
            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
            guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
            let endFrame = view.frame
            
            
            
            fullScreenlistDetailVC.completion = {
                self.handelRemoveRedView(gesture: UITapGestureRecognizer())
            }
            
            fullScreenlistDetailVC.todayItem = todayItemsArray[indexPath.row]
            
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50 , height: collectionViewCellHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //MARK:- Handling Events

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
        
