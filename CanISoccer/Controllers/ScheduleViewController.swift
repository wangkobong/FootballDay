//
//  ScheduleViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/17.
//

import UIKit
import FSCalendar
import EventKit
import EventKitUI

class ScheduleViewController: UIViewController, EKEventEditViewDelegate {

    var startDate = Date()
    var endDate = Date()
    
    let store = EKEventStore()

    @IBOutlet weak var fsCalendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fsCalendar.delegate = self
        fsCalendar.locale = Locale(identifier: "ko_KR")

    }
    
   func didTapCalendar() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined, .denied:
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event) { (granted, error) in
                if granted {
                    // do stuff
                    DispatchQueue.main.async {
                        self.showEventViewController()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "캘린더 권한 설정을 거부하셨습니다", message: "권한 설정 화면으로 가시겠습니까?", okTitle: "설정으로 이동") {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
                            } else {
                                UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                            }
                        }
                    }
                }
            }
        case .authorized:
            // do stuff
            DispatchQueue.main.async {
                self.showEventViewController()
            }
        default:
            break
        }

    }
    
    func showEventViewController() {
        let eventVC = EKEventEditViewController()
        eventVC.editViewDelegate = self // don't forget the delegate
        eventVC.eventStore = EKEventStore()
        
        let event = EKEvent(eventStore: eventVC.eventStore)
        event.title = "공차는 날!"
        event.startDate = startDate
        event.endDate = endDate
        
        eventVC.event = event
        
        present(eventVC, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

extension ScheduleViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.startDate = date
        self.endDate = date
        didTapCalendar()
    }
}
