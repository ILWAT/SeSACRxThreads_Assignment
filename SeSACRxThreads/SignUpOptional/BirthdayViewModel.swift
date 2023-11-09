//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 문정호 on 11/6/23.
//


import UIKit

import RxSwift
import RxCocoa



final class BirthdayViewModel{
    let birthday = BehaviorRelay<Date>(value: .now)
    let year = BehaviorRelay(value: 2022)
    let month = BehaviorRelay(value: 11)
    let day = BehaviorRelay(value: 1)
    
    let isEnable = BehaviorRelay(value: false)
    let buttonColor = BehaviorSubject(value: UIColor.red)
    
    let disposeBag = DisposeBag()
    
    init(){
        birthday
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                if let componentYear = component.year,
                   let componentMonth = component.month,
                   let componentDay = component.day {
                    owner.year.accept(componentYear)
                    owner.month.accept(componentMonth)
                    owner.day.accept(componentDay)
                    
                    let currentDate = Date()
                    let offsetComponent = Calendar.current.dateComponents([.year], from: date, to: currentDate)

                    if let offsetYear = offsetComponent.year{
                        print(offsetYear)
                        if offsetYear >= 17{
                            owner.isEnable.accept(true)
                            owner.buttonColor.onNext(.black)
                        } else {
                            owner.isEnable.accept(false)
                            owner.buttonColor.onNext(.red)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
