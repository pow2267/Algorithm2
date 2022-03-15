//
//  [프로그래머스] 삼각형 달팽이 모양 배열 구하기
//  ⭐️⭐️⭐️
//
//  https://programmers.co.kr/learn/courses/30/lessons/68645
//

import Foundation

func solution(_ n: Int) -> [Int] {
    var array: [[Int]] = Array(repeating: [], count: n)
    // 위-> 아래일 때 시작하는 행
    var start = 0
    // 아래 -> 위일 때 끝나는 행
    var end = 1
    // 배열에 삽입되는 숫자
    var num = 1
    // 가장 끝 배열의 크기
    var floor = n - 1
    // 몇 번 반복되고 있는지
    var rep = 0
    // 마지막 숫자
    var endNum = 0
    
    for i in 1...n {
        endNum += i
    }
    
    for i in 0..<array.count {
        array[i] = Array(repeating: 0, count: i + 1)
    }
    
    while true {
        // 위에서 아래로 내려갈 때
        for i in start...floor {
            array[i][rep] = num
            
            if num != endNum {
                num += 1
            } else {
                return makeArray(array)
            }
        }
        
        // 옆으로 이동할 때
        for i in rep+1...floor-rep {
            array[floor][i] = num
            
            if num != endNum {
                num += 1
            } else {
                return makeArray(array)
            }
        }
        
        // 아래에서 위로 올라갈 때
        for i in stride(from: floor-1, to: end-1, by: -1) {
            array[i][i-rep] = num
            
            if num != endNum {
                num += 1
            } else {
                return makeArray(array)
            }
        }
        
        rep += 1
        start += 2
        end += 2
        floor -= 1
    }
    
    return makeArray(array)
}

func makeArray(_ array: [[Int]]) -> [Int] {
    var result: [Int] = []
    array.forEach({ result += $0 })
    
    return result
}
