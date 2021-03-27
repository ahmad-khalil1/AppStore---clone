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
    private let movingIconReuseIdentifier                    = "movingIconCell"

    
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
    private var fullScreenNAVController                     : UINavigationController?
    private var cellType                                    : todayItem.cellType?
    
    private var anchoredConstrain                           = AnchoredConstraints()
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
        self.collectionView!.register(MovingIconCVC.self, forCellWithReuseIdentifier: movingIconReuseIdentifier)

    }
    //MARK:- Setting up the UI elemnts Position.
    
    fileprivate func setupConstrains() {
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    //MARK:- Data Configeration
    
    fileprivate func setTodayItemsArray() {
        self.todayItemsArray = [
          
            todayItem(itemTitle:"LIFE HACK", itemImage: #imageLiteral(resourceName: "calendar (1) 2"), itemSubtitle: "Utilizing your Time", itemDescription: "All the tools and apps you need to intelligently organize your life the right way.", itemColor: .white, itemCellType: .today )
            
            ,  todayItem(itemTitle: "To get Things done faster", itemImage: nil, itemSubtitle: "Key to succseful productivity", itemDescription: "", itemColor:.white, itemCellType: .todayMovingIcon)
            
            
            , todayItem(itemTitle: "DAILY LIST", itemSubtitle: self.topGrossingAppGroup?.title ?? "", itemDescription: "", itemColor: .white , itemCellType: .list, itemAppGroup: self.topGrossingAppGroup?.results ?? [] )
            
            , todayItem(itemTitle:"HOLIDAYS", itemImage: #imageLiteral(resourceName: "beach-chair"), itemSubtitle: "Travel on Budget", itemDescription: "find out all you need to know on how to travel without packing everything. ", itemColor: #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1) , itemCellType: .today)
            
            , todayItem(itemTitle: "SECOND LIST", itemSubtitle: self.topPaidApps?.title ?? "" , itemDescription: "", itemColor: .white, itemCellType: .list, itemAppGroup: self.topPaidApps?.results ?? [])
        ]
    }
    
    fileprivate func fetchData(){

        
//        dispatchGroup.enter()
//        networkManager.getAppsTopGrossingFeed { (appGroup, error ) in
//            self.topGrossingAppGroup = appGroup
//            self.dispatchGroup.leave()
//        }
//        dispatchGroup.enter()
//        networkManager.getAppsTopPaidFeed { (appGroup, error) in
//            self.topPaidApps = appGroup
//            self.dispatchGroup.leave()
//        }
        dispatchGroup.enter()
        self.topPaidApps = getTodayFeed(feed: "topPaid")
        self.topGrossingAppGroup = getTodayFeed(feed: "topFree")
        self.collectionView.reloadData()

        self.dispatchGroup.leave()

        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.setTodayItemsArray()
            self.collectionView.reloadData()
        }
    }
    
    func getTodayFeed(feed: String) -> AppGroup{
        do{
            if let bundelPath = Bundle.main.path(forResource: feed , ofType: "json"){
                let jsonData = try String(contentsOfFile: bundelPath).data(using: .utf8)
                
                let parsedData = try JSONDecoder().decode(Apps_feed.self, from: jsonData!)

                let entity = parsedData.feed.entry
                var apps = [App]()
                for entity in entity {
                    let appTemp = App(name: entity.name, artistName: entity.artist, artistId: entity.id, artworkUrl100: entity.image.last, id: entity.id)
                    apps.append(appTemp)
                }
                return  AppGroup(title: String(parsedData.feed.title.dropFirst(14)) , results: apps )
            }
        }catch{
            print(error)
        }
        return AppGroup(title: "", results: [])
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
        case .todayMovingIcon:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movingIconReuseIdentifier, for: indexPath ) as! MovingIconCVC
            cell.todayitem =  todayItemsArray[indexPath.row]
            return cell
            }
    }
    
    
    
}

//MARK:- collectionView Delegate Methods.

extension TodayVC : UICollectionViewDelegateFlowLayout {
    
    
    private func showFullScreenView(_ indexPath : IndexPath , ViewController : TodayFullScreenBaseVC ) -> UIView{
        let fullScreenNC = UINavigationController(rootViewController: ViewController)
        let fullScreenVC = fullScreenNC.topViewController as! TodayFullScreenBaseVC
        let fullScreenView = fullScreenNC.view!
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        fullScreenView.layer.cornerRadius = 16
        self.fullScreenNAVController = fullScreenNC
        
        fullScreenVC.completion = {
            self.handelRemoveRedView(gesture: UITapGestureRecognizer())
        }
        fullScreenVC.todayItem = todayItemsArray[indexPath.row]
        
        view.addSubview(fullScreenView)
        addChild(fullScreenNC)
        return fullScreenView
    }
    
