//
//  SettingViewController.swift
//  Timer-Weather
//
//  Created by JINGLUO on 21/3/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingViewController: UITableViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var showWeatherSwitch: UISwitch!
    @IBOutlet weak var show5DaysWeatherSwitch: UISwitch!
    @IBOutlet weak var showLocationSwitch: UISwitch!
    @IBOutlet weak var showDateSwitch: UISwitch!
    @IBOutlet weak var disableIdleTimerSwitch: UISwitch!

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInitialData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorString = Preferences.sharedInstance.getBackground()
        let bgColor = UIColor().hexStringToUIColor(hex: colorString)
        navigationBar.barTintColor = bgColor
        self.tableView.backgroundColor = bgColor
    
        if Preferences.sharedInstance.getWatchFace() >= 8 {
            showDateSwitch.isEnabled = true
        } else {
            showDateSwitch.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectionViewController
        switch segue.identifier {
        case "showDateFormat":
            vc.selectionType = .dateFormat

        case "showWatchFace":
            vc.selectionType = .watchFace
            
        case "showBackground":
            vc.selectionType = .background
        
        default:
            break
        }
    }
    
    // MARK: Actions
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Setup Initial data
    fileprivate func setUpInitialData() {
        showWeatherSwitch.isOn = Preferences.sharedInstance.getShowWeather()
        show5DaysWeatherSwitch.isOn = Preferences.sharedInstance.getShow5DaysWeather()
        showLocationSwitch.isOn = Preferences.sharedInstance.getShowLocation()
        showDateSwitch.isOn = Preferences.sharedInstance.getShowDate()
        disableIdleTimerSwitch.isOn = Preferences.sharedInstance.getDisabelIdleTimer()
        
        showWeatherSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                Preferences.sharedInstance.setShowWeather(isOn)
                if !isOn {
                    self.show5DaysWeatherSwitch.isOn = false
                    Preferences.sharedInstance.setShow5DaysWeather(false)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        show5DaysWeatherSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                Preferences.sharedInstance.setShow5DaysWeather(isOn)
                if isOn {
                    self.showWeatherSwitch.isOn = true
                    Preferences.sharedInstance.setShowWeather(true)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        showLocationSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                Preferences.sharedInstance.setShowLocation(isOn)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)

        showDateSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                Preferences.sharedInstance.setShowDate(isOn)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        disableIdleTimerSwitch.rx.isOn.asObservable()
            .subscribe(onNext: { isOn in
                Preferences.sharedInstance.setDisabelIdleTimer(isOn)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
