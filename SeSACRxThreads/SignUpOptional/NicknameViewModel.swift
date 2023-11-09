//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 문정호 on 11/9/23.
//

import Foundation

import RxSwift
import RxCocoa

class NicknameViewModel{
    let nickName = BehaviorSubject(value: "")
    let buttonHidden = BehaviorRelay(value: false)
    
    let disposeBag = DisposeBag()
    
    /*
     let valueCount = value.count
     if valueCount >= 2 && valueCount < 6 { return true }
     else { return false }
     */
    init(){
        nickName
            .map { value in
                value.count >= 2 && value.count < 6
            }
            .bind(with: self) { owner, value in
                print(value)
                owner.buttonHidden.accept(value)
            }
            .disposed(by: disposeBag)
    }
}
