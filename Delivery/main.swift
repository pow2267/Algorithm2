//
//  main.swift
//  Delivery
//
//  Created by kwon on 2022/03/10.
//

import Foundation

func solution(_ N: Int, _ road: [[Int]], _ k: Int) -> Int {
    var roads = Dictionary<String, Int>()
    var connected = Dictionary<Int, [Int]>()
    
    road.forEach({
        if let r = roads[String($0[0]) + "," + String($0[1])] {
            if r > $0[2] {
                roads[String($0[0]) + "," + String($0[1])] = $0[2]
            }
        } else {
            roads[String($0[0]) + "," + String($0[1])] = $0[2]
        }
        
        var c = connected[$0[0]] ?? []
        c.append($0[1])
        connected[$0[0]] = c
    })
    
    var result: Set<Int> = [1]
    
    func dfs(_ before: [Int], _ time: Int) {
        if time <= N {
            if time == N {
                before.forEach({ result.insert($0) })
            } else {
                var bef = before
                var t = time
                var last = before.last!

                if let con = connected[last] {
                    for c in con {
                        let nextTime = (roads["\(last),\(c)"] ?? roads["\(c),\(last)"])!

                        if !bef.contains(c) && nextTime <= N-time {
                            t += nextTime
                            bef.append(c)
                            dfs(bef, t)
                        } else {
                            before.forEach({ result.insert($0) })
                        }
                    }
                } else {
                    before.forEach({ result.insert($0) })
                }
            }
        }
    }

    for n in connected[1]! {
        let nextTime = (roads["\(1),\(n)"] ?? roads["\(n),\(1)"])!
        dfs([1, n], nextTime)
    }
    
    return result.count
}
