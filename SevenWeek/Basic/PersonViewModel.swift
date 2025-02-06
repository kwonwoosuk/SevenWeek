//
//  PersonViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/5/25.
//

import Foundation

class PersonViewModel {
    //
    var people: Observable<[Person]> = Observable([])
    var inputLoadButtonTapped: Observable<Void> = Observable(())
    var resetBUttonTapped = Observable(())
    
    // 테이블뷰에 보여줄 데이터
    
    
    init() {
        inputLoadButtonTapped.bind { _ in
            let newPeople =  self.generateRandomPeople()
            self.people.value.append(contentsOf: newPeople)
        }
    }
    
    let navigationTitle = "Person List"
    let resetTitle = "리셋버튼"
    let loadTitle = "로드버튼"
    
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
}
