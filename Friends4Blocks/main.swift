//
//  [프로그래머스] 4블록 게임
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/17679
//

import Foundation

func solution(_ m: Int, _ n: Int, _ board: [String]) -> Int {
    // (i, j)를 기준으로 우측, 하단, 우하단 요소를 확인하는 로직
    // 0~m-1, 0~n-1까지 확인
    // 반복할 때마다 개수를 더한 뒤 set을 초기화
    
    var blocks: [[String]] = board.map({$0.map({String($0)})})
    var isPoped: Bool = false
    var poped: Set<String> = [] // key는 String(m+","+n)으로 설정
    var total: Int = 0
    var empty: String = "#"
    
    func popBlocks() {
        for i in 0..<m-1 {
            for j in 0..<n-1 {
                let word = blocks[i][j]
                
                if word == empty {
                    continue
                }
                
                if word == blocks[i+1][j] && word == blocks[i][j+1] && word == blocks[i+1][j+1] {
                    poped.insert("\(i),\(j)")
                    poped.insert("\(i+1),\(j)")
                    poped.insert("\(i),\(j+1)")
                    poped.insert("\(i+1),\(j+1)")
                }
            }
        }
        
        if !poped.isEmpty {
            isPoped = true
            total += poped.count
        }
        
        poped.forEach({
            let i = Int($0.components(separatedBy: ",")[0])!
            let j = Int($0.components(separatedBy: ",")[1])!
            
            blocks[i][j] = empty
        })
        
        poped = []
    }
    
    func replaceBlocks() {
        var isMoved: Bool = false
        
        repeat {
            isMoved = false
            
            for i in 0..<m-1 {
                for j in 0..<n {
                    let word = blocks[i][j]

                    if word != empty && blocks[i+1][j] == empty {
                        blocks[i+1][j] = word
                        blocks[i][j] = empty
                        isMoved = true
                    }
                }
            }
        } while isMoved
    }
    
    repeat {
        isPoped = false
        
        popBlocks()
        replaceBlocks()
    } while isPoped
    
    return total
}
