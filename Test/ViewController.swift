//
//  ViewController.swift
//  Test
//
//  Created by 120v on 2017/9/21.
//  Copyright © 2017年 MQ. All rights reserved.
//

import UIKit

/*
 字符串String类型更加人性化，多行字符串文字，支持Range，也算集合类型
 */

/// plist格式
let plistInfo = """
<?xml version="1.0" encoding="UTF-8"?>
    <plist version="1.0">
        <array>
            <dict>
            <key>title</key>
                <string>设置WiFi</string>
                    <key>imageName</key>
                <string>serversSet</string>
            </dict>
        </array>
    </plist>
"""


/// JSON格式
let jsonInfo = """
{
    "data": {
        "title": "String is a collection"
        "author": "23"
        "creat_at": "2017-06-13"
    }
}
"""


/*
 到目前为止，您可以参考函数而不调用它们，因为函数是Swift中的闭包。 你不能做的是保持对属性的引用，而不实际访问属性保存的底层数据。
 对Swift 4来说，令人兴奋的补充是能够引用类型的关键路径来获取/设置实例的基础值[SE-0161] ：
 */
struct Lightsaber {
    enum Color {
        case blue, green, red
    }
    let color: Color
}

class ForceUser {
    var name: String
    var lightsaber: Lightsaber
    var master: ForceUser?
    
    init(name: String, lightsaber: Lightsaber, master: ForceUser? = nil) {
        self.name = name
        self.lightsaber = lightsaber
        self.master = master
    }
}

let sidious = ForceUser(name: "Darth Sidious", lightsaber: Lightsaber(color: .red))
let obiwan = ForceUser(name: "Obi-Wan Kenobi", lightsaber: Lightsaber(color: .blue))
let anakin = ForceUser(name: "Anakin Skywalker", lightsaber: Lightsaber(color: .blue), master: obiwan)

// Create reference to the ForceUser.name key path
let nameKeyPath = \ForceUser.name

// Access the value from key path on instance
let obiwanName = obiwan[keyPath: nameKeyPath]  // "Obi-Wan Kenobi"

// Use keypath directly inline and to drill down to sub objects
let anakinSaberColor = anakin[keyPath: \ForceUser.lightsaber.color]  // blue

// Access a property on the object returned by key path
let masterKeyPath = \ForceUser.master
let anakinMasterName = anakin[keyPath: masterKeyPath]?.name  // "Obi-Wan Kenobi"


/*
词典和集合
 至于Collection类型， Set和Dictionary并不总是最直观的。 幸运的是，斯威夫特队给了他们一些非常需要的爱[SE-0165] 。
 基于序列的初始化列表首先是从一系列键值对（元组）创建一个字典的能力：
 */

let nearestStarNames = ["Proxima Centauri", "Alpha Centauri A", "Alpha Centauri B", "Barnard's Star", "Wolf 359"]
let nearestStarDistances = [4.24, 4.37, 4.37, 5.96, 7.78]

// Dictionary from sequence of keys-values
let starDistanceDict = Dictionary(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))
// ["Wolf 359": 7.78, "Alpha Centauri B": 4.37, "Proxima Centauri": 4.24, "Alpha Centauri A": 4.37, "Barnard's Star": 5.96]

/*
 到目前为止，在Swift中，为了序列化和归档您的自定义类型，您必须跳过一些环。对于class类型，您需要对NSObject进行子类化并实现NSCoding协议。
 像struct和enum这样的值类型需要许多hacks，例如创建一个可以扩展NSObject和NSCoding的子对象。
 Swift 4通过将序列化到所有三种Swift类型[SE-0166]来解决这个问题：
 */
struct CuriosityLog: Codable {
    enum Discovery: String, Codable {
        case rock, water, martian
    }
    
    var sol: Int
    var discoveries: [Discovery]
}

