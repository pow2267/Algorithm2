//
//  [프로그래머스] 각기 다른 무게를 가진 트럭이 모두 다리를 지날 때까지 걸리는 시간 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/42583
//

import Foundation

func solution(_ bridge_length: Int, _ weight: Int, _ truck_weights: [Int]) -> Int {
    var time = 0
    var truckIndex = 0
                // 트럭무게_트럭인덱스: 트럭의 위치
    var onBridge = Dictionary<String, Int>()
    var totalWeight = 0
    
    while truckIndex < truck_weights.count {
        time += 1
        
        // 1칸씩 앞으로 이동
        for (key, value) in onBridge {
            onBridge[key] = value + 1
            
            // 마지막 칸에 도착하면(트럭이 다리를 건너면) 총 무게에서 제외
            if value == bridge_length {
                let truckWeight = Int(key.components(separatedBy: "_")[0])!
                totalWeight -= truckWeight
                onBridge[key] = nil
            }
        }
        
        let truck = truck_weights[truckIndex]
        
        // 다리 위에 트럭이 중복으로 추가되지 않도록
        if onBridge["\(truck)_\(truckIndex)"] == nil && totalWeight + truck <= weight {
            totalWeight += truck
            onBridge["\(truck)_\(truckIndex)"] = 1
            truckIndex += 1
        }
    }
    
    // 인덱스를 다 돌고 다리 위에 남은 트럭이 있을 때
    if !onBridge.isEmpty {
        var latest = 0
    
        for (key, value) in onBridge {
            if latest == 0 {
                latest = value
            } else {
                if latest > value {
                    latest = value
                }
            }
        }

        time += (bridge_length - latest + 1)
    }
    
    return time
}
