# BusanWelfareProgram
## 부산의 사회복지 프로그램에 대한 정보를 제공하는 어플입니다. (21.09.13 ~ 09.23)

### 1. 기획
 - 워크플로우: pdf 첨부
 - UI/UX design : https://www.figma.com/proto/muCIJZBSmkrVQTy3wri48k/부산-사회복지-프로그램-어플?node-id=5%3A6&scaling=contain&page-id=0%3A1&starting-point-node-id=5%3A6

### 2. 구현
 - 필요기능: fetch 공공api data, 지역구 선택 pickerView UI custom, 선택된 지역구 UserDefaults에 저장, 지도 표시, tableView cell UI custom
 - 모델패턴: MVC 패턴

### 3. 앱스토어
 - appstore : https://apps.apple.com/kr/app/%EB%B6%80%EC%82%B0-%EC%82%AC%ED%9A%8C%EB%B3%B5%EC%A7%80-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8/id1588773594

### 4. 시현

 - 시현 영상 - https://youtu.be/AUv3TZYVvEE


 - 시현 이미지

1. 로딩
<img width="481" alt="loading" src="https://user-images.githubusercontent.com/37135479/137547407-ac005692-0b65-4fb1-8f9f-4813315627e6.png">

2. 지역선택


Custom Picker UI 정리 - https://ggasoon2.tistory.com/14


<img width="481" alt="2" src="https://user-images.githubusercontent.com/37135479/135082766-858dda15-fc5e-4a9a-894e-a897cc67192a.png">




3. tableVC
<img width="481" alt="3" src="https://user-images.githubusercontent.com/37135479/135082862-c97ee26d-aa5f-4cdc-97dd-f2ca47f462d6.png">

4. detailVC
<img width="481" alt="4" src="https://user-images.githubusercontent.com/37135479/135082944-50020e8d-f7a5-4916-a3e2-f22f271c25c2.png">   

   
### 5. 문제해결 아카이브

#### TableVC에서 requestAPI시 동작하는 indicator가 가끔씩 보이지 않는 오류가 있었습니다.   
   
```swift
// TableViewController
// MARK: 지역구가 선택 되었을 때 fetch하도록 observing 해둠

var gugun: String? {
        didSet{
            navigationItem.title = gugun
            self.indicatorView?.startAnimating()
            fetchData()
        }
    }
```   
지역선택VC에서 지역을 선택한 뒤 detailVC에 performSegue로 넘겨주었는데, 그 지역구의 값이 didSet될 때마다 data를 fetch하도록 옵저빙 해두었습니다.   
(지역구를 선택할 때 마다 TableVC의 값이 달라져야 하므로)   
   
   
   
```swift
    // SelectGugunViewController
    // MARK: - 지역구선택 VC에서 선택 시 segue로 데이터 전달
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if savedGugun == nil {
            if segue.identifier == "showInfoTableVC" {
                if let vc = segue.destination as? InfoTableViewController {
                    vc.gugun = selectGugun
                    UserDefaults.standard.set(selectGugun, forKey: "gugun")
                    vc.modalPresentationStyle = .fullScreen
                }
            }
        }
    }
```
nextVC에서 didSet이 호출되면서 fetch하기전에 indicator를 동작시키는데,   
nextVC의 view가 DidLoad 되기 전에 didSet이 호출되어 indicatorView가 nil 값인 경우가 있었습니다. (빠르게 선택할 경우)   
그래서 indicator가 동작하지 않았고 이를 해결해주기위해서 view가 didLoad된 뒤 didSet이 호출 되도록,   
nextVC인 TableVC의 viewDidLoad안에서 UserDefaults로 지역구 값을 불러오면서 didSet을 호출하여 오류를 회피하였습니다.   
(vc.gugun = selectGugun는 제거)
   


```swift
    // MARK: - TableVC의 viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gugun = UserDefaults.standard.string(forKey: "gugun")
        ...
    }
```   
이렇게 indicator가 동작하지 않던 오류를 해결하였습니다.