/*
 通用下标
 下标是使数据类型以简洁方式可访问的重要组成部分。 为了提高其有用性，下标现在可以是通用的[SE-0148] ：
 */
struct GenericDictionary<Key: Hashable, Value> {
    private var data: [Key: Value]
    
    init(data: [Key: Value]) {
        self.data = data
    }
    
    subscript<T>(key: Key) -> T? {
        return data[key] as? T
    }
}

//返回类型不仅可以是通用的，而且实际的下标类型也可以是通用的：
extension GenericDictionary {
    subscript<Keys: Sequence>(keys: Keys) -> [Value] where Keys.Iterator.Element == Key {
        var values: [Value] = []
        for key in keys {
            if let value = data[key] {
                values.append(value)
            }
        }
        return values
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: String
        //self .stringNewMethod()
        
        //MARK: - 字典
        //self.dictNewMethod()
        
        //MARK:- 归档和序列化
        //self.codeNewMethod()
        
        //MARK: - 单面范围
        //self.arrayNewMethod()
        
        //MARK: - 通用下标
        //self.generalSubscript()
        
        //MARK: - 交换给定索引值
        bubbleSort([4, 3, 2, 1, 0]) // [0, 1, 2, 3, 4]
    }
    
    //MARK: - 1.0 String
    private func stringNewMethod() {
        //1.0
        print(jsonInfo)
    
        //1.1
        print(plistInfo)
    
        //1.2
        var str = "Hello, Swift 4.0"
        print(str.characters.count) // Swift3.0写法
        print(str.count)            // Swift4.0写法
        /// 遍历
        str.forEach {
        print($0)
        }
    
    //4.0
    }
    
    // MARK: - 字典
    private func dictNewMethod() {
        
        // MARK: -重复键处理
        let favoriteStarVotes = ["Alpha Centauri A", "Wolf 359", "Alpha Centauri A", "Barnard's Star"]
        
        // Merging keys with closure for conflicts
        let mergedKeysAndValues = Dictionary(zip(favoriteStarVotes, repeatElement(1, count: favoriteStarVotes.count)), uniquingKeysWith: +) // ["Barnard's Star": 1, "Alpha Centauri A": 2, "Wolf 359": 1]
        
        // MARK: -将值<5.0过滤掉的
        let closeStars = starDistanceDict.filter { $0.value < 5.0 }
        closeStars // Dictionary: ["Proxima Centauri": 4.24, "Alpha Centauri A": 4.37, "Alpha Centauri B": 4.37]
        
        // MARK: -直接生成字典的映射值
        let mappedCloseStars = closeStars.mapValues { "\($0)" }
        mappedCloseStars // ["Proxima Centauri": "4.24", "Alpha Centauri A": "4.37", "Alpha Centauri B": "4.37"]
        
        // MARK: -字典默认值
        let siriusDistance = mappedCloseStars["Wolf 359", default: "unknown"] // "unknown"
        
        // Subscript with a default value used for mutating
        var starWordsCount: [String: Int] = [:]
        for starName in nearestStarNames {
            let numWords = starName.split(separator: " ").count
            starWordsCount[starName, default: 0] += numWords // Amazing
        }
//        starWordsCount // ["Wolf 359": 2, "Alpha Centauri B": 3, "Proxima Centauri": 2, "Alpha Centauri A": 3, "Barnard's Star": 2]
        
        // MARK: -字典分组
        let starsByFirstLetter = Dictionary(grouping: nearestStarNames) { $0.first! }
        
        // ["B": ["Barnard's Star"], "A": ["Alpha Centauri A", "Alpha Centauri B"], "W": ["Wolf 359"], "P": ["Proxima Centauri"]]
        
        // MARK: -预留容量
        starWordsCount.capacity  // 6
        starWordsCount.reserveCapacity(20) // reserves at _least_ 20 elements of capacity
        starWordsCount.capacity // 24

    }
    