    private func ConstrainFullScreenView( _ indexPath : IndexPath , fullScreenView : UIView){
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
        guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
        
        self.anchoredConstrain.top = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: selectedCellStartingFrame.origin.y)
        self.anchoredConstrain.leading = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: selectedCellStartingFrame.origin.x )
        self.anchoredConstrain.height = fullScreenView.heightAnchor.constraint(equalToConstant: selectedCellStartingFrame.height)
        self.anchoredConstrain.width = fullScreenView.widthAnchor.constraint(equalToConstant: selectedCellStartingFrame.width  )
        
        
        [anchoredConstrain.top,anchoredConstrain.leading,anchoredConstrain.height,
         anchoredConstrain.width].forEach{ $0?.isActive = true }
        self.view.layoutIfNeeded()
        
        self.selectedCellStartingFrame = selectedCellStartingFrame
        
        collectionView.isUserInteractionEnabled = false
    }
    
    fileprivate func animateFullScreenView(_ endFrame: CGRect) {
        UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.isStatusBarHidden = true
            self.setNeedsStatusBarAppearanceUpdate()
            self.anchoredConstrain.top?.constant = 0
            self.anchoredConstrain.leading?.constant = 0
            self.anchoredConstrain.height?.constant = endFrame.height
            self.anchoredConstrain.width?.constant = endFrame.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cellType = todayItemsArray[indexPath.row].itemCellType else {return}
        self.cellType = cellType
        
        switch cellType {
        case .today:
            let fullScreenView = showFullScreenView(indexPath, ViewController:  TodayDetailVC())
            ConstrainFullScreenView(indexPath, fullScreenView: fullScreenView)
            let endFrame = view.frame
            animateFullScreenView(endFrame)
        case .list:
            let fullScreenView = showFullScreenView(indexPath, ViewController:  TodayAppListVC())
            ConstrainFullScreenView(indexPath, fullScreenView: fullScreenView)
            let endFrame = view.frame
            animateFullScreenView(endFrame)
        case .todayMovingIcon:
            let fullScreenView = showFullScreenView(indexPath, ViewController:  TodayDetailVC())
            ConstrainFullScreenView(indexPath, fullScreenView: fullScreenView)
            let endFrame = view.frame
            animateFullScreenView(endFrame)
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
                guard let fullScreenTodayDetailVc = self.fullScreenNAVController else {fatalError("fullScreenVc was't captured")}
                (fullScreenTodayDetailVc.topViewController as! TodayFullScreenBaseVC).collectionView.contentOffset = .zero
                self.view.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            guard let selectedCellStartingFrame = self.selectedCellStartingFrame else {return}
            self.isStatusBarHidden = false
            
            self.anchoredConstrain.top?.constant = selectedCellStartingFrame.origin.y
            self.anchoredConstrain.leading?.constant = selectedCellStartingFrame.origin.x
            self.anchoredConstrain.height?.constant = selectedCellStartingFrame.height
            self.anchoredConstrain.width?.constant = selectedCellStartingFrame.width
            
            self.view.layoutIfNeeded()
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: { _ in
            self.fullScreenNAVController?.view.removeFromSuperview()
            self.fullScreenNAVController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}

//


//            print("\(selectedCell.frame) + selectedCell.frame \n")
//            print("\(selectedCell.bounds) + selectedCell.bounds \n ")

//            print("\(selectedCellStartingFrame) + selectedCellStartingFrame \n")
//            print("\(selectedCellStartingBounds) + selectedCellStartingBounds \n")

//            print("\(fullScreenView.frame) + fullScreenView.frame" )
//            print("\(fullScreenView.superview?.convert(fullScreenView.frame, to: nil)) + fullScreenView.frame \n" )
//            print("\(fullScreenView.bounds) + fullScreenView.bounds \n" )

//
//
// let fullScreenlistDetailNavController =  UINavigationController(rootViewController: TodayAppListVC())
//            let fullScreenlistDetailVC = fullScreenlistDetailNavController.topViewController as! TodayAppListVC
//
//            let fullScreenView = fullScreenlistDetailNavController.view!
//            view.addSubview(fullScreenView)
//            addChild(fullScreenlistDetailNavController)
//            self.fullScreenlistDetailVc = fullScreenlistDetailNavController
//
//            guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
////            print("\(selectedCell.frame) + selectedCell.frame \n")
//
//            guard let selectedCellStartingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else { return }
////            print("\(selectedCellStartingFrame) + selectedCellStartingFrame \n")
//
//            let endFrame = view.frame
//
//
//
//            fullScreenlistDetailVC.completion = {
//                self.handelRemoveRedView(gesture: UITapGestureRecognizer())
//            }
//
//            fullScreenlistDetailVC.todayItem = todayItemsArray[indexPath.row]
//
//            fullScreenView.translatesAutoresizingMaskIntoConstraints = false
//            self.anchoredConstrain.top = fullScreenView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: selectedCellStartingFrame.origin.y)
//            self.anchoredConstrain.leading = fullScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: selectedCellStartingFrame.origin.x )
//            self.anchoredConstrain.height = fullScreenView.heightAnchor.constraint(equalToConstant: selectedCellStartingFrame.height)
//            self.anchoredConstrain.width = fullScreenView.widthAnchor.constraint(equalToConstant: selectedCellStartingFrame.width  )
////            print("\(fullScreenView.frame) + fullScreenView.frame" )
////            print("\(fullScreenView.superview?.convert(fullScreenView.frame, to: nil)) + fullScreenView.frame \n" )
////
//
//            [self.anchoredConstrain.top,self.anchoredConstrain.leading,self.anchoredConstrain.height,
//             self.anchoredConstrain.width].forEach{ $0?.isActive = true }
//            self.view.layoutIfNeeded()
//
//            self.selectedCellStartingFrame = selectedCellStartingFrame
//            //        redView.frame = startingFrame
//            fullScreenView.layer.cornerRadius = 16
//
//
//            collectionView.isUserInteractionEnabled = false
//
//            UIView.animate(withDuration: 0.7 , delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.isStatusBarHidden = true
//                self.setNeedsStatusBarAppearanceUpdate()
//                //            fullScreenView.frame = endFrame
//                //            fullScreenView.layer.cornerRadius = 0
//                self.anchoredConstrain.top?.constant = 0
//                self.anchoredConstrain.leading?.constant = 0
//                self.anchoredConstrain.height?.constant = endFrame.height
//                self.anchoredConstrain.width?.constant = endFrame.width
//                self.view.layoutIfNeeded()
//            }, completion: nil)