    //MARK: - 归档和序列化
//    (序列化很有用处，可以直接json数据转化模型了，不依赖于第三方库YYMode,或者runtime来操作了。)
    private func codeNewMethod() {
        // Create a log entry for Mars sol 42
        let logSol42 = CuriosityLog(sol: 42, discoveries: [.rock, .rock, .rock, .rock])
        
        let jsonEncoder = JSONEncoder() // One currently available encoder
        
        // Encode the data
        let jsonData = try! jsonEncoder.encode(logSol42)
        // Create a String from the data
        let jsonString = String(data: jsonData, encoding: .utf8) // "{"sol":42,"discoveries":["rock","rock","rock","rock"]}"
        
        let jsonDecoder = JSONDecoder() // Pair decoder to JSONEncoder
        
        // Attempt to decode the data to a CuriosityLog object
        let decodedLog = try! jsonDecoder.decode(CuriosityLog.self, from: jsonData)
        decodedLog.sol         // 42
        decodedLog.discoveries // [rock, rock, rock, rock]
    }
    
    //MARK: - 单面范围
    private func arrayNewMethod() {
//        为了减少冗长度并提高可读性，标准库现在可以使用单面范围[SE-0172]来推断起始和终点索引。 派上用场的一种方法是创建一个从索引到集合的开始或结束索引的范围：
        // Collection Subscript
        var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
        let outsideAsteroidBelt = planets[4...] // Before: planets[4..<planets.endIndex]
        let firstThree = planets[..<4]          // Before: planets[planets.startIndex..<4]
        
//        无限序列
//        当起始索引为可数类型时，它们还允许您定义无限Sequence ：
        // Infinite range: 1...infinity
        var numberedPlanets = Array(zip(1..., planets))
        print(numberedPlanets) // [(1, "Mercury"), (2, "Venus"), ..., (8, "Neptune")]
        
        planets.append("Pluto")
        numberedPlanets = Array(zip(1..., planets))
        print(numberedPlanets) // [(1, "Mercury"), (2, "Venus"), ..., (9, "Pluto")]
        
//        模式匹配
//        单面范围的另一个很好的用途是模式匹配：
        // Pattern matching
        temperature(planetNumber: 3) // Earth
        
    }
    
    //模式匹配
    //单面范围的另一个很好的用途是模式匹配：
    // Pattern matching
    func temperature(planetNumber: Int) {
        switch planetNumber {
        case ...2: // anything less than or equal to 2
            print("Too hot")
        case 4...: // anything greater than or equal to 4
            print("Too cold")
        default:
            print("Justtttt right")
        }
    }
    
    //MARK: - 通用下表
//    下标是使数据类型以简洁方式可访问的重要组成部分。 为了提高其有用性，下标现在可以是通用的[SE-0148] ：
    private func generalSubscript() {
        // Dictionary of type: [String: Any]
        var earthData = GenericDictionary(data: ["name": "Earth", "population": 7500000000, "moons": 1])
        
        // Automatically infers return type without "as? String"
        let name: String? = earthData["name"]
        
        // Automatically infers return type without "as? Int"
        let population: Int? = earthData["population"]
        
        // Array subscript value
        let nameAndMoons = earthData[["moons", "name"]]        // [1, "Earth"]
        // Set subscript value
        let nameAndMoons2 = earthData[Set(["moons", "name"])]  // [1, "Earth"]

    }
    
    //MARK: - 交换给定索引值
    // Very basic bubble sort with an in-place swap
    func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
        var sortedArray = array
        for i in 0..<sortedArray.count - 1 {
            for j in 1..<sortedArray.count {
                if sortedArray[j-1] > sortedArray[j] {
                    sortedArray.swapAt(j-1, j) // New MutableCollection method
                }
            }
        }
        return sortedArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testUISearchVC(_ sender: UIButton) {
        self.navigationController?.pushViewController(MQSearchViewController(), animated: true)
    }
    
}

